<?php
/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2021   *
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
use Tygh\Registry;
use Tygh\Tygh;
use Tygh\Enum\Addons\Ab_antibot\BotTypes;
defined('BOOTSTRAP') || die('Access denied');
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
fn_trusted_vars('bot_data');
$suffix = '.manage';
if ($mode == 'update' || $mode == 'm_update') {
if (!empty($_REQUEST['bot_data'])) {
foreach ($_REQUEST['bot_data'] as $bot_id => $bot_data) {
fn_ab__ab_update_bot($bot_data, $bot_id);
}
fn_set_notification('N', __('notice'), __('ab__ab.bot.has_been_updated'));
}
}
if ($mode == 'delete' || $mode == 'm_delete') {
if (!empty($_REQUEST['bot_id'])) {
fn_ab__ab_delete_bot($_REQUEST['bot_id']);
}
}
if ($mode == 'update_status') {
if (!empty($_REQUEST['id']) && !empty($_REQUEST['status'])) {
fn_ab__ab_update_type_bot($_REQUEST['id'], $_REQUEST['status']);
}
exit;
}
if (!empty($_REQUEST['return_url'])) {
return [CONTROLLER_STATUS_REDIRECT, $_REQUEST['return_url']];
}
return [CONTROLLER_STATUS_OK, 'ab__ab_bots' . $suffix];
}
if ($mode == 'manage') {
list($bots, $search, $groups) = fn_ab__ab_get_bots($_REQUEST, Registry::get('settings.Appearance.admin_elements_per_page'));
Tygh::$app['view']->assign('bots', $bots);
Tygh::$app['view']->assign('search', $search);
Tygh::$app['view']->assign('bot_groups', $groups);
Tygh::$app['view']->assign('bot_types', BotTypes::getOnlyBots());
}
