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
use Tygh\Enum\YesNo;
$schema['addons']['items']['ab__preload'] = [
'is_group' => YesNo::YES,
'position' => 400,
'items' => [
'preload_subcategories' => [
'class' => 'input-large',
'type' => 'selectbox',
'position' => 80,
'value' => [
'desktop' => 7,
'tablet' => 4,
'mobile' => 4,
],
'variants' => range(0,10),
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'subcategories_pov' => [
'class' => 'input-large',
'type' => 'input',
'position' => 81,
'value' => [
'desktop' => 5,
'tablet' => 5,
'mobile' => 10,
],
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'products_multicolumns' => [
'class' => 'input-large',
'type' => 'selectbox',
'position' => 100,
'value' => [
'desktop' => 6,
'tablet' => 3,
'mobile' => 2,
],
'variants' => range(0,10),
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'products_multicolumns_pov' => [
'class' => 'input-large',
'type' => 'input',
'position' => 101,
'value' => [
'desktop' => 10,
'tablet' => 10,
'mobile' => 35,
],
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'products_without_options' => [
'class' => 'input-large',
'type' => 'selectbox',
'position' => 200,
'value' => [
'desktop' => 2,
'tablet' => 2,
'mobile' => 1,
],
'variants' => range(0,10),
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'products_without_options_pov' => [
'class' => 'input-large',
'type' => 'input',
'position' => 201,
'value' => [
'desktop' => 10,
'tablet' => 10,
'mobile' => 20,
],
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'short_list' => [
'class' => 'input-large',
'type' => 'selectbox',
'position' => 300,
'value' => [
'desktop' => 7,
'tablet' => 8,
'mobile' => 2,
],
'variants' => range(0,10),
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'short_list_pov' => [
'class' => 'input-large',
'type' => 'input',
'position' => 301,
'value' => [
'desktop' => 10,
'tablet' => 10,
'mobile' => 25,
],
'is_for_all_devices' => YesNo::NO,
'is_addon_dependent' => YesNo::YES,
],
'preload_main_product_image' => [
'type' => 'checkbox',
'position' => 400,
'value' => YesNo::YES,
'is_for_all_devices' => YesNo::YES,
],
],
];
return $schema;
