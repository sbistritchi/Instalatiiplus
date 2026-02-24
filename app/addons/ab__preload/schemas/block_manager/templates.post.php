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
if (isset($schema['addons/ab__fast_navigation/blocks/ab__fast_navigation/ab__fn_two_level.tpl'])) {
$theme_name = Tygh::$app['storefront']->theme_name;
$settings['enable_preload'] = [
'option_name' => 'ab__p.enable_preload',
'type' => 'checkbox',
'default_value' => 'N',
'tooltip' => __('ab__p.enable_preload.ab__fast_navigation.tooltip'),
];
$devices = in_array($theme_name, ['abt__youpitheme', 'abt__unitheme2']) ? ['desktop', 'tablet', 'mobile'] : ['desktop'];
$settings['pov_devices'] = [
'type' => 'template',
'template' => 'addons/ab__preload/views/ab__preload/components/block_manager/pov_devices.tpl',
'default_value' => 1,
'devices' => $devices,
'remove_indent' => true,
];
$schema['addons/ab__fast_navigation/blocks/ab__fast_navigation/ab__fn_two_level.tpl']['settings'] += $settings;
$schema['addons/ab__fast_navigation/blocks/ab__fast_navigation/ab__fn_one_level.tpl']['settings'] += $settings;
}
return $schema;
