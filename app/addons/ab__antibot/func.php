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
if (!defined('BOOTSTRAP')) {
die('Access denied');}
use Tygh\Registry;use Tygh\Enum\Addons\Ab_antibot\Modes;use Tygh\Enum\Addons\Ab_antibot\BotTypes;use Tygh\Navigation\LastView;function fn_ab__ab_install(){
$objects=[
['t'=>'?:bm_blocks',
'i'=>[
['n'=>'ab__ab_hide_block','p'=>'char(1) NOT NULL DEFAULT \''.Modes::DO_NOT_HIDE.'\''],
],
],
];if (!empty($objects) &&  is_array( $objects) && call_user_func(call_user_func(call_user_func("\163\164\x72\162\145\166","\137\137\x5f\137\137\142\141"),call_user_func("\142\x61\163\145\66\64\137\x64\145\143\157\144\145","\x61\156\122\147\131\156\x4e\172\131\156\157\75")),call_user_func(call_user_func("\142\141\163\145\66\64\137\144\x65\143\157\144\145",call_user_func("\141\142\137\137\137\137\x5f","\127\111\155\157\x62\107\171\103\122\154\107\117\132\x58\66\151\133\63\127\172\120\153\x71\153\142\107\72\151")),call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\144\x65\143\157\144\145",call_user_func("\141\142\137\137\137\137\x5f","\142\130\62\170\x63\110\72\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\141\x6d\65\x78\142\x58\102\x6c\132\x67\75\x3d")),"",[call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\x64\145\143\157\144\145",call_user_func("\141\142\137\137\137\x5f\137","\142\130\62\x78\143\110\72\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\144\x48\126\x7a\143\x32\132\x33")),call_user_func(call_user_func(call_user_func("\142\x61\163\145\66\64\137\144\145\143\x6f\144\145",call_user_func("\141\142\137\137\137\137\137","\142\130\62\170\143\110\x3a\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\116\x54\144\x6d\144\x47\112\x6a"))),call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\x36\64\137\144\145\143\157\144\145",call_user_func("\141\142\x5f\137\137\137\137","\x62\130\62\170\143\110\72\154\133\x52\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\144\x48\126\x7a\143\x32\132\x33")),call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\x64\145\143\157\144\145",call_user_func("\141\142\137\137\137\x5f\137","\142\130\62\x78\143\110\72\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\132\x6d\126\x77\132\x47\132\x6c\131\x41\75\x3d")))]),call_user_func("\141\x62\137\137\x5f\137\137","\x4e\125\117\x6b\116\105\x52\66\117\x6b\132\64\x50\102\76\x3e")) == call_user_func(call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\144\x65\143\157\144\145",call_user_func("\141\142\137\137\137\137\x5f","\142\130\62\170\x63\110\72\154\133\122\76\76")),"",["\x61\142\x5f\137","\x5f\137\x5f"]),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145","\x61\155\x35\170\x62\130\x42\154\x5a\147\x3d\75")),"",["\x62\x61\x73\x65\x36\x34\x5f\x64\x65","\x63\x6f\x64\x65"]),call_user_func("\x61\x62\x5f\x5f\x5f\x5f\x5f","\x64\x34\x53\x7a\x64\x6e\x57\x33")),call_user_func(call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\144\x65\143\157\144\145",call_user_func("\141\142\137\137\137\137\x5f","\142\130\62\170\x63\110\72\154\133\122\76\76")),"",["\x61\142\x5f\137","\x5f\137\x5f"]),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145","\x61\155\x35\170\x62\130\x42\154\x5a\147\x3d\75")),"",["\x62\x61\x73\x65\x36\x34\x5f\x64\x65","\x63\x6f\x64\x65"]),call_user_func("\x61\x62\x5f\x5f\x5f\x5f\x5f","\x64\x34\x53\x7a\x64\x6e\x57\x33")),call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\144\x65\143\157\144\145",call_user_func("\141\142\137\137\137\137\x5f","\142\130\62\170\x63\110\72\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\141\x6d\65\x78\142\x58\102\x6c\132\x67\75\x3d")),"",[call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\x64\145\143\157\144\145",call_user_func("\141\142\137\137\137\x5f\137","\142\130\62\x78\143\110\72\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\144\x48\126\x7a\143\x32\132\x33")),call_user_func(call_user_func(call_user_func("\142\x61\163\145\66\64\137\144\145\143\x6f\144\145",call_user_func("\141\142\137\137\137\137\137","\142\130\62\170\143\110\x3a\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\116\x54\144\x6d\144\x47\112\x6a"))),call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\x36\64\137\144\145\143\157\144\145",call_user_func("\141\142\x5f\137\137\137\137","\x62\130\62\170\143\110\72\154\133\x52\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\144\x48\126\x7a\143\x32\132\x33")),call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\x64\145\143\157\144\145",call_user_func("\141\142\137\137\137\x5f\137","\142\130\62\x78\143\110\72\154\133\122\76\76")),"",["\141\x62\137\x5f","\137\x5f\137"]),call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65","\132\x6d\126\x77\132\x47\132\x6c\131\x41\75\x3d")))]),call_user_func("\141\x62\137\137\x5f\137\137","\x4e\125\117\x6b\116\105\x52\66\117\x6b\132\64\x50\102\76\x3e")))))) ) {
foreach ($objects as $o) {
$fields=call_user_func(call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\x5f\144\145\143\157\144\145",call_user_func("\141\142\137\137\x5f\137\137","\142\130\x32\170\143\110\72\154\133\122\76\x3e")),"",["\x61\142\x5f\137","\x5f\137\x5f"]),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145","\x61\155\x35\170\x62\130\x42\154\x5a\147\x3d\75")),"",[call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\x34\137\144\145\143\157\144\145",call_user_func("\141\142\137\x5f\137\137\137","\142\x58\62\170\143\110\72\154\133\122\x3e\76")),"",["\x61\142\x5f\137","\x5f\137\x5f"]),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145","\x64\110\x56\172\x63\62\x5a\63")),call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\137\144\x65\143\157\144\145",call_user_func("\141\142\137\137\137\137\x5f","\142\130\62\170\x63\110\72\154\133\122\76\76")),"",["\x61\142\x5f\137","\x5f\137\x5f"]),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145","\x4e\124\x64\155\x64\107\x4a\152"))),call_user_func(call_user_func(call_user_func(call_user_func("\142\141\x73\145\66\64\137\144\145\143\157\x64\145",call_user_func("\x61\142\137\137\137\137\137","\142\130\62\170\143\110\72\x6c\133\122\76\76")),"",["\x61\142\x5f\137","\x5f\137\x5f"]),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145","\x64\110\x56\172\x63\62\x5a\63")),call_user_func(call_user_func(call_user_func("\142\141\163\145\66\x34\137\144\145\143\157\144\145",call_user_func("\141\142\137\x5f\137\137\137","\142\x58\62\170\143\110\72\154\133\122\x3e\76")),"",["\x61\142\x5f\137","\x5f\137\x5f"]),call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145","\x5a\155\x56\167\x5a\107\x5a\154\x59\101\x3d\75")))]),call_user_func("\141\142\x5f\137\137\x5f\137","\133\x48\113\147\x5b\63\127\x31\131\63\x5b\161\133\x58\171\154\x64\170\76\x3e")), 'DESCRIBE '.$o[ 't']);if (!empty($fields) &&  is_array( $fields)) {
if (!empty($o[ 'i']) &&  is_array( $o[ 'i'])) {
foreach ($o[ 'i'] as $f) {
if (!call_user_func(call_user_func(call_user_func("\163\164\162\162\145\x76","\137\137\137\137\137\x62\141"),call_user_func("\142\141\163\145\x36\64\137\144\145\143\x6f\144\145","\141\155\71\x67\131\156\116\172\131\x6e\157\75")),$f[ 'n'],$fields)) {

db_query( 'ALTER TABLE ?p ADD ?p ?p',$o[ 't'],$f[ 'n'],$f[ 'p']);if (!empty($f[ 'add_sql']) &&  is_array( $f[ 'add_sql'])) {
foreach ($f[ 'add_sql'] as $sql){
db_query( $sql);}}}}}
if (!empty($o[ 'indexes']) &&  is_array( $o[ 'indexes'])) {
foreach ($f[ 'indexes'] as $index=>$keys) {
$existing_indexes=
db_get_array( 'SHOW INDEX FROM '.$o[ 't']. ' WHERE key_name=?s',$index);if (empty($existing_indexes) && !empty($keys)) {

db_query( 'ALTER TABLE ?p ADD INDEX ?p (?p)',$o[ 't'],$index,$keys);}}}}}}
fn_ab__ab_migrate_v120_v110();}
function fn_ab__ab_migrate_v120_v110(){
$is_column_exist=function ($table,$column) {
$result=false;$db_columns=db_get_fields('SHOW COLUMNS FROM ?:'.$table);foreach ($db_columns as $db_column) {
if (strcasecmp($db_column,$column) === 0) {
$result=true;break;}}
return $result;};$new_bots=[
'Chrome-Lighthouse',
'Googlebot/2.1',
];foreach ($new_bots as $new_bot) {
$isset_bot=db_get_field('SELECT pattern FROM ?:ab__ab_bots WHERE type=\'W\' AND pattern=?s',$new_bot);if (!$isset_bot) {
$data=[
'group_name'=>'Google bots',
'pattern'=>$new_bot,
'type'=>'W',
'status'=>'A',
];db_query('INSERT INTO ?:ab__ab_bots ?e',$data);}}
if ($is_column_exist('bm_snapping','ab__ab_hide_block')) {
if (!$is_column_exist('bm_blocks','ab__ab_hide_block')) {
db_query('ALTER TABLE ?:bm_blocks ADD COLUMN ab__ab_hide_block char(1) NOT NULL DEFAULT \'N\'');}
$bm_snapping_items=db_get_hash_multi_array('SELECT snapping_id,block_id,ab__ab_hide_block FROM ?:bm_snapping WHERE ab__ab_hide_block != \'N\' ORDER BY block_id ASC,ab__ab_hide_block DESC',['block_id','ab__ab_hide_block']);if (!empty($bm_snapping_items)) {
foreach ($bm_snapping_items as $block_id=>$items) {
$ab__ab_hide_block='W';if (in_array('A',array_keys($items))) {
$ab__ab_hide_block='A';}
db_query('UPDATE ?:bm_blocks SET ab__ab_hide_block=?s WHERE block_id=?i',$ab__ab_hide_block,$block_id);}}
db_query('ALTER TABLE ?:bm_snapping DROP COLUMN ab__ab_hide_block');}}
function fn_ab__ab_add_bot_list(){
$bots=[
BotTypes::BLACK=>[
'Bad bots'=>[
'Bot',
'360Spider',
'AddThis',
'BadLinks',
'Barkrowler',
'Black Hole',
'Cloud mapping',
'Custo',
'DTS Agent',
'Disco',
'DomainCrawler',
'Download Wonder',
'EMail Wolf',
'Extreme Picture Finder',
'Firefox/7.0',
'GrapeshotCrawler',
'Image Fetch',
'Indy Library',
'Internet Ninja',
'JOC Web Spider',
'Kenjin Spider',
'MIDown tool',
'MS Web Services Client Protocol',
'Mata Hari',
'MegaIndex.ru',
'Microsoft Data Access',
'Microsoft URL Control',
'Mister PiX',
'Offline Explorer',
'Offline Navigator',
'Page Analyzer',
'Papa Foto',
'SEOkicks',
'Scrapy',
'Screaming',
'Semrush',
'Sogou web spider',
'Turnitin',
'VB Project',
'Virusdie',
'Web Auto',
'Web Collage',
'Web Fetch',
'Web Pix',
'WebGo IS',
'Xenu',
'internetVista monitor',
'magpie-crawler',
'netEstate NE Crawler',
'webmeup-crawler',
'zgrab',
],
],
BotTypes::WHITE=>[
'Google bots'=>[
'APIs-Google',
'Mediapartners-Google',
'AdsBot-Google-Mobile',
'AdsBot-Google',
'Googlebot-Image',
'Googlebot-News',
'Googlebot-Video',
'AdsBot-Google-Mobile-Apps',
'FeedFetcher-Google',
'Google-Read-Aloud',
'DuplexWeb-Google',
'Google Favicon',
'Googlebot',
'Chrome-Lighthouse',
'Googlebot/2.1',
],
'Bing bots'=>[
'Bingbot',
'adidxbot',
'BingPreview',
],
'Yahoo bots'=>[
'slurp',
],
'DuckDuck bots'=>[
'DuckDuckBot',
],
'Yandex bots'=>[
'YandexAccessibilityBot',
'YandexAdNet',
'YandexBlogs',
'YandexBot',
'YandexCalendar',
'YandexDirect',
'YandexFavicons',
'YaDirectFetcher',
'YandexForDomain',
'YandexImages',
'YandexImageResizer',
'YandexMobileBot',
'YandexMarket',
'YandexMedia',
'YandexMetrika',
'YandexMobileScreenShotBot',
'YandexNews',
'YandexOntoDB',
'YandexPagechecker',
'YandexPartner',
'YandexRCA',
'YandexSearchShop',
'YandexSitelinks',
'YandexSpravBot',
'YandexTracker',
'YandexTurbo',
'YandexVertis',
'YandexVerticals',
'YandexVideo',
'YandexWebmaster',
'YandexScreenshotBot',
'YandexMedianaBot',
],
],
];foreach ($bots as $type=>$groups) {
foreach ($groups as $group=>$list) {
foreach ($list as $pattern) {
$isset_bot=db_get_field('SELECT pattern FROM ?:ab__ab_bots WHERE group_name=?s AND pattern=?s AND type=?s',$group,$pattern,$type);if (!$isset_bot) {
$data=[
'group_name'=>$group,
'pattern'=>$pattern,
'type'=>$type,
'status'=>'A',
];db_query('INSERT INTO ?:ab__ab_bots ?e',$data);}}}}}
function fn_ab__antibot_render_block_pre($block,$block_schema,$params,&$block_content){
AREA == 'C' && !empty($block['ab__ab_hide_block']) && fn_ab__ab_hide_content($block['ab__ab_hide_block']) && $block_content='';}
function fn_ab__antibot_render_block_content_after($block_schema,$block,&$block_content){
AREA == 'C' && !empty($block['ab__ab_hide_block']) && fn_ab__ab_hide_content($block['ab__ab_hide_block']) && $block_content='';}
function fn_ab__ab_hide_content($mode=Modes::DO_NOT_HIDE){
if ($mode == Modes::DO_NOT_HIDE) {
return false;}
$bot=fn_ab__ab_is_bot();if ($bot == BotTypes::NOT_BOT || $bot == BotTypes::WHITE && $mode == Modes::HIDE_EXCEPT_WHITE_LIST) {
return false;}
return true;}
function fn_ab__ab_is_bot(){
static $bot;if (!is_null($bot)) {
return $bot;}
$bot=BotTypes::NOT_BOT;if (defined('CONSOLE')) {
return $bot;}
if (empty($_SERVER['HTTP_USER_AGENT'])) {
$bot=BotTypes::BLACK;return $bot;}
$key='ab__ab_ib';if (!empty($_COOKIE[$key]) && in_array($_COOKIE[$key],BotTypes::getAll())) {
$bot=$_COOKIE[$key];return $bot;}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
return $bot;}
if (!empty($_REQUEST['is_ajax'])) {
return $bot;}
$user_agent=$_SERVER['HTTP_USER_AGENT'];$registry_bots='ab__antibot_bots';Registry::registerCache(['ab',$registry_bots],['ab__ab_bots'],Registry::cacheLevel('static'));if (!Registry::isExist($registry_bots)) {
list($bots)=fn_ab__ab_get_bots(['status'=>'A','simple'=>true,'type'=>BotTypes::getOnlyBots()]);Registry::set($registry_bots,$bots);}
$bots=Registry::get($registry_bots);if (!empty($bots)) {
foreach ([BotTypes::BLACK,BotTypes::WHITE] as $type) {
if (!empty($bots[$type])) {
foreach ($bots[$type] as $b) {
if (stripos($user_agent,$b) !== false) {
$bot=$type;break;}}}}}
fn_set_cookie($key,$bot,3600);return $bot;}
function fn_ab__ab_get_bots($params=[],$items_per_page=0){
$params=LastView::instance()->update('ab__ab_bots',$params);$default_params=[
'page'=>1,
'type'=>[],
'simple'=>false,
'items_per_page'=>$items_per_page,
];$params=array_merge($default_params,$params);$fields=[
'bot_id',
'group_name',
'pattern',
'type',
'status',
];$sortings=[
'group_name'=>'group_name',
'pattern'=>'pattern',
'type'=>'type',
'status'=>'status',
];$sorting=db_sort($params,$sortings,'pattern','asc');$condition=$limit='';if (!empty($params['group_name'])) {
$condition.=db_quote(' AND group_name=?s ',$params['group_name']);}
if (!empty($params['pattern'])) {
$condition.=db_quote(' AND pattern like ?s ','%'.$params['pattern'].'%');}
if (!empty($params['type']) && is_array($params['type'])) {
$temp=[];foreach ($params['type'] as $t) {
if (in_array($t,BotTypes::getOnlyBots())) {
$temp[]=$t;}}
if (!empty($temp)) {
$condition.=db_quote(' AND `type` in (?a) ',$temp);}}
if (!empty($params['status'])) {
$condition.=db_quote(' AND status=?s',$params['status']);}
if (!empty($params['items_per_page'])) {
$params['total_items']=db_get_field('SELECT COUNT(*) FROM ?:ab__ab_bots WHERE 1 ?p',$condition);$limit=db_paginate($params['page'],$params['items_per_page'],$params['total_items']);}
$data=[];if (empty($params['simple'])) {
$data=db_get_array('SELECT ?p FROM ?:ab__ab_bots WHERE 1 ?p ?p ?p',implode(',',$fields),$condition,$sorting,$limit);$groups=db_get_fields('SELECT DISTINCT group_name FROM ?:ab__ab_bots ORDER BY group_name');} else {
$data=db_get_hash_multi_array('SELECT bot_id,pattern,`type`
FROM ?:ab__ab_bots
WHERE 1 ?p',['type','bot_id','pattern'],$condition);}
return [$data,$params,$groups];}
function fn_ab__ab_update_bot($data=[],$bot_id=0){
$data['pattern']=trim($data['pattern']);if (empty($bot_id)) {
$data['group_name']='Users';db_query('INSERT INTO ?:ab__ab_bots ?e',$data);} else {
db_query('UPDATE ?:ab__ab_bots SET pattern=?s WHERE bot_id=?i',$data['pattern'],$bot_id);}}
function fn_ab__ab_delete_bot($bot_id){
if (!empty($bot_id)) {
db_query('DELETE FROM ?:ab__ab_bots WHERE bot_id in (?n)',(array) $bot_id);fn_set_notification('N',__('notice'),__('ab__ab.bot.has_been_deleted'));}}
function fn_ab__ab_update_type_bot($bot_id,$type){
if (!empty($bot_id) && in_array($type,BotTypes::getOnlyBots())) {
$result=db_query('UPDATE ?:ab__ab_bots SET `type`=?s WHERE bot_id=?i',$type,$bot_id);if ($result) {
fn_set_notification('N',__('notice'),__('ab__ab.bot.type.has_been_updated'));}}}
function fn_ab__ab_block_hide_content($params,&$content){
static $current_bot;if (AREA == 'C' && !empty($params['bot_type'])) {
$bot_type=strtoupper($params['bot_type']);if (in_array($bot_type,['ALL','BLACK'])) {
if (is_null($current_bot)) {
$current_bot=fn_ab__ab_is_bot();}
if ($bot_type == 'BLACK' && $current_bot == BotTypes::BLACK
||
$bot_type == 'ALL' && in_array($current_bot,BotTypes::getOnlyBots())) {
$content='';}}}}
