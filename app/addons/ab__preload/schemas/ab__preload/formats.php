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
$schema = [
'ttf' => [
'type' => 'font',
'mime_type' => 'font/ttf',
'label' => __('ab__preload_links.format.ttf'),
],
'woff' => [
'type' => 'font',
'mime_type' => 'font/woff',
'label' => __('ab__preload_links.format.woff'),
],
'woff2' => [
'type' => 'font',
'mime_type' => 'font/woff',
'label' => __('ab__preload_links.format.woff2'),
],
'svg' => [
'type' => 'image',
'mime_type' => 'image/svg+xml',
'label' => __('ab__preload_links.format.svg'),
],
];
return $schema;
