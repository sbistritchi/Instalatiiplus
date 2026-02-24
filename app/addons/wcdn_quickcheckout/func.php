<?php
	
	use Tygh\Registry;


	function fn_wcdn_quickcheckout_pre_place_order($cart, &$allow, $product_groups)
	{
		$allow = true;
	}


	function fn_quickcheckout_get_states()
	{
		$get_states = db_get_array("SELECT state, code FROM ?:quickcheckout_states ORDER BY state ASC");
		$states = [];
		
		foreach($get_states as $state)
		{
			$states[$state['code']] = $state['state'];
		}
		
		
		return $states;
	}
	
	function fn_quickcheckout_get_cities($state)
	{
		$state_code = fn_quickcheckout_get_state_code($state);
		$cities = db_get_fields("SELECT city FROM ?:quickcheckout_cities WHERE state LIKE ?s ORDER BY city ASC", $state_code);
		
		return $cities;
	}
	
	function fn_quickcheckout_get_state_name($state)
	{
		if(strlen($state) >= 2)
		{
			return $state;
		}
		
		return db_get_field("SELECT state FROM ?:quickcheckout_states WHERE code LIKE ?s", $state);
	}
	
	function fn_quickcheckout_get_state_code($state)
	{
		if(strlen($state) <= 2)
		{
			return $state;
		}
		
		return db_get_field("SELECT code FROM ?:quickcheckout_states WHERE state LIKE ?s", $state);
	}
	
