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
use Tygh\Registry;
use Tygh\Themes\Themes;
use Tygh\Storage;
if (!defined('BOOTSTRAP')) {
die('Access denied');
}
function fn_ab__p_update_link($link_data, $link_id)
{
if (!empty($link_data['url']) && strpos($link_data['url'], '?') !== false) {
list($url, $query) = explode('?', trim($link_data['url']));
if (is_numeric($query) && strlen($query) == 10) {
$link_data['url'] = $url;
$link_data['use_timestamp'] = 'Y';
}
}
if (!empty($link_id)) {
db_query('UPDATE ?:ab__preload_links SET ?u WHERE link_id = ?i', $link_data, $link_id);
} else {
$link_data['company_id'] = fn_get_runtime_company_id();
$link_id = db_query('INSERT INTO ?:ab__preload_links ?e', $link_data);
}
return $link_id;
}
function fn_ab__p_delete_link($link_id)
{
db_query('DELETE FROM ?:ab__preload_links WHERE link_id = ?i', $link_id);
return true;
}
function fn_ab__p_get_links($params = [])
{
$sortings = [
'url' => '?:ab__preload_links.url',
'format' => '?:ab__preload_links.format',
'use_timestamp' => '?:ab__preload_links.use_timestamp',
'status' => '?:ab__preload_links.status',
];
$sorting = db_sort($params, $sortings, 'url', 'asc');
$fields = [
'?:ab__preload_links.*',
];
$join = '';
$condition = fn_get_company_condition('?:ab__preload_links.company_id');
if (AREA == 'C') {
$condition .= db_quote(' AND ?:ab__preload_links.status = ?s', 'A');
}
$links = db_get_hash_array('SELECT ?p FROM ?:ab__preload_links ?p WHERE 1 ?p ?p', 'link_id', implode(', ', $fields), $join, $condition, $sorting);
return $links;
}

function fn_ab__p_init_preload($content, \Smarty_Internal_Template $template)
{
if (defined('AJAX_REQUEST') || defined('AB_IMAGES_PRELOADED')) {
return $content;
}
if (strpos($content, '<!DOCTYPE html>') !== false && strpos($content, '</html>') !== false) {
$pattern = '/\<!--ab__image_preload:([^<>\s]+)(?:<(\S*)>)?--\>/s';
if (preg_match_all($pattern, $content, $matches)) {
$preload = '';
$found_images = array_unique($matches[1]);
$matches[1] = array_splice($found_images, 0, AB_P_MAX_PRELOAD_QUANTITY);
$pow = 0;
$bottom_panel_enabled = fn_is_bottom_panel_available(Tygh::$app['session']['auth']);
foreach ($matches[1] as $index => $url) {
if (empty($url)) {
continue;
}
$preload .= '<link rel="preload" href="' . $url . '" as="image" fetchpriority="high">' . PHP_EOL;
$pow += !empty($matches[2][$index]) ? max(intval($matches[2][$index]),1) : 1;
if ($pow >= 100) {
break;
}
}

$content = str_replace('</head>', $preload . '</head>', $content);
if(!$bottom_panel_enabled){
$content = str_replace($matches[0], '', $content);
}
fn_define('AB_IMAGES_PRELOADED', true);
}
}
return $content;
}

function fn_ab__preload_merge_styles_file_hash($files, $styles, $prepend_prefix, $params, $area, $css_dirs, $hash)
{
if ($area === 'C' && !empty($params['use_scheme']) && empty($prepend_prefix)) {
$prefix = 'standalone';
if (fn_is_rtl_language()) {
$prefix .= '-rtl';
}
$filename = $prefix . '.' . $hash . fn_get_storage_data('cache_id') . '.css';
$theme = Themes::areaFactory($area);
$relative_path = $theme->getThemeRelativePath() . '/css/';
$timestamp = 0;
$file = Storage::instance('assets')->getAbsolutePath($relative_path . $filename);
if (!empty($file)) {
if (file_exists($file)) {
$timestamp = fn_get_storage_data('ab__p_' . $relative_path . $filename);
} else {
$timestamp = TIME;
fn_set_storage_data('ab__p_' . $relative_path . $filename, TIME);
}
}
Registry::set('ab__preload.timestamp', $timestamp);
}
}

function fn_ab__p_get_css_timestamp()
{
return Registry::ifGet('ab__preload.timestamp', 0);
}

function fn_ab__preload_clear_cache_post($type, $extra)
{
if ($type == 'misc' || $type == 'all') {
db_query('DELETE FROM ?:storage_data WHERE data_key LIKE ?l', 'ab__p_%');
}
}

function fn_ab__preload_styles_update($that, $style_id, $style, $style_path, &$less)
{
if (Registry::get('addons.ab__preload.add_font_display') == 'Y') {
$add_string = 'font-display: swap;' . PHP_EOL;
preg_match_all('/\@font-face[\s]*{(?:(?!font-display)[^}])*}/is', $less, $m);
foreach ($m as $match) {
$fixed_match = str_replace('font-family:', $add_string . 'font-family:', $match);
$less = str_replace($match, $fixed_match, $less);
}
}
}

