<?php

	use Tygh\Registry;

	if (!defined('BOOTSTRAP')) { die('Access denied'); }

	fn_enable_checkout_mode();
	fn_define('ORDERS_TIMEOUT', 60);

	if (empty(Tygh::$app['session']['cart']))
	fn_clear_cart(Tygh::$app['session']['cart']);

	$cart = & Tygh::$app['session']['cart'];
	$cart['recalculate'] = true;
	$cart['calculate_shipping'] = true;
	
	if (!empty(Tygh::$app['session']['cart']['select_store'])) {
		Tygh::$app['view']->assign('select_store', Tygh::$app['session']['cart']['select_store']);
	}

	if($_SERVER['REQUEST_METHOD'] == "POST")
	{

		if($mode == "login")
		{
			fn_restore_processed_user_password($_REQUEST, $_POST);
			list($status, $user_data, $user_login, $password, $salt) = fn_auth_routines($_REQUEST, $auth);


			if ($status === false)
			{
				fn_save_post_data('user_login');
				return array(CONTROLLER_STATUS_REDIRECT, 'quickcheckout.login');
			}

			if (!empty($user_data) && !empty($password) && fn_generate_salted_password($password, $salt) == $user_data['password'])
			{
				Tygh::$app['session']->regenerateID();
				if (!empty($auth['order_ids']))
				{
					foreach ($auth['order_ids'] as $k => $v) {
						db_query("UPDATE ?:orders SET ?u WHERE order_id = ?i", array('user_id' => $user_data['user_id']), $v);
					}
				}

				fn_login_user($user_data['user_id'], true);
				fn_set_session_data(AREA . '_user_id', $user_data['user_id'], COOKIE_ALIVE_TIME);
				fn_set_session_data(AREA . '_password', $user_data['password'], COOKIE_ALIVE_TIME);


				if (AREA == 'C')
				{
					fn_set_notification('N', __('notice'), __('successful_login'));
				}

				unset(Tygh::$app['session']['cart']['edit_step']);
				return array(CONTROLLER_STATUS_REDIRECT, 'quickcheckout.checkout');
			}
			else
			{
				fn_log_event('users', 'failed_login', array (
					'user' => $user_login
				));

				$auth = array();
				fn_set_notification('E', __('error'), __('error_incorrect_login'));
				fn_save_post_data('user_login');

				return array(CONTROLLER_STATUS_REDIRECT, 'quickcheckout.login');
			}

		}
		
		if ($mode == 'place_order')
		{
			$cart = array_merge($cart, $_REQUEST);
			$cart['notes'] = $_REQUEST['customer_notes'];
			
			$status = fn_checkout_place_order($cart, $auth, $_REQUEST);
			
			if ($status == PLACE_ORDER_STATUS_TO_CART) {
				return array(CONTROLLER_STATUS_REDIRECT, 'quickcheckout.checkout');
			} elseif ($status == PLACE_ORDER_STATUS_DENIED) {
				return array(CONTROLLER_STATUS_DENIED);
			}
		}
		
		if ($mode == 'apply_coupon')
		{
			fn_trusted_vars('coupon_code');

			unset(Tygh::$app['session']['promotion_notices']);
			$cart['pending_coupon'] = strtolower(trim($_REQUEST['coupon_code']));
			$cart['recalculate'] = true;

			if (!empty($cart['chosen_shipping']))
			{
				$cart['calculate_shipping'] = true;
			}

			return array(CONTROLLER_STATUS_OK);
		}
	}
	
	if ($mode == 'delete_coupon')
	{
		fn_trusted_vars('coupon_code');
		unset($cart['coupons'][$_REQUEST['coupon_code']], $cart['pending_coupon']);
		$cart['recalculate'] = true;

		if (!empty($cart['chosen_shipping'])) {
			$cart['calculate_shipping'] = true;
		}

		return array(CONTROLLER_STATUS_OK);
	}
	
	if ($mode == 'delete' && isset($_REQUEST['cart_id']))
	{
		fn_delete_cart_product($cart, $_REQUEST['cart_id']);
		if (fn_cart_is_empty($cart) == true) {
			fn_clear_cart($cart);
		}

		fn_save_cart_content($cart, $auth['user_id']);

		$cart['recalculate'] = true;
		fn_calculate_cart_content($cart, $auth, 'A', true, 'F', true);

		if (defined('AJAX_REQUEST')) {
			fn_set_notification('N', __('notice'), __('text_product_has_been_deleted'));
		}

		return array(CONTROLLER_STATUS_REDIRECT, 'quickcheckout.checkout');

	}
	
	if($mode == "checkout")
	{
		if (fn_cart_is_empty($cart) && !isset($force_redirection) && !in_array($mode, array('clear', 'delete', 'cart', 'update', 'apply_coupon', 'shipping_estimation', 'update_shipping', 'complete')))
		{
			return array(CONTROLLER_STATUS_REDIRECT, 'index.index');
		}
		
		$payment_methods = fn_prepare_checkout_payment_methods($cart, $auth);
		if(Registry::get('settings.General.min_order_amount_type') == 'only_products' && Registry::get('settings.General.min_order_amount') > $cart['subtotal'])
		{
			Tygh::$app['view']->assign('value', Registry::get('settings.General.min_order_amount'));
			$min_amount = Tygh::$app['view']->fetch('common/price.tpl');
			fn_set_notification('W', __('notice'), __('text_min_products_amount_required') . ' ' . $min_amount);

			return array(CONTROLLER_STATUS_REDIRECT, 'index.index');
		}

		fn_add_breadcrumb(__('checkout'));

		$profile_fields = fn_get_profile_fields('O');


		$cart['user_data'] = !empty($cart['user_data']) ? $cart['user_data'] : array();

		if (!empty($_REQUEST['shipping_ids'])) {
			fn_checkout_update_shipping($cart, $_REQUEST['shipping_ids']);
		}

		if (!empty($_REQUEST['payment_id'])) {
			$cart['payment_id'] = $_REQUEST['payment_id'];
		} elseif (empty($cart['payment_id'])) {
			$params = array(
				'usergroup_ids' => $auth['usergroup_ids'],
			);
			$payments = fn_get_payments($params);
			$first_method = reset($payments);
			$cart['payment_id'] = $first_method['payment_id'];
		}

		if (isset($cart['payment_id'])) {
			$cart['payment_method_data'] = fn_get_payment_method_data($cart['payment_id']);
		}

		if($auth['user_id'] && !isset($cart['logged_in']))
		{
			$cart['user_data'] = fn_get_user_info($auth['user_id'], empty($_REQUEST['profile']), $cart['profile_id']);
			$cart['logged_in'] = true;
		}
		
		

		if (!empty($cart['extra_payment_info'])) {
			$cart['payment_info'] = empty($cart['payment_info']) ? array() : $cart['payment_info'];
			$cart['payment_info'] = array_merge($cart['payment_info'], $cart['extra_payment_info']);
		}

		$guest_checkout = !empty($cart['guest_checkout']);
	

		// Define the variable only if the profiles have not been changed and settings.General.user_multiple_profiles == Y.
		if (fn_need_shipping_recalculation($cart) == false && (!empty($cart['product_groups']) && (Registry::get('settings.General.user_multiple_profiles') != "Y" || (Registry::get('settings.General.user_multiple_profiles') == "Y" && ((isset($user_data['profile_id']) && empty($user_data['profile_id'])) || (!empty($user_data['profile_id']) && $user_data['profile_id'] == $cart['profile_id'])))) || (empty($cart['product_groups']) && Registry::get('settings.General.user_multiple_profiles') == "Y" && isset($user_data['profile_id']) && empty($user_data['profile_id'])))) {
		define('CACHED_SHIPPING_RATES', true);

			$cart['calculate_shipping'] = true;
		}
		
		if (!empty($_REQUEST['active_tab'])) {
			$active_tab = $_REQUEST['active_tab'];
			Tygh::$app['view']->assign('active_tab', $active_tab);
		}

		if (floatval($cart['total']) == 0 || !isset($cart['payment_id'])) {
			$cart['payment_id'] = 0;
		}

		$shipping_calculation_type = (Registry::get('settings.General.estimate_shipping_cost') == 'Y' || $completed_steps['step_two']) ? 'A' : 'S';

		list($cart_products, $product_groups) = fn_calculate_cart_content($cart, $auth, $shipping_calculation_type, true, 'F');

		$payment_methods = fn_prepare_checkout_payment_methods($cart, $auth);
		

		if (!empty($payment_methods)) {
			$first_methods_group = reset($payment_methods);
			$first_method = reset($first_methods_group);

			$checkout_buttons = fn_get_checkout_payment_buttons($cart, $cart_products, $auth);

			if (!empty($checkout_buttons)) {
				Tygh::$app['view']->assign('checkout_buttons', $checkout_buttons, false);
			}
		} else {
			$first_method = false;
		}


		if ($first_method && empty($cart['payment_id']) && floatval($cart['total']) != 0) {
			$cart['payment_id'] = $first_method['payment_id'];
			// recalculate cart after payment method update
			list($cart_products, $product_groups) = fn_calculate_cart_content($cart, $auth, $shipping_calculation_type, true, 'F');
		}

		if ((!empty($cart['shipping_failed']) || !empty($cart['company_shipping_failed']))) {
			if (defined('AJAX_REQUEST')) {
				fn_set_notification('W', __('warning'), __('text_no_shipping_methods'));
			}
		}

		// If shipping methods changed and shipping step is completed, display notification
		$shipping_hash = fn_get_shipping_hash($cart['product_groups']);

		if (
			Registry::get('settings.Checkout.display_shipping_step') == 'Y'
			&& !empty(Tygh::$app['session']['shipping_hash'])
			&& Tygh::$app['session']['shipping_hash'] != $shipping_hash
			&& $cart['shipping_required']
		) {
			Tygh::$app['session']['chosen_shipping'] = array();
			fn_set_notification('W', __('important'), __('text_shipping_rates_changed'));
		}

		Tygh::$app['session']['shipping_hash'] = $shipping_hash;

		fn_gather_additional_products_data($cart_products, array('get_icon' => true, 'get_detailed' => true, 'get_options' => true, 'get_discounts' => false));

		if (floatval($cart['total']) == 0) {
			$cart['payment_id'] = 0;
		}

		fn_set_hook('checkout_select_default_payment_method', $cart, $payment_methods, $completed_steps);

		if (!empty($cart['payment_id'])) {
			$payment_info = fn_get_payment_method_data($cart['payment_id']);
			Tygh::$app['view']->assign('payment_info', $payment_info);

			if (!empty($payment_info['processor_params']['iframe_mode']) && $payment_info['processor_params']['iframe_mode'] == 'Y') {
				Tygh::$app['view']->assign('iframe_mode', true);
			}
		}
		
		
		Tygh::$app['view']->assign('payment_methods', $payment_methods);

		$cart['payment_surcharge'] = 0;
		if (!empty($cart['payment_id']) && !empty($payment_info)) {
			fn_update_payment_surcharge($cart, $auth);
		}

		if (fn_allowed_for('MULTIVENDOR')) {
			Tygh::$app['view']->assign('take_surcharge_from_vendor', fn_take_payment_surcharge_from_vendor($cart['products']));
		}

		Tygh::$app['view']->assign('usergroups', fn_get_usergroups(array('type' => 'C', 'status' => 'A'), CART_LANGUAGE));
		Tygh::$app['view']->assign('countries', fn_get_simple_countries(true, CART_LANGUAGE));
		Tygh::$app['view']->assign('states', fn_get_all_states());

		Tygh::$app['view']->assign('profile_fields', $profile_fields);

		if (Registry::get('settings.General.user_multiple_profiles') == 'Y') {
			$user_profiles = fn_get_user_profiles($auth['user_id']);
			Tygh::$app['view']->assign('user_profiles', $user_profiles);
		}

		fn_checkout_summary($cart);
		
		
		if(isset($_REQUEST['user_data']))
		{
			$cart['user_data'] = $_REQUEST['user_data'];
			$cart['ship_to_another'] = $_REQUEST['ship_to_another'];
				
			fn_checkout_set_cart_profile_id($cart, $auth, null);
			list(, $redirect_params) = fn_checkout_update_steps($cart, $auth, $_REQUEST);
			
			fn_calculate_cart_content($cart, $auth, 'E', true, 'F', true);
        	fn_save_cart_content($cart, $auth['user_id']);
			
			//prevent updated notification
			fn_get_notifications();
		}


		Tygh::$app['view']->assign('user_data', $cart['user_data']);

		Tygh::$app['view']->assign('use_ajax', 'true');
		Tygh::$app['view']->assign('location', 'checkout');

		Tygh::$app['view']->assign('cart', $cart);
		Tygh::$app['view']->assign('cart_products', array_reverse($cart_products, true));
		Tygh::$app['view']->assign('product_groups', $cart['product_groups']);

		if (!empty($cart['failed_order_id']) || !empty($cart['processed_order_id'])) {
			$_ids = !empty($cart['failed_order_id']) ? $cart['failed_order_id'] : $cart['processed_order_id'];
			$_order_id = reset($_ids);

			$_payment_info = db_get_field("SELECT data FROM ?:order_data WHERE order_id = ?i AND type = 'P'", $_order_id);
			$_payment_info = !empty($_payment_info) ? unserialize(fn_decrypt_text($_payment_info)) : array();

			if (!empty($cart['failed_order_id'])) {
				$_msg = !empty($_payment_info['reason_text']) ? $_payment_info['reason_text'] : '';
				$_msg .= empty($_msg) ? __('text_order_placed_error') : '';
				fn_set_notification('O', '', $_msg);
				$cart['processed_order_id'] = $cart['failed_order_id'];
				unset($cart['failed_order_id']);
			}

			unset($_payment_info['card_number'], $_payment_info['cvv2']);
			$cart['payment_info'] = $_payment_info;
			if (!empty($cart['extra_payment_info'])) {
				$cart['payment_info'] = array_merge($cart['payment_info'], $cart['extra_payment_info']);
			}
		}
		
		$email = db_get_field("SELECT email FROM ?:users WHERE user_id = ?i", Tygh::$app['session']['auth']['user_id']);
		if ((empty($email) || Tygh::$app['session']['auth']['user_id'] == 0) && !empty(Tygh::$app['session']['cart']['user_data']['email'])) {
			$email = Tygh::$app['session']['cart']['user_data']['email'];
		}
		
		if(Registry::get('addons.newsletters.status') == "A")
		{
			$mailing_lists = db_get_hash_array("SELECT * FROM ?:subscribers INNER JOIN ?:user_mailing_lists ON ?:subscribers.subscriber_id = ?:user_mailing_lists.subscriber_id WHERE ?:subscribers.email = ?s", 'list_id', $email);
			Tygh::$app['view']->assign('user_mailing_lists', $mailing_lists);

			list($page_mailing_lists) = fn_get_mailing_lists();
			Tygh::$app['view']->assign('page_mailing_lists', $page_mailing_lists);
		}
		
		/* assign states and cities */
		$states = fn_quickcheckout_get_states();
		Tygh::$app['view']->assign('states', $states);
		
		$b_cities = fn_quickcheckout_get_cities($cart['user_data']['b_state']);
		Tygh::$app['view']->assign('b_cities', $b_cities);
		
		$s_cities = fn_quickcheckout_get_cities($cart['user_data']['s_state']);
		Tygh::$app['view']->assign('s_cities', $s_cities);
	}
	
	if($mode == "login" || $mode == "create_account")
	{
		if($auth['user_id'])
		{
			return array(CONTROLLER_STATUS_REDIRECT, 'quickcheckout.checkout');
		}
		
		$redirect_url = 'quickcheckout.checkout';
		Tygh::$app['view']->assign('redirect_url', $redirect_url);
	}
	
	if($mode == "cities")
	{
		$cities = [];
		$state = preg_replace('/[^a-zA-Z]/i', '', $_REQUEST['state']);
		
		if(!empty($state))
		{
			$cities = db_get_fields("SELECT city FROM ?:quickcheckout_cities WHERE LOWER(state) = ?s ORDER BY city ASC", strtolower($state));
		}
		
		print json_encode($cities);
		exit;
	}
	
	
	Tygh::$app['view']->assign('cart', $cart);
	Tygh::$app['view']->assign('continue_url', empty(Tygh::$app['session']['continue_url']) ? '' : Tygh::$app['session']['continue_url']);
	Tygh::$app['view']->assign('mode', $mode);
	Tygh::$app['view']->assign('payment_methods', $payment_methods);

	// Remember mode for the check shipping rates
	Tygh::$app['session']['checkout_mode'] = $mode;

?>