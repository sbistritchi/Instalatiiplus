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
use Symfony\Component\Console\Helper\Helper;
use Tygh\Enum\NotificationSeverity;
use Tygh\Storage;
defined('BOOTSTRAP') || die('Access denied');
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
if ($mode == 'run_queue') {
fn_ab__webp_init_settings();
list($status, $converted_counter) = fn_ab__webp_run_convert_queue();
if ($status) {
if ($converted_counter) {
fn_set_notification(NotificationSeverity::NOTICE, __('notice'), __('ab__webp.images_converted', [$converted_counter]));
} else {
fn_set_notification(NotificationSeverity::NOTICE, __('notice'), __('ab__webp.images_queue_is_empty'));
}
} else {
fn_set_notification(NotificationSeverity::ERROR, __('error'), __('error'));
}
} elseif ($mode == 'delete_generated_images') {
Storage::instance('images')->deleteDir('ab__webp');
fn_set_notification(NotificationSeverity::NOTICE, __('notice'), __('ab__webp.images_deleted'));
}
}
if ($mode == 'get_size') {
if (defined('AJAX_REQUEST')) {
list($bytes_total, $total_images) = fn_ab__webp_images_dir_size_and_count();
$response = __('ab__webp.no_converted_images');
if ($total_images) {
$response = __('ab__webp.total_images', ['[total_images]' => $total_images, '[memory_used]' => Helper::formatMemory($bytes_total)]);
}
Tygh::$app['ajax']->assign('response', $response);
exit;
}
}
