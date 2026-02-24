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
use Tygh\Enum\SiteArea;
use Tygh\Registry;
use Tygh\Storage;

function fn_ab__webp_convert_to_webp($image_data, $lazy = AB__WEBP_LAZY, $lazy_thumbnails = AB__WEBP_LAZY_THUMBNAILS)
{
static $converted = [];
$return_value = [];
if (!empty($image_data['absolute_path'])) {
foreach (['image_path', 'detailed_image_path'] as $item) {
if (empty($image_data[$item])) {
continue;
}
$original_path = fn_ab__webp_url_to_absolute($image_data[$item]);
$ext = fn_ab__webp_get_extension($image_data[$item]);
if (isset($converted[$original_path]) || !in_array(fn_strtolower($ext), ['jpg', 'jpeg','png','gif'])) {
continue;
}
$new_path = fn_ab__webp_replace_extension($original_path, 'webp');
list(, $original_path) = explode('/images/', $original_path);
list(, $webp_path) = explode('/images/', $new_path);
$webp_path = 'ab__webp/' . $webp_path;
if (!Storage::instance('images')->isExist($webp_path)) {
if ($lazy_thumbnails && !Storage::instance('images')->isExist($original_path)) {
return false;
}
if ($lazy) {
fn_ab__webp_convert_queue($original_path, $webp_path);
$return_value[] = false;
} else {
if (Storage::instance('images')->isExist($original_path)) {
if (AB__WEBP == 'gd') {
$return_value[] = fn_ab__webp_gd_convert_to_webp(fn_ab__webp_get_images_absolute_path(), $original_path, $webp_path);
} elseif (AB__WEBP == 'imagick') {
$return_value[] = fn_ab__webp_imagick_convert_to_webp(fn_ab__webp_get_images_absolute_path(), $original_path, $webp_path);
}
$converted[$original_path] = true;
} else {
$return_value[] = false;
}
}
} else {
$converted[$original_path] = true;
$return_value[] = true;
}
}
}
if(count(array_unique($return_value)) === 1) {
return current($return_value);
}
return false;
}

function fn_ab__webp_convert_queue($original_path, $webp_path, $return = false)
{
static $ab__webp_convert_queue = [];
if ($return) {
return $ab__webp_convert_queue;
}
if (!empty($original_path) && !empty($webp_path)) {
$ab__webp_convert_queue[$original_path] = $webp_path;
}

}
function fn_ab__webp_run_convert_queue()
{
$lock_time = 60 * 5;
if (!Storage::instance('assets')->isExist('ab__webp_lock') || filemtime(Storage::instance('assets')->getAbsolutePath('ab__webp_lock')) < TIME - $lock_time) {
Storage::instance('assets')->put('ab__webp_lock', [
'contents' => TIME,
'overwrite' => true,
]);
} else {
return [false, 0];
}
$queue = db_get_array('SELECT * FROM ?:ab__webp_convert_queue LIMIT ?i', AB__WEBP_CONVERT_THRESHOLD);
$images_absolute_path = fn_ab__webp_get_images_absolute_path();
$converted_counter = 0;
foreach ($queue as $queue_element) {
$original_path = $queue_element['original_path'];
$webp_path = $queue_element['webp_path'];
$last_key = $queue_element['id'];
if (!Storage::instance('images')->isExist($original_path)) {
continue;
}
if (AB__WEBP == 'gd') {
fn_ab__webp_gd_convert_to_webp($images_absolute_path, $original_path, $webp_path);
} elseif (AB__WEBP == 'imagick') {
fn_ab__webp_imagick_convert_to_webp($images_absolute_path, $original_path, $webp_path);
}
$converted_counter++;
}
if (isset($last_key)) {
db_query('DELETE FROM ?:ab__webp_convert_queue WHERE id <= ?i', $last_key);
}
Storage::instance('assets')->delete('ab__webp_lock');
return [true, $converted_counter];
}
function fn_ab__webp_get_images_in_queue_amount()
{
return db_get_field('SELECT count(*) FROM ?:ab__webp_convert_queue');
}
function fn_ab__webp_images_dir_size_and_count()
{
$bytestotal = 0;
$counttotal = 0;
$path = Storage::instance('images')->getAbsolutePath('ab__webp/');
if ($path !== false && $path != '' && file_exists($path)) {
foreach (new RecursiveIteratorIterator(new RecursiveDirectoryIterator($path, FilesystemIterator::SKIP_DOTS)) as $object) {
$bytestotal += $object->getSize();
$counttotal++;
}
}
return [$bytestotal, $counttotal];
}
function fn_ab__webp_save_queue()
{
$queue = fn_ab__webp_convert_queue('', '', true);
$insert = [];
foreach ($queue as $original_path => $webp_path) {
$insert[] = [
'path_hash' => crc32($original_path),
'original_path' => $original_path,
'webp_path' => $webp_path,
];
}
$queue = null;
db_replace_into('ab__webp_convert_queue', $insert, true);
}
function fn_ab__webp_get_images_absolute_path()
{
static $path = null;
if (is_null($path)) {
$path = Storage::instance('images')->getAbsolutePath('');
}
return $path;
}
function fn_ab__webp_replace_image_data($image_data)
{
$replace_items = [
'image_path',
'detailed_path',
'detailed_image_path',
'http_image_path',
'https_image_path',
'absolute_path',
];
foreach ($replace_items as $item) {
if (!empty($image_data[$item])) {
if (strpos($image_data[$item], '/images/ab__webp/') === false && strpos($image_data[$item], '.webp') === false) {
$image_data[$item] = fn_ab__webp_replace_extension($image_data[$item], 'webp');
$image_data[$item] = str_replace('/images/', '/images/ab__webp/', $image_data[$item]);
}
}
}
return $image_data;
}
function fn_ab__webp_get_extension($path)
{
$path_info = fn_pathinfo($path);
return isset($path_info['extension']) ? $path_info['extension'] : '';
}
function fn_ab__webp_replace_extension($path, $new_extension)
{
$path_info = fn_pathinfo($path);
$extension_parts = explode('?',$path_info['extension']);
$extension = $extension_parts[0];
$query_params = isset($extension_parts[1]) ? '?'.$extension_parts[1] : '';
return $path_info['dirname'] . '/' . $path_info['filename'] . '_' . $extension . '.' . $new_extension . $query_params;
}

