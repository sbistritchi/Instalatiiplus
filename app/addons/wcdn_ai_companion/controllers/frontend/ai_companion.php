<?php

	if(!defined('AREA')) exit;
	
	if($mode == "process")
	{	
		$start_time = microtime(true);
		$max_execution_time = 50;

		while(true) 
		{
    		$elapsed_time = microtime(true) - $start_time;

    		if($elapsed_time >= $max_execution_time) 
    		{
        		break; 
    		}
		
			$content_id = db_get_field("SELECT content_id FROM ?:ai_content WHERE status = ?s ORDER BY timestamp ASC", 'P');
			
			if(empty($content_id))
			{
				break;
			}
			
			$response = fn_ai_companion_get_content($content_id);
			if($response !== false)
			{
				$content_data = json_decode($response, true);
				if(!$content_data)
				{
					db_query("UPDATE ?:ai_content SET status = ?s, response = ?s WHERE content_id = ?i", 'E', 'Response format malformed: '. $response, $content_id);
				}
				else
				{
					db_query("UPDATE ?:ai_content SET status = ?s, response = ?s, score = ?s WHERE content_id = ?i", 'D', $response, $content_data['score'], $content_id);
				}
			}

    		usleep(50000);
		}
		
		exit;
	}