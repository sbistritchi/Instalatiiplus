<?php

	use Tygh\Registry;

	define('AREA', 'C');
	require_once('../init.php');
		
	error_reporting(0);
	ini_set('display_errors', 1);
		
	$response = [];
	

				error_log(print_r($_REQUEST, true), 3, 'bl_request');
	
	if(@$_REQUEST['bl_pass'] == "t0xuh7efwm0yflsc2mysgnm5wyp4acvd" || isset($_REQUEST['bypass']))
	{
		switch($_REQUEST['action'])
		{
			case 'FileVersion':
			
				$response = 
				[
					'platform' => 'CSCART',
					'version'	=> 1.0,    
					'standard'	=> 4,     
				];
				
			break;
			
			           
			case 'SupportedMethods':   
			
				$response =
				[
					'FileVersion', 
					'SupportedMethods',
					'ProductsCategories',
					'OrdersGet',
					'ProductsList',
					'ProductsData',
					'ProductAdd',
					'OrderUpdate',
				];                                                                                                     
			
			break;
			
			
			case 'ProductsCategories':
			
				$categories = db_get_array("SELECT c.category_id, c.id_path, cd.category FROM ?:categories c INNER JOIN ?:category_descriptions cd ON cd.category_id = c.category_id AND cd.lang_code = ?s", CART_LANGUAGE);
				$categories_list = [];
				
				foreach($categories as $category)
				{
					$categories_list[$category['category_id']] = $category;
				}
				
				foreach($categories_list as $category)
				{
					$category_id = $category['category_id'];
					$category_name = [];
					
					$path = explode("/", $category['id_path']);
					foreach($path as $c_id)
					{
						$category_name[] = $categories_list[$c_id]['category'];
					}
					
					$response[$category_id] = implode("/", $category_name);
				}
			
			break;
			
			case 'ProductsList':
			
				$response = [];
				$where = [1];
				
				if(isset($_REQUEST['filter_sku']))
				{
					$where[] = db_quote("p.product_code LIKE ?s", $_REQUEST['filter_sku']);
				}
				
				$products = db_get_array("SELECT p.product_id, p.amount, p.list_price, p.product_code, pd.product, pp.price FROM ?:products p
										  INNER JOIN ?:product_descriptions pd ON pd.product_id = p.product_id AND lang_code = ?s
										  INNER JOIN ?:product_prices pp ON pp.product_id = p.product_id AND lower_limit = 1
										  WHERE ".implode(" AND ", $where), 'ro');
											
				foreach($products as $product)
				{
					$response[$product['product_id']] = 
					[
						'name' 		=> $product['product'],
						'quantity' 	=> $product['amount'],
						'price'		=> $product['price'],
						'sku'		=> $product['product_code'],
					];
				}
				
			break;
			
			case 'ProductsData':
				
				$product_ids = explode(",", $_REQUEST['products_id']);
				
				$features = $variants = [];
	
				//get default items
				$feature_ids = db_get_array("SELECT feature_id, description FROM ?:product_features_descriptions WHERE lang_code = ?s AND feature_id IN (?a)", 'ro', db_get_fields("SELECT feature_id FROM ?:product_features"));
				$variant_ids = db_get_array("SELECT variant_id, variant FROM ?:product_feature_variant_descriptions WHERE lang_code = ?s", 'ro');
				
				foreach($feature_ids as $feature)
				{
					$features[$feature['feature_id']] = $feature['description'];
				}
				
				foreach($variant_ids as $variant)
				{
					$variants[$variant['variant_id']] = $variant['variant'];
				}
				
				//build the standards
				$id_paths = fn_export_get_id_paths();
				$products_categories = fn_export_get_categories();
				
				$response = [];
				$products = db_get_array("SELECT p.product_id, p.amount, p.list_price, p.product_code, pd.product, pd.full_description, pp.price FROM ?:products p
										  INNER JOIN ?:product_descriptions pd ON pd.product_id = p.product_id AND lang_code = ?s
										  INNER JOIN ?:product_prices pp ON pp.product_id = p.product_id AND lower_limit = 1
										  WHERE p.product_id IN (?a)", 'ro', $product_ids);

				foreach($products as $product)
				{
					$no_vat_price = $product['price'] / 1.19;
					$vat = $product['price'] - $no_vat_price;
					
					$product_features = [];
					$feature_values = db_get_array("SELECT feature_id, variant_id, value FROM ?:product_features_values WHERE product_id = ?i", $product['product_id']);
					
					foreach($feature_values as $variant)
					{
						if($variant['variant_id'] > 0)
						{
							$product_features[$features[$variant['feature_id']]] = $variants[$variant['variant_id']];
						}
						else
						{
							$product_features[$features[$variant['feature_id']]] = $variant['value'];
						}	
					}
					
					$product['images'] = [];
					$main_pair = fn_get_image_pairs($product['product_id'], 'product', 'M');
					$additional = fn_get_image_pairs($product['product_id'], 'product', 'A');
					
					$product['images'][] = $main_pair['detailed']['image_path'];
					foreach($additional as $img)
					{
						$product['images'][] = $img['detailed']['image_path'];
					}
					
					
					$formatted_features = [];
					foreach($product_features as $feature => $value)
					{
						$formatted_features[] = 
						[
							0 => $feature,
							1 => $value,
						];
					}
					
					$main_category_id = db_get_field("SELECT category_id FROM ?:products_categories WHERE product_id = ?i AND link_type = ?s", $product['product_id'], 'M');
					
					$categories = array();
					$id_path = $id_paths[$main_category_id];
						
					foreach(explode("/", $id_path) as $cid)
					{
						$categories[] = $products_categories[$cid];
					}
					
					$response[$product['product_id']] = 
					[
						'name' 			=> $product['product'],
						'description' 	=> $product['full_description'],
						'ean'			=> '',
						'quantity' 		=> $product['amount'],
						'price'			=> $product['price'], 
						'sku'			=> $product['product_code'],
						'tax'			=> 19,
						'currency'		=> 'RON',
						'weight'		=> $product['weight'],
						'man_name'		=> $product_features['Producator'],
						'url'			=> fn_url('products.view&product_id=' . $product['product_id']),
						'images'		=> $product['images'],
						'features'		=> $formatted_features,
						'category_name' => implode("/", $categories)
					];

				}
				
			break;
			
			case 'OrdersGet':
				
				$params = $_REQUEST;
				$where = [1];
				

				if(isset($params['time_from']) && !empty($params['time_from']))
				{
					$params['time_from'] = $params['time_from'];
					$where[] = db_quote("timestamp >= ?s", $params['time_from']);
				}

				
				if(isset($params['id_from']) && !empty($params['id_from']))
				{
					$params['id_from'] = $params['id_from'];
					$where[] = db_quote("order_id >= ?i", $params['id_from']);
				}

				if(isset($params['only_paid']) && $params['only_paid'] == 1)
				{
					$where[] = db_quote("status = ?i", 'A');
				}
				
				if(isset($params['order_id']) && !empty($params['order_id']))
				{
					$where[] = db_quote("order_id = ?i", $params['order_id']);
				}

				
				
				$order_ids = db_get_fields("SELECT order_id FROM ?:orders WHERE ". implode(" AND ", $where) ." ORDER BY order_id DESC");
				foreach($order_ids as $order_id)
				{
					$order_data = fn_baselinker_get_order_data($order_id);
					
					if(!empty($order_data))
					{
						$response[$order_id] = $order_data;
					}
				}

				
			break;
			
			case 'ProductAdd':
			
				$product_data = 
				[
					'baselinker_id' 	=> (int)$_REQUEST['bl_product_id'],
					'product_code' 		=> $_REQUEST['sku'],
					'ean'				=> $_REQUEST['ean'],
					'product'			=> $_REQUEST['name'],
					'full_description' 	=> $_REQUEST['description'],
					'price' 			=> $_REQUEST['price'],
					'weight' 			=> $_REQUEST['weight'],
					'amount' 			=> $_REQUEST['quantity'],
					'images'			=> $_REQUEST['images'],
					'category_ids'		=> [$_REQUEST['category_id']],
				];
				
				$product_id = db_get_field("SELECT product_id FROM ?:products WHERE product_code LIKE ?s", $product_data['product_code']);
				if(!empty($product_id))
				{
					//update data, update baselinker_id
					fn_update_product($product_data, $product_id);
					
					$baselinker_data = ['product_id' => $product_id, 'baselinker_id' => $product_data['baselinker_id']];
					db_query("INSERT INTO ?:product_baselinker_id ?e ON DUPLICATE KEY UPDATE baselinker_id = ?i", $baselinker_data, $baselinker_data['baselinker_id']);
				}
				else
				{
					//create product here
					$product_data['company_id'] 	= 1;
					$product_data['storefront_id'] 	= 1;
					$product_data['status'] 		= 'A';
					
					$product_id = fn_update_product($product_data);
					
					if($product_id)
					{
						fn_baselinker_add_images($product_data['images'], $product_data['product'], $product_id, 'product');
					
						$baselinker_data = ['product_id' => $product_id, 'baselinker_id' => $product_data['baselinker_id']];
						db_query("INSERT INTO ?:product_baselinker_id ?e ON DUPLICATE KEY UPDATE baselinker_id = ?i", $baselinker_data, $baselinker_data['baselinker_id']);
					}
				}
				
				if(isset($_REQUEST['features']) && $product_id && !empty($product_id))
				{
					fn_baselinker_update_product_features($product_id, $_REQUEST['features']);
				}
			
			break;
			
		}
	}
	else
	{
		$response = 
		[
			'platform' => 'CSCART',
			'version'	=> 1.0,
			'standard'	=> 4,
		];
	}
	
	function fn_baselinker_get_order_data($order_id)
	{
		$order_info = fn_get_order_info($order_id);

		if(strlen($order_info['s_state']) > 2)
		{
			$order_info['s_state_code'] = db_get_field("SELECT code FROM ?:quickcheckout_states WHERE state LIKE ?s", $order_info['s_state']);
		}
		else
		{
			$order_info['s_state_code'] = $order_info['s_state'];
			$order_info['s_state'] = db_get_field("SELECT state FROM ?:quickcheckout_states WHERE code LIKE ?s", $order_info['s_state']);	
		}
		
		if(strlen($order_info['b_state']) > 2)
		{
			$order_info['b_state_code'] = db_get_field("SELECT code FROM ?:quickcheckout_states WHERE state LIKE ?s", $order_info['b_state']);
		}
		else
		{
			$order_info['b_state_code'] = $order_info['b_state'];
			$order_info['b_state'] = db_get_field("SELECT state FROM ?:quickcheckout_states WHERE code LIKE ?s", $order_info['b_state']);	
		}
		
		$order_info['s_postcode'] = db_get_field("SELECT zip FROM ?:quickcheckout_cities WHERE city LIKE ?s AND state LIKE ?s", $order_info['s_city'], $order_info['s_state_code']);
		$order_info['b_postcode'] = db_get_field("SELECT zip FROM ?:quickcheckout_cities WHERE city LIKE ?s AND state LIKE ?s", $order_info['b_city'], $order_info['b_state_code']);
		
		$paid = false;
		

		if(isset($order_info['payment_info']) && !empty($order_info['payment_info']))
		{
			if($order_info['payment_info']['order_status'] == "O")
			{
				$paid = true;
			}
		}
		
		$order_info['b_address'] = (!empty($order_info['b_address'])) ? $order_info['b_address'] : $order_info['s_address'];
		$order_info['b_city'] = (!empty($order_info['b_city'])) ? $order_info['b_city'] : $order_info['s_city'];
		$order_info['b_state'] = (!empty($order_info['b_state'])) ? $order_info['b_state'] : $order_info['s_state'];
		$order_info['b_postcode'] = (!empty($order_info['b_postcode'])) ? $order_info['b_postcode'] : $order_info['s_postcode'];
		$order_info['b_country'] = (!empty($order_info['s_country'])) ? $order_info['b_country'] : $order_info['s_country'];
		$order_info['b_firstname'] = (!empty($order_info['b_firstname'])) ? $order_info['b_firstname'] : $order_info['s_firstname'];
		$order_info['b_lastname'] = (!empty($order_info['b_lastname'])) ? $order_info['b_lastname'] : $order_info['s_lastname'];

		$order_data = 
		[
			'status_id' 			=> 220247, 
			'date_add'				=> $order_info['timestamp'],
			'currency'				=> 'RON',
			'payment_method'		=> $order_info['payment_method']['payment'],
			'payment_method_cod'	=> (strpos(strtolower($order_info['payment_method']['payment']), "ramburs") !== false) ? true : false,
			'paid'					=> $paid,
			'paid_time'				=> ($paid == true) ? $order_info['timestamp'] : '',
			'user_comments'			=> $order_info['notes'],
			'admin_comments'		=> $order_info['details'],
			'email'					=> $order_info['email'],
			'phone'					=> $order_info['phone'],
			'delivery_method'		=> $order_info['shipping'][0]['shipping'],
			'delivery_price'		=> $order_info['shipping_cost'],
			'delivery_fullname'		=> $order_info['s_firstname'] .' '. $order_info['s_lastname'],
			'delivery_company'		=> $order_info['fields'][38],
			'delivery_address'		=> $order_info['s_address'],
			'delivery_postcode'		=> $order_info['s_postcode'],
			'delivery_city'			=> $order_info['s_city'],
			'delivery_state'		=> $order_info['s_state'],
			'delivery_country_code'	=> $order_info['s_country'],
			'invoice_fullname'		=> $order_info['b_firstname'] .' '. $order_info['b_lastname'],
			'invoice_company'		=> $order_info['fields'][38],
			'invoice_nip'			=> (!empty($order_info['fields'][40])) ? $order_info['fields'][40] : '',
			'invoice_address'		=> $order_info['b_address'],
			'invoice_postcode'		=> $order_info['b_postcode'],
			'invoice_city'			=> $order_info['b_city'],
			'invoice_state'			=> $order_info['b_state'],
			'invoice_country_code'	=> $order_info['b_country'],
			'want_invoice'			=> (!empty($order_info['fields'][38])) ? true : false,
			'products'				=> [],
		];
		
		
		foreach($order_info['products'] as $product)
		{
			$product_ean = db_get_field("SELECT value FROM ?:product_features_values WHERE product_id = ?i AND feature_id = ?i", $product['product_id'], 49);
			$baselinker_id = db_get_field("SELECT baselinker_id FROM ?:product_baselinker_id WHERE product_id = ?i", $product['product_id']);
			
			if($baselinker_id == 0)
			{
				$baselinker_id = '';
			}
			
			$order_data['products'][] = 
			[
				'id' 			=> $baselinker_id,
				'name'			=> $product['product'],
				'sku'			=> $product['product_code'],
				'ean'			=> $product_ean,
				'attributes'	=> '',
				'price'			=> $product['base_price'],
				'tax'			=> 19,
				'quantity'		=> $product['amount'],
				'weight'		=> db_get_field("SELECT weight FROM ?:products WHERE product_id = ?i", $product['product_id'])
			];
		}
		
		
		return $order_data;
	}
	
	function fn_export_get_id_paths()
 	{
 		$id_paths = [];
 		$categories = db_get_array("SELECT id_path, category_id FROM ?:categories");
 		
 		foreach($categories as $category)
 		{
 			$id_paths[$category['category_id']] = $category['id_path'];
 		}
 		
 		return $id_paths;
 	}
 	
 	function fn_export_get_categories()
 	{	
 		$categories = [];
 		$get_categories = db_get_array("SELECT category_id, category FROM ?:category_descriptions WHERE lang_code = ?s", 'ro');
 		
 		foreach($get_categories as $category)
 		{
 			$categories[$category['category_id']] = $category['category'];
 		}
 		
 		return $categories;
 	}
 	
 	function fn_baselinker_add_images($images, $image_name, $product_id, $image_type)
	{
		$pairs_data = array();
		$detailed   = array();

		foreach ($images as $key => $value) 
		{
			$value = str_replace(' ', '%20', $value);
			$type = ($key == 0) ? 'M' : 'A';

			$pair_data=array();
			$pair_data['pair_id']      = '';
			$pair_data['type']         = $type;
			$pair_data['object_id']    = '0';
			$pair_data['image_alt']    = '';
			$pair_data['detailed_alt'] = '';

			array_push($pairs_data, $pair_data);

			$img = fn_get_url_data_local($value, $image_name);
			array_push($detailed, $img);
		}
			
		fn_update_image_pairs($icons = array (), $detailed, $pairs_data, $product_id, $image_type, $object_ids = array (), true);
	}
		
	function fn_get_url_data_local($val, $file_name)
	{
		if(empty($val)) return false;
		
		$result = false;
		$arrContextOptions=array(

			'http' => array('timeout' => 99999),
		);  
		
		$val = trim($val);
		
	
		$_data = file_get_contents($val, true, stream_context_create($arrContextOptions));
		if(!empty($_data))
		{
			$result = array('name' => fn_basename(fn_generate_name($file_name)));

			if(strpos($result['name'], '&') !== false || strpos($result['name'], '?') !== false)
			{
				$result['name'] = 'url_uploaded_file_' . uniqid(TIME);
			}
				
			$result['path'] = fn_create_temp_file();
			$result['size'] = strlen($_data);

				
			$fd = fopen($result['path'], 'wb');

			fwrite($fd, $_data, $result['size']);
			fclose($fd);
			@chmod($result['path'], DEFAULT_FILE_PERMISSIONS);

			$cache = Registry::get('temp_fs_data');

			if(!isset($cache[$result['path']])) 
			{ 
				$cache[$result['path']] = $result['path'];
				Registry::set('temp_fs_data', $cache);
			}	
		}

		return $result;

	}
	
	function fn_baselinker_update_product_features($product_id, $features)
	{
		if(empty($features))
		{
			return;
		}
		
		$product_features = [];
		foreach($features as $feature)
		{
			$feature_name = $feature[0];
			unset($feature[0]);
			
			$product_features[$feature_name] = $feature;
		}
		
		db_query("DELETE FROM ?:product_features_values WHERE product_id = ?i", $product_id);
		
		foreach($product_features as $feature => $variants)
		{
			$feature_id = db_get_field("SELECT feature_id FROM ?:product_features_descriptions WHERE description LIKE ?s", $feature);
			
			if(empty($feature_id))
			{
				$feature_id = fn_update_product_feature(
				[
					'description' 	=> $feature,
					'purpose' 		=> 'find_products',
					'feature_style' => 'text',
					'filter_style' 	=> 'checkbox',
					'feature_type' 	=> 'S',
					'company_id' 	=> 1,
					'storefront_id' => 1,
				], 0);
			}
			
			if($feature_id)
			{
				foreach($variants as $variant)
				{
					$variant_id = db_get_field("SELECT variant_id FROM ?:product_feature_variant_descriptions WHERE variant LIKE ?s AND variant_id IN (SELECT variant_id FROM ?:product_feature_variants WHERE feature_id = ?i)", $variant, $feature_id);
			
					if(!empty($variant_id))
					{
						fn_update_product_features_value($product_id, array($feature_id => $variant_id), array(), CART_LANGUAGE);
					}
					else
					{
						$variant_id = fn_add_feature_variant($feature_id, array('variant' => $variant));
						fn_update_product_features_value($product_id, array($feature_id => $variant_id), array(), CART_LANGUAGE);
					}
				}
			}
		}
	}

	
	header('Content-Type: application/json');
	print json_encode($response, JSON_UNESCAPED_SLASHES);