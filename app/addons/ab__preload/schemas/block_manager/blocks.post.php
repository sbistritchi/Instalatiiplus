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
$settings['disable_first_banner_lazy_load'] = [
'option_name' => 'ab__p.disable_first_banner_lazy_load',
'type' => 'checkbox',
'default_value' => 'N',
];
$settings['pov_devices'] = [
'type' => 'template',
'template' => 'addons/ab__preload/views/ab__preload/components/block_manager/pov_devices.tpl',
'default_value' => 1,
'remove_indent' => true,
];
if(isset($schema['banners']['templates']['addons/abt__unitheme2/blocks/abt__ut2_banner_carousel_combined.tpl'])){
$schema['banners']['templates']['addons/abt__unitheme2/blocks/abt__ut2_banner_carousel_combined.tpl']['settings'] += $settings;
}
if(isset($schema['banners']['templates']['addons/abt__unitheme2/blocks/abt__ut2_banner_combined.tpl'])){
$schema['banners']['templates']['addons/abt__unitheme2/blocks/abt__ut2_banner_combined.tpl']['settings'] += $settings;
}
if(isset($schema['banners']['templates']['addons/abt__youpitheme/blocks/abt__yt_banner_carousel_combined.tpl'])){
$schema['banners']['templates']['addons/abt__youpitheme/blocks/abt__yt_banner_carousel_combined.tpl']['settings'] += $settings;
}
if(isset($schema['banners']['templates']['addons/abt__youpitheme/blocks/abt__yt_banner_combined.tpl'])){
$schema['banners']['templates']['addons/abt__youpitheme/blocks/abt__yt_banner_combined.tpl']['settings'] += $settings;
}
return $schema;
