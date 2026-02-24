<?php

	use Baselinker\Baselinker;

	define('AREA', 'C');
	
	require_once('../init.php');
	require_once('vendor/autoload.php');
	
	$baselinker = new Baselinker(['token' => '5012291-5036023-F6F51QOLPZ7017UCTH84NLOGBUTZQPAMGHD3IGHZFSVZZ08Q856AE6998XQPQZM6']);
	
	$orders = $baselinker->orders()->getOrders(
	[
		'date_from'					=> strtotime("-5 days"),
		'filter_order_source'		=> 'shop',
	])->toArray();
	
	$status_map = 
	[
		'220248' => 'P',
		'220249' => 'C',
		'220250' => 'I',
	];

	
	if(isset($orders['orders']))
	{
		foreach($orders['orders'] as $order)
		{
			$order_id = $order['external_order_id'];
			$order_exists = db_get_field("SELECT order_id FROM ?:orders WHERE order_id = ?i", $order_id);
			
			if(!empty($order_exists))
			{
				if(!empty($order['order_page']))
				{
					$page_components = array_filter(explode("/", $order['order_page']));
					$shipment_id = db_get_field("SELECT shipment_id FROM ?:shipments WHERE comments LIKE ?s", implode("-", array_slice($page_components, -2)));
					
					if(empty($shipment_id))
					{
						$order_info = fn_get_order_info($order_id);
						
						$shipment = array(
					
							'shipping_id' => $order_info['shipping_ids'] ?? 0,
							'tracking_number' => $order['order_page'],
							'carrier' => 'Baselinker',
							'timestamp' => time(),
							'comments' => implode("-", array_slice($page_components, -2)),
						);
						
						$shipment_id = db_query("INSERT INTO ?:shipments ?e", $shipment);
						
						foreach($order_info['products'] as $item_id => $product)
						{
							db_query("INSERT INTO ?:shipment_items VALUES (?i, ?i, ?i, ?i, ?i)", $item_id, $shipment_id, $order_id, $product['product_id'], $product['amount']);
						}
					}
				}

				
				if(isset($status_map[$order['order_status_id']]))
				{
					fn_change_order_status($order_id, $status_map[$order['order_status_id']]);
				}
			}
		}	
	}