function ab__p_add_hook_filter($content, \Smarty_Internal_Template $template)
{
if (AREA == 'C' && $template->template_resource == 'addons/blog/hooks/pages/page_content.pre.tpl' && strpos($content, '{include file="common/image.tpl"')) {
$content = str_replace('{include file="common/image.tpl"', '{hook name="ab__preload:blog_image"}{/hook}{include file="common/image.tpl"', $content);
}
if (AREA == 'C'
&&
($template->template_resource == 'views/categories/components/subcategories.tpl' || $template->template_resource == 'tygh:views/categories/components/subcategories.tpl')
&&
(strpos($content, '{foreach from=$ssubcateg item=category name="ssubcateg"}') || strpos($content, '{foreach $ssubcateg as $category}'))) {
$content = str_replace(['{foreach from=$ssubcateg item=category name="ssubcateg"}','{foreach $ssubcateg as $category}'], ['{foreach from=$ssubcateg item=category name="ssubcateg"}{$dummy=$smarty.foreach.ssubcateg.iteration}{hook name="ab__preload:subcategory"}{/hook}', '{foreach $ssubcateg as $category}{hook name="ab__preload:subcategory"}{/hook}'], $content);
}
if (AREA == 'C' && $template->template_resource == 'blocks/static_templates/logo.tpl' && strpos($content, '{include file="common/image.tpl"')) {
$content = str_replace('{include file="common/image.tpl"', '{hook name="ab__preload:logo_image"}{/hook}{include file="common/image.tpl"', $content);
}
return $content;
}

function fn_ab__preload_init_templater_post(&$view)
{
if (AREA == 'C') {
$view->registerFilter('pre', 'ab__p_add_hook_filter');
$view->registerFilter('output', 'fn_ab__p_init_preload');
}
}

function fn_ab__preload_ab__cb_pick_banner_by_cid($combination, $layout)
{
if ($combination) {
Tygh::$app['view']->assign('ab__p_ignore_product_preload_positions', array_keys($combination))
->assign('ab__p_ignore_product_preload_layout', $layout);
}
}

function fn_ab__preload_dispatch_assign_template()
{
if (AREA == 'C') {
$theme_name = Tygh::$app['storefront']->theme_name;
$ab__preload_settings = [
'products_multicolumns' => 6,
'products_without_options' => 3,
'short_list' => 7,
'preload_main_product_image' => true,
'preload_blog_image' => Registry::get('addons.ab__preload.preload_blog_image'),
'ignore_products_multicolumns' => 0,
'ignore_products_without_options' => 0,
'ignore_short_list' => 0,
'preload_subcategories' => 5,
'subcategories_pov' => 6,
'products_multicolumns_pov' => 10,
'products_without_options_pov' => 10,
'short_list_pov' => 10,
];
if (in_array($theme_name, ['abt__youpitheme', 'abt__unitheme2'])) {
if ($theme_name == 'abt__youpitheme') {
$prefix = 'abt__yt';
} elseif ($theme_name == 'abt__unitheme2') {
$prefix = 'abt__ut2';
}
$settings_func = 'fn_get_' . $prefix . '_settings';
$device_func = 'fn_' . $prefix . '_get_device_type';
$device = $device_func();
$settings = $settings_func();
$ab__preload_settings = array_merge($ab__preload_settings, array_map(function ($elem) use ($device) {
return is_array($elem) ? $elem[$device] : $elem;
}, $settings['addons']['ab__preload']));
}
Tygh::$app['view']->assign('ab__preload_settings', $ab__preload_settings);
Tygh::$app->offsetSet('ab__total_pov', 0);
}
}
function fn_ab__p_regexp_screening($expression)
{
$replaces_old = [
'%' => '%25',
' ' => '%20',
"\t" => '%20',
"\n" => '%20',
"\r" => '%20',
'!' => '%21',
'"' => '%22',
'#' => '%23',
'$' => '%24',
'&' => '%26',
'\'' => '%27',
'(' => '%28',
')' => '%29',
'*' => '%2a',
'+' => '%2b',
'=>' => '%2c',
'-' => '%2d',
'.' => '%2e',
'/' => '%2f',
':' => '%3a',
';' => '%3b',
'<' => '%3c',
'=' => '%3d',
'>' => '%3e',
'?' => '%3f',
'@' => '%40',
'[' => '%5b',
'\\' => '%5c',
']' => '%5d',
'^' => '%5e',
'_' => '%5f',
'`' => '%60',
'{' => '%7b',
'|' => '%7c',
'}' => '%7d',
'~' => '%7e',
];
$replaces = [
'/' => '\\/',
'.' => '\\.',
'?' => '\\?',
];
return str_replace(array_keys($replaces), array_values($replaces), $expression);
}
