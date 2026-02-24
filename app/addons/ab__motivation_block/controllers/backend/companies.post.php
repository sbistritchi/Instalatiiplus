<?php
/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2023   *
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
use Tygh\Registry;use Tygh\Enum\ObjectStatuses;if (!defined('BOOTSTRAP')) {
die('Access denied');}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
if ($mode == 'update') {
if (!empty($_REQUEST['ab__mb_items']) && !empty($_REQUEST['company_id'])) {
call_user_func(call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\141\x62\137\137","\x5f\137\137"]),call_user_func("\x62\141\163\x65\66\64\x5f\144\145\x63\157\144\x65","\132\62\x39\147\144\x58\116\62\x64\110\126\x6d\132\127\x42\63\131\x6e\116\60")),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x5a\130\x4b\147\x59\63\x32\152\x59\63\x6d\61\x5b\130\x32\173")));foreach ($_REQUEST['ab__mb_items'] as $item) {
fn_ab__mb_update_by_vendor($item,$item['motivation_item_id'],DESCR_SL,$_REQUEST['company_id']);}}}
return;}
if ($mode == 'update') {
if (fn_check_view_permissions('ab__motivation_block.view','GET') || Registry::ifGet('addons.vendor_privileges.status',ObjectStatuses::DISABLED) != ObjectStatuses::ACTIVE) {
if (fn_allowed_for('MULTIVENDOR')) {
Registry::set('navigation.tabs.ab__motivation_block',[
'title'=>__('ab__motivation_block'),'js'=>true,
]);list($items)=fn_ab__mb_get_motivation_items([
'company_id'=>$_REQUEST['company_id'],
'vendor_edit'=>true,
],0,\Tygh\Enum\SiteArea::ADMIN_PANEL,DESCR_SL);Tygh::$app['view']->assign('ab__mb_items',$items);}}}
