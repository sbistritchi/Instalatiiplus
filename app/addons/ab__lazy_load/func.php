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
use Tygh\Providers\StorefrontProvider;
use Tygh\Registry;
if (!defined('BOOTSTRAP')) {
die('Access denied');
}
function fn_ab__ll_remove_lazy_owl($content, \Smarty_Internal_Template $template)
{
if (
$template->template_resource == 'common/image.tpl'
||
$template->template_resource == 'tygh:common/image.tpl'
) {
$lazyOwl_marker = [
'marty_tpl->tpl_vars[\'lazy_load\']->value) {?>lazyOwl<?php }?>',
];
$lazyOwl_free = 'marty_tpl->tpl_vars[\'lazy_load\']->value) {?><?php }?>';
$content = str_replace($lazyOwl_marker, $lazyOwl_free, $content);
}
return $content;
}

function fn_ab__lazy_load_init_templater_post(&$view)
{
if (AREA == 'C') {
$theme_name = Tygh::$app['storefront']->theme_name;
$addon_settings = Registry::get('addons.ab__lazy_load');
$expand = max((int) $addon_settings['expand_height'], 1);
$h_fac = max($addon_settings['expand_width'] / $expand, 0.000001);
$lazy_load_settings = [
'enable' => true,
'placeholders' => \Tygh\Addons\Ab_lazyLoad\ImagePlaceholders::instance(),
'expand' => $expand,
'h_fac' => $h_fac,
];
if (in_array($theme_name, ['abt__youpitheme', 'abt__unitheme2'])) {
if ($theme_name == 'abt__youpitheme') {
$prefix = 'abt__yt';
} elseif ($theme_name == 'abt__unitheme2') {
$prefix = 'abt__ut2';
}
$settings_func = 'fn_get_' . $prefix . '_settings';
$settings = $settings_func();
$lazy_load_settings['enable'] = \Tygh\Enum\YesNo::toBool($settings['general']['lazy_load']);
}
Tygh::$app['view']->assign('ab__ll', $lazy_load_settings);
$view->registerFilter('post', 'fn_ab__ll_remove_lazy_owl');
}
}

function fn_ab__ll_get_storefront_id($request = []){
static $storefront_id = null;
if(is_null($storefront_id)){
$storefront_id = empty($request['storefront_id'])
? 0
: (int) $request['storefront_id'];
if(!$storefront_id && AREA == 'C'){
$storefront_id = StorefrontProvider::getStorefront()->storefront_id;
}
if (fn_allowed_for('ULTIMATE')) {
$storefront_id = 0;
if (fn_get_runtime_company_id()) {
$storefront_id = StorefrontProvider::getStorefront()->storefront_id;
}
}
}
return $storefront_id;
}