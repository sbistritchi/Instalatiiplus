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
defined('BOOTSTRAP') || die('Access denied');
use Tygh\Enum\Addons\Ab_antibot\BotTypes;
$schema['central']['ab__addons']['items']['ab__antibot'] = [
'attrs' => ['class' => 'is-addon'],
'href' => 'ab__ab_bots.manage',
'position' => 100,
'subitems' => [
'ab__ab.bots.black_list' => [
'href' => 'ab__ab_bots.manage&type[]=' . BotTypes::BLACK,
'position' => 100,
],
'ab__ab.bots.white_list' => [
'href' => 'ab__ab_bots.manage&type[]=' . BotTypes::WHITE,
'position' => 200,
],
'ab__ab.help' => [
'href' => 'ab__antibot.help',
'position' => 1000,
],
],
];
return $schema;
