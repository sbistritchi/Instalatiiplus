<?php

	use Baselinker\Baselinker;

	define('AREA', 'C');
	
	require_once('../init.php');
	require_once('vendor/autoload.php');
	
	$baselinker = new Baselinker(['token' => '5012291-5036023-F6F51QOLPZ7017UCTH84NLOGBUTZQPAMGHD3IGHZFSVZZ08Q856AE6998XQPQZM6']);
		

	$i = 1;  $done = false;
	
	while($done == false)
	{
		$response = $baselinker->productCatalog()->getInventoryProductsList(47157, ['page' => $i])->toArray();

		$products_list = $response['products'];
		
		if(!empty($products_list))
		{
			foreach($products_list as $product)
			{
				$baselinker_product_id = $product['id'];
				$product_code = $product['sku'];
				
				if(!empty($product_code))
				{
					print $product_code.' => '. $baselinker_product_id."\n";
					
					$data = 
					[
						'product_id' => db_get_field("SELECT product_id FROM ?:products WHERE product_code LIKE ?s", $product_code),
						'baselinker_id' => $baselinker_product_id
					];
					db_query("INSERT IGNORE INTO ?:product_baselinker_id ?e", $data);
				}
			}
		}
		else
		{
			$done = true;
		}
		
		if($i > 100)
		{
			$done = true;
		}	
		
		$i++;
	}