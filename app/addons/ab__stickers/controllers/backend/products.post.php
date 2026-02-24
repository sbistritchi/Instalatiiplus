<?php
/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2024   *
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
use Tygh\Registry;if (!defined('BOOTSTRAP')) {
die('Access denied');}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
return;}
if (call_user_func(call_user_func(call_user_func("\163\x74\162\x72\145\x76","\137\x5f\137\x5f\137\x62\141"),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\130\x56\126\x36\141\x47\154\x64\125\x32\132\x6f\141\x6e\122\x31\143\x33\157\x37\117\x32\150\x6d\144\x51\75\x3d")),call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\163\145\66\x34\137\144\145\143\x6f\144\145",call_user_func("\141\142\x5f\137\137\137\137","\142\130\x32\170\143\110\72\x6c\133\122\76\76")),"",["\141\142\137\137","\137\137\137"]),call_user_func("\142\x61\163\145\66\64\137\144\145\143\x6f\144\145","\141\155\65\170\142\130\x42\154\132\147\75\75")),"",[call_user_func(call_user_func(call_user_func(call_user_func("\142\x61\163\145\66\64\x5f\144\145\143\157\x64\145",call_user_func("\141\142\137\x5f\137\137\137","\142\130\62\x78\143\110\72\154\x5b\122\76\76")),"",["\141\142\137\137","\137\137\137"]),call_user_func("\x62\141\163\145\66\64\137\144\145\x63\157\144\145","\144\110\126\172\143\x32\132\63")),call_user_func(call_user_func(call_user_func("\142\x61\163\145\66\64\x5f\144\145\143\157\x64\145",call_user_func("\141\142\137\x5f\137\137\137","\142\130\62\x78\143\110\72\154\x5b\122\76\76")),"",["\141\x62\137\137","\137\137\137"]),call_user_func("\142\141\163\x65\66\64\137\144\145\143\157\144\x65","\116\124\144\155\144\107\112\152"))),call_user_func(call_user_func(call_user_func(call_user_func("\142\x61\163\145\66\64\x5f\144\145\143\157\x64\145",call_user_func("\141\142\137\x5f\137\137\137","\142\130\62\x78\143\110\72\154\x5b\122\76\76")),"",["\141\142\137\137","\x5f\137\137"]),call_user_func("\142\141\163\145\66\64\x5f\144\145\143\157\144\145","\144\110\x56\172\143\62\132\63")),call_user_func(call_user_func(call_user_func("\142\x61\163\145\66\64\x5f\144\145\143\157\x64\145",call_user_func("\141\142\137\x5f\137\137\137","\142\130\62\x78\143\110\72\154\x5b\122\76\76")),"",["\141\142\137\137","\137\137\137"]),call_user_func("\x62\141\163\145\66\64\137\144\145\x63\157\144\145","\132\155\126\167\132\x47\132\154\131\101\75\75")))]),call_user_func("\x61\142\x5f\137\x5f\137\x5f","\144\x6f\127\x76\145\x48\155\x75\133\x54\66\x75\143\x33\123\x6d"))) == 'update' && fn_check_permissions('ab__stickers','view','admin')) {
$tabs=Registry::get('navigation.tabs');$tabs['ab__stickers']=[
'title'=>__('ab__stickers'),'js'=>true,
];Registry::set('navigation.tabs',$tabs);
$repository=Tygh::$app['addons.ab__stickers.repository'];list($stickers,$search)=$repository->find(['get_icons'=>false,'type'=>\Tygh\Enum\Addons\Ab_stickers\StickerTypes::CONSTANT]);Tygh::$app['view']->assign('ab__stickers',$stickers);}
