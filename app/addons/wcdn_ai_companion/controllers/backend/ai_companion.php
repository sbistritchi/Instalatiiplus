<?php

	if($_SERVER['REQUEST_METHOD'] == "POST")
	{
		if($mode == "update")
		{
			$template_id = (isset($_REQUEST['template_id'])) ? (int)$_REQUEST['template_id'] : 0;
			$template = $_REQUEST['template'];
			
			if($template_id)
			{
				$fields_to_update = ['template_name', 'companion_model', 'prompt', 'fields_to_include', 'fields_to_generate', 'max_tokens', 'temperature', 'top_p', 'assistant_id'];
				foreach($fields_to_update as $field)
				{
					if(isset($template[$field]))
					{
						if(in_array($field, ['fields_to_include', 'fields_to_generate']))
						{
							$template[$field] = json_encode($template[$field]);
						}
						
						db_query("UPDATE ?:ai_templates SET $field = ?s WHERE template_id = ?i", $template[$field], $template_id);
					}
				}

			}
			else
			{
				$template['fields_to_include'] = json_encode($template['fields_to_include']);
				$template['fields_to_generate'] = json_encode($template['fields_to_generate']);
				
				$template_id = db_query("INSERT INTO ?:ai_templates ?e", $template);
			}
			
			
			return [302, 'ai_companion.update&template_id='.$template_id];
		}
		
		if($mode == "generate")
		{
			$template_id = (isset($_REQUEST['ai_companion_template_id'])) ? (int)$_REQUEST['ai_companion_template_id'] : 0;
			$template = [];
			
			if($template_id)
			{
				$template = fn_companion_get_template($template_id);
			}

			
			
			if(empty($template))
			{
				$redirect_url = $_REQUEST['redirect_url'];
				
				fn_set_notification('E', '', __('ai_companion_template_not_selected'));
				return [302, $redirect_url];
			}
			
			$product_ids = $_REQUEST['product_ids'];
			
			if(!$product_ids || empty($product_ids))
			{
				$redirect_url = $_REQUEST['redirect_url'];
				
				fn_set_notification('E', '', __('ai_companion_products_not_selected'));
				return [302, $redirect_url];
			}
			
			foreach($product_ids as $product_id)
			{
				fn_ai_companion_generate_product_request($product_id, $template);
			}
			
			fn_set_notification('N', '', __('ai_companion_content_generation_started'));
			return [302, 'ai_companion.content'];
		}
	}
	
	if($mode == "templates")
	{
		$templates = fn_companion_get_templates();
		
		Tygh::$app['view']->assign('templates', $templates);
		Tygh::$app['view']->assign('page_title', __('ai_companion_templates'));
		
		Tygh::$app['view']->assign('models', 				fn_get_schema('ai_models', 'openai'));
		Tygh::$app['view']->assign('fields_to_include', 	fn_get_schema('ai_companion', 'fields_to_include'));
		Tygh::$app['view']->assign('fields_to_generate', 	fn_get_schema('ai_companion', 'fields_to_generate'));
	}
	
	if($mode == "update")
	{
		$template_id = (isset($_REQUEST['template_id'])) ? (int)$_REQUEST['template_id'] : 0;
		$template = [];
		
		if($template_id)
		{
			$template = fn_companion_get_template($template_id);
		}

		
		$template['template_id'] = $template_id;
		
		Tygh::$app['view']->assign('template', $template);
		Tygh::$app['view']->assign('page_title', __('ai_companion_templates'));
		
		Tygh::$app['view']->assign('models', 				fn_get_schema('ai_models', 'openai'));
		Tygh::$app['view']->assign('fields_to_include', 	fn_get_schema('ai_companion', 'fields_to_include'));
		Tygh::$app['view']->assign('fields_to_generate', 	fn_get_schema('ai_companion', 'fields_to_generate'));
	}
	
	if($mode == "delete_template")
	{
		fn_companion_delete_template((int)$_REQUEST['template_id']);
		return [302, 'ai_companion.templates'];
	}
	
	if($mode == "content")
	{
		$params = $_REQUEST;
		if(!isset($params['status']))
		{
			$params['status'] = 'D';
		}
		
		list($ai_content, $search) = fn_companion_get_generated_content($params);
		
		if($params['status'] == "E")
		{
			foreach($ai_content as &$content)
			{
				$content['response'] = db_get_field("SELECT response FROM ?:ai_content WHERE content_id = ?i", $content['content_id']);
			}	
		}
		
		Tygh::$app['view']->assign(
		[
			'search' 				=> $search,
			'ai_content' 			=> $ai_content,
			'page_title' 			=> __('ai_companion_generated_content'),
			'fields_to_generate'	=> fn_get_schema('ai_companion', 'fields_to_generate')
		]);
		
	}
	
	if($mode == "apply_all")
	{
		$current_status = $_REQUEST['current_status'];
		$content_data = db_get_array("SELECT content_id, product_id, response FROM ?:ai_content WHERE status = ?s", $current_status);
		
		foreach($content_data as $data)
		{
			$product_id = $data['product_id'];
			$content_id = $data['content_id'];
			
			$content = json_decode($data['response'], true);
			
			if($content && is_array($content))
			{
				unset($content['score']);
				$content = array_filter($content);
				
				fn_update_product($content, $product_id);
				db_query("UPDATE ?:ai_content SET status = ?s, applied = ?s WHERE content_id = ?i", 'A', 'Y', $content_id);
			}
		}
		
		return [302, 'ai_companion.content&status=' . $current_status];
	}
	
	if($mode == "apply_selected")
	{
		$content_ids = $_REQUEST['content_ids'];
		$current_status = $_REQUEST['current_status'];
		
		$content_data = db_get_array("SELECT content_id, product_id, response FROM ?:ai_content WHERE content_id IN (?a) AND status = ?s", $content_ids, $current_status);
		
		foreach($content_data as $data)
		{
			$product_id = $data['product_id'];
			$content_id = $data['content_id'];
			
			$content = json_decode($data['response'], true);
			
			if($content && is_array($content))
			{
				unset($content['score']);
				$content = array_filter($content);
			
				fn_update_product($content, $product_id);
				db_query("UPDATE ?:ai_content SET status = ?s, applied = ?s WHERE content_id = ?i", 'A', 'Y', $content_id);
			}
		}
		
		return [302, 'ai_companion.content&status=' . $current_status];
	}
	
	if($mode == "reload_all")
	{
		$current_status = $_REQUEST['current_status'];
		db_query("UPDATE ?:ai_content SET status = ?s, timestamp = ?s, applied = ?s WHERE status = ?s", 'P', time(), 'N', $current_status);
		
		return [302, 'ai_companion.content&status=' . $current_status];
	}
	
	if($mode == "reload_selected")
	{
		$content_ids = $_REQUEST['content_ids'];
		$current_status = $_REQUEST['current_status'];
		
		db_query("UPDATE ?:ai_content SET status = ?s, timestamp = ?s, applied = ?s WHERE content_id IN (?a) AND status = ?s", 'P', time(), 'N', $content_ids, $current_status);
		
		return [302, 'ai_companion.content&status=' . $current_status];
	}
	
	if($mode == "delete_all")
	{
		$current_status = $_REQUEST['current_status'];
		
		db_query("DELETE FROM ?:ai_content WHERE status = ?s", $current_status);
		
		return [302, 'ai_companion.content&status=' . $current_status];
	}
	
	if($mode == "delete_selected")
	{
		$content_ids = $_REQUEST['content_ids'];
		$current_status = $_REQUEST['current_status'];
		
		db_query("DELETE FROM ?:ai_content WHERE content_id IN (?a) AND status = ?s", $content_ids, $current_status);
		
		return [302, 'ai_companion.content&status=' . $current_status];
	}