function fn_ab__webp_gd_convert_to_webp($abs_path, $image_path, $webp_path)
{
if (!empty($image_path) && !empty($webp_path)) {
$mime_type = fn_get_mime_content_type($abs_path . $image_path);
switch ($mime_type) {
case 'image/jpeg':
$src = imagecreatefromjpeg($abs_path . $image_path);
break;
case 'image/png':
$src = imagecreatefrompng($abs_path . $image_path);
break;
case 'image/gif':
$src = imagecreatefromgif($abs_path . $image_path);
break;
default:
return false;
}
imagepalettetotruecolor($src);
imagealphablending($src, true);
imagesavealpha($src, true);
ob_start();
imagewebp($src, null, AB__WEBP_DEFAULT_QUANTITY);
if (ob_get_length() % 2 == 1) {
echo "\0";
}
$content = ob_get_clean();
imagedestroy($src);
Storage::instance('images')->put($webp_path, ['contents' => $content, 'caching' => true, 'overwrite' => true]);
}
return true;
}

function fn_ab__webp_imagick_convert_to_webp($abs_path, $image_path, $webp_path)
{
try {
$image = new Imagick($abs_path . $image_path);
$image->setFormat('webp');
$image->setCompressionQuality(AB__WEBP_DEFAULT_QUANTITY);
Storage::instance('images')->put($webp_path, ['contents' => $image->getImageBlob(), 'caching' => true, 'overwrite' => true]);
} catch (Exception $e) {
} finally {
$image = null;
gc_collect_cycles();
}
return true;
}
function fn_ab__webp_url_to_absolute($url)
{
static $host = null;
static $root = null;
if (is_null($host) || is_null($root)) {
$config = Registry::get('config');
$host = defined('HTTPS') ? $config['https_location'] : $config['http_location'];
$root = $config['dir']['root'];
}
$url = strtok($url, '?');
return str_replace($host, $root, $url);
}
function fn_ab__webp_init_settings()
{
define('AB__WEBP_DEFAULT_QUANTITY', Registry::get('addons.ab__webp.quality'));
define('AB__WEBP_LAZY', Registry::get('addons.ab__webp.lazy') == 'Y');
define('AB__WEBP_LAZY_THUMBNAILS', Registry::get('config.tweaks.lazy_thumbnails') == true);
if (Tygh::$app['image'] instanceof Imagine\Imagick\Imagine && Imagick::queryFormats('WEBP')) {
fn_define('AB__WEBP', 'imagick');
} elseif (function_exists('imagewebp')) {
fn_define('AB__WEBP', 'gd');
}
}

function fn_ab__webp_delete_image($image_id, $pair_id, $object_type, $image_file)
{
$image_subdir = fn_get_image_subdir($image_id);
$file_data = fn_pathinfo($image_file);
$image_file = 'ab__webp/' . $object_type . '/' . $image_subdir . '/' . $file_data['filename'] . '.webp';
Storage::instance('images')->delete($image_file);
}

function fn_ab__webp_before_dispatch()
{
if (!defined('AB__WEBP_DEFAULT_QUANTITY')
&& SiteArea::isStorefront(AREA)
&& ((isset($_SERVER['HTTP_ACCEPT'])
&& strpos($_SERVER['HTTP_ACCEPT'], 'image/webp') !== false)
|| isset(Tygh::$app['session']['ab__webp']))
) {
fn_ab__webp_init_settings();
Tygh::$app['session']['ab__webp'] = true;
if (AB__WEBP_LAZY) {
register_shutdown_function('fn_ab__webp_save_queue');
}
}
}

function fn_ab__webp_image_to_display_post(&$image_data, $images, $image_width, $image_height)
{
if (!fn_ab__webp_is_webp_allowed()) {
return true;
}
if (fn_ab__webp_convert_to_webp($image_data)) {
$image_data = fn_ab__webp_replace_image_data($image_data);
}
}

function fn_ab__webp_get_image_pairs_post($object_ids, $object_type, $pair_type, $get_icon, $get_detailed, $lang_code, &$pairs_data, $detailed_pairs, $icon_pairs)
{
if (!fn_ab__webp_is_webp_allowed()) {
return true;
}
foreach ($pairs_data as &$pairs_datum) {
foreach ($pairs_datum as &$pair_data) {
if (isset($pair_data['detailed_id'], $pair_data['detailed'])) {
if (fn_ab__webp_convert_to_webp($pair_data['detailed'])) {
$pair_data['detailed'] = fn_ab__webp_replace_image_data($pair_data['detailed']);
}
} elseif (isset($pair_data['icon'])) {
if (fn_ab__webp_convert_to_webp($pair_data['icon'])) {
$pair_data['icon'] = fn_ab__webp_replace_image_data($pair_data['icon']);
}
}
}
}
}

function fn_ab__webp_is_webp_allowed(){
return defined('AB__WEBP') && !defined('AB__WEBP_PREVENT_CONVERTING');
}

function fn_ab__webp_mailer_create_message_before(){
if(Registry::ifGet('addons.ab__webp.convert_for_email', 'Y') === 'N'){
fn_define('AB__WEBP_PREVENT_CONVERTING', true);
}
}
