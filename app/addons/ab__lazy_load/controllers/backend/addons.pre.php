<?php
/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2022   *
* / /_\ | | _____  _| |_/ /_ __ __ _ _ __   __| |_ _ __   __ _   | |_ ___  __ _ _ __ ___   *
* |  _  | |/ _ \ \/ / ___ \ '__/ _` | '_ \ / _` | | '_ \ / _` |  | __/ _ \/ _` | '_ ` _ \  *
* | | | | |  __/>  <| |_/ / | | (_| | | | | (_| | | | | | (_| |  | ||  __/ (_| | | | | | | *
* \_| |_/_|\___/_/\_\____/|_|  \__,_|_| |_|\__,_|_|_| |_|\__, |  \___\___|\__,_|_| |_| |_| *
*                                                         __/ |                            *
*                                                        |___/                             *
* ---------------------------------------------------------------------------------------- *
* This is commercial software, only users who have purchased a valid license and accept    *
* to the terms of the License Agreement can install and use this program.                  *
* ---------------------------------------------------------------------------------------- *
* website: https://cs-cart.alexbranding.com                                                *
*   email: info@alexbranding.com                                                           *
*******************************************************************************************/
defined('BOOTSTRAP') || die('Access denied');
$storefront_id = fn_ab__ll_get_storefront_id($_REQUEST);
$is_ab__lazy_load = !empty($_REQUEST['addon']) && $_REQUEST['addon'] == 'ab__lazy_load';
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
if ($mode == 'update' && $is_ab__lazy_load && $storefront_id) {
fn_attach_image_pairs('ab__ll_placeholder', 'ab__ll_placeholder', $storefront_id);
}
return [CONTROLLER_STATUS_OK];
}
if ($mode == 'update' && $is_ab__lazy_load && $storefront_id) {
Tygh::$app['view']->assign('ab__ll_placeholder', fn_get_image_pairs($storefront_id, 'ab__ll_placeholder', 'M', true, true))
->assign('ab__allowed_placeholder', true);
}
