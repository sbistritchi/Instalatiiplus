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
use Tygh\Addons\Ab_addonsManager\DemoData;use Tygh\BlockManager\Block;use Tygh\BlockManager\Layout;use Tygh\Menu;use Tygh\Registry;use Tygh\Languages\Languages;use Tygh\Enum\YesNo;use Tygh\Enum\ObjectStatuses;use Tygh\Enum\ImagePairTypes;use Tygh\Storage;if (!defined('BOOTSTRAP')) {
die('Access denied');}
function fn_abt__ut2_install_demodata(){
$prefix='fn_abt__ut2_demodata_';$temp=["{$prefix}banners","{$prefix}blog"];$answer=[];foreach ($temp as $func) {
if (function_exists($func)) {
$val=$func(ObjectStatuses::ACTIVE,true);if (!$val) {
return false;}
$answer[$func]=implode(',',$val);}}
return $answer;}
function fn_abt__ut2_demodata_get_file($file){
$result=DemoData::getFile([
'file'=>$file,
'addon'=>'abt__unitheme2',
]);if ($result->isSuccess()) {
$data=$result->getData();return $data['path'];}
return '';}
function fn_abt__ut2_demodata_banners($status=ObjectStatuses::ACTIVE,$place_into_blocks=false){
$path=fn_abt__ut2_demodata_get_file('banners_4172b.zip');$answer=[];$data=fn_get_contents("{$path}/data.json");if (empty($data)) {
fn_set_notification('E',__('error'),__('abt__ut2.demodata.errors.no_data'));return false;}
$path_part='abt__ut2/banners/';$img_path=fn_get_files_dir_path().$path_part;fn_rm($img_path);fn_mkdir($img_path);fn_copy($path,$img_path);$data=json_decode($data,true);$languages=array_keys(Languages::getAll());$is_ru=in_array('ru',$languages);$is_uk=in_array('uk',$languages);$image_types=['banners_main','abt__ut2_main_image','abt__ut2_background_image','abt__ut2_tablet_main_image',
'abt__ut2_tablet_background_image','abt__ut2_mobile_main_image','abt__ut2_mobile_background_image',];$video_types=['abt__ut2_background_mp4_video','abt__ut2_mobile_background_mp4_video','abt__ut2_tablet_background_mp4_video'];if ($place_into_blocks) {
list($blocks)=Block::instance()->find([
'type'=>'banners',
'layout_id'=>Registry::get('runtime.layout.layout_id'),]);$block_ids_by_type=[];foreach ($blocks as $block_id=>$block) {
if (!empty($block['properties']['abt__ut2_demo_block_id'])) {
$block_ids_by_type[$block['properties']['abt__ut2_demo_block_id']][]=$block_id;}}}
$company_id=call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x5a\x32\x39\x67\x61\x47\x5a\x31\x59\x48\x4e\x32\x62\x33\x56\x71\x62\x6d\x5a\x67\x5a\x48\x42\x75\x63\x57\x4a\x76\x65\x6d\x42\x71\x5a\x51\x3d\x3d")));$banners_ids_by_block_id=[];foreach ($data as $banner) {
$banner['status']=$status;$banner['company_id']=$company_id;$banner_id=fn_banners_update_banner($banner,0,DESCR_SL);if ($banner_id) {
if ($is_ru) {
fn_banners_update_banner($banner['ru'],$banner_id,'ru');}
if ($is_uk) {
fn_banners_update_banner($banner['uk'],$banner_id,'uk');}
foreach ($image_types as $image_type) {
if (isset($banner['images'][$image_type])) {
foreach ($languages as $lang_code) {
if ($image_type === 'banners_main') {
$obj_type='promo';$banner_image_id=db_get_field('SELECT banner_image_id
FROM ?:banner_images
WHERE banner_id=?i AND lang_code=?s',$banner_id,$lang_code);} else {
$obj_type=call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\132\x58\113\x31\131\x32\72\x32\145\x45\112\x77\132\x6e\107\x76\143\x6e\127\x7a\144\x7a\71\x3e")).$banner['images'][$image_type]['device'];$_data=['banner_id'=>$banner_id,'lang_code'=>$lang_code];$banner_image_id=db_get_field('SELECT abt__ut2_banner_image_id FROM ?:abt__ut2_banner_images WHERE ?w',$_data);if (empty($banner_image_id)) {
$banner_image_id=db_query('INSERT INTO ?:abt__ut2_banner_images ?e',$_data);}}
$image_arr=[
$image_type.'_image_data'=>[['type'=>$banner['images'][$image_type]['type'],'object_id'=>$banner_image_id]],
'file_'.$image_type.'_image_icon'=>[$img_path.$banner['images'][$image_type]['img']],
'type_'.$image_type.'_image_icon'=>['server'],
];if(isset($banner['images'][$image_type]['data']['is_high_res'])){
$image_arr['is_high_res_'. $image_type.'_image_icon']=$banner['images'][$image_type]['data']['is_high_res'];}
$_REQUEST=array_merge($_REQUEST,$image_arr);call_user_func(call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x61\x6d\x35\x78\x62\x58\x42\x6c\x5a\x67\x3d\x3d")),"",["\142\x61\163\x65\66\x34\137\x64\145","\x63\157\x64\145"]),call_user_func("\x61\142\x5f\137\x5f\137\x5f","\133\x6e\66\x67\132\x59\123\x31\132\x58\117\x70\131\x33\155\x75\132\x58\145\x6d\131\x34\103\x69\142\x59\113\x7b")),$image_type,$obj_type,$banner_image_id,$lang_code);}}}
foreach ($video_types as $video_type) {
if (!empty($banner[$video_type])) {
Storage::instance('images')->put($banner[$video_type],[
'file'=>$path.'/'.basename($banner[$video_type]),'overwrite'=>true,
]);}}
$banner_name=CART_LANGUAGE == 'ru'?$banner['ru']['banner']:$banner['banner'];$answer[]="<a target='_blank' href='?dispatch=banners.update&banner_id=$banner_id'>{$banner_name}</a>";if (!empty($banner['abt__ut2_demo_block_id']) && !empty($block_ids_by_type[$banner['abt__ut2_demo_block_id']])) {
foreach ($block_ids_by_type[$banner['abt__ut2_demo_block_id']] as $block_id) {
$banners_ids_by_block_id[$block_id][]=$banner_id;}}}}
if (!empty($banners_ids_by_block_id)) {
foreach ($banners_ids_by_block_id as $block_id=>$banners_ids) {
$blocks[$block_id]['content_data']=[
'override_by_this'=>'Y',
'lang_code'=>CART_LANGUAGE,
'content'=>[
'items'=>[
'filling'=>'manually',
'item_ids'=>implode(',',$banners_ids),],
],
];$blocks[$block_id]['apply_to_all_langs']=YesNo::YES;Block::instance()->update($blocks[$block_id]);}}
fn_set_notification('N',__('notice'),__('abt__ut2.demodata.success.banners',['[ids]'=>implode(',',$answer)]));return $answer;}

function fn_abt__ut2_demodata_blog($status=ObjectStatuses::ACTIVE){
$company_id=fn_get_runtime_company_id();$path=fn_abt__ut2_demodata_get_file('blog.zip');$data=call_user_func(call_user_func(call_user_func("\x73\164\162\x72\145\166","\x5f\137\137\x5f\137\142\x61"),call_user_func("\142\141\x73\145\66\x34\137\144\x65\143\157\x64\145","\132\x32\71\147\x61\107\132\x31\131\107\x52\167\142\x33\126\155\x62\63\126\x30")),"{$path}/data.json");if (!empty($data)) {
$data=json_decode($data,true);$blog_id=db_get_field('SELECT page_id FROM ?:pages WHERE page_type=?s AND status=?s AND parent_id=0 AND company_id=?i',PAGE_TYPE_BLOG,ObjectStatuses::ACTIVE,$company_id);if (empty($blog_id)) {
fn_set_notification('E',__('error'),__('abt__ut2.demodata.errors.no_blog_page'));} else {
$path_part='abt__ut2/blog/';$img_path=fn_get_files_dir_path().$path_part;fn_rm($img_path);fn_mkdir($img_path);fn_copy($path,$img_path);$answer=[];$languages=array_keys(Languages::getAll());$is_ru=in_array('ru',$languages);foreach ($data as $key=>$blog_post) {
$blog_post['parent_id']=$blog_id;$blog_post['company_id']=$company_id;$blog_post['lang_code']=CART_LANGUAGE;$blog_post['status']=$status;$blog_post['page'].=' ('.__('demo').')';$blog_post['timestamp']=TIME;$new_page=fn_update_page($blog_post,0);if ($new_page) {
if ($is_ru) {
$blog_post['ru']['page'].=' ('.__('demo',[],'ru').')';fn_update_page(array_merge($blog_post,$blog_post['ru']),$new_page,'ru');}
if (!empty($blog_post['blog_image'])) {
$image_str='blog_image_image';$image=[
"{$image_str}_data"=>[[call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x63\x57\x4a\x71\x63\x32\x42\x71\x5a\x51\x3d\x3d"))=>'',call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x61\x6d\x35\x78\x62\x58\x42\x6c\x5a\x67\x3d\x3d")),"",["\142\x61\163\x65\66\x34\137\x64\145","\x63\157\x64\145"]),call_user_func("\x61\142\x5f\137\x5f\137\x5f","\145\x49\155\x78\133\x52\76\x3e"))=>ImagePairTypes::MAIN,call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x61\x6d\x35\x78\x62\x58\x42\x6c\x5a\x67\x3d\x3d")),"",[call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x64\x48\x56\x7a\x63\x32\x5a\x33")),call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x4e\x54\x64\x6d\x64\x47\x4a\x6a"))),call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x64\x48\x56\x7a\x63\x32\x5a\x33")),call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x5a\x6d\x56\x77\x5a\x47\x5a\x6c\x59\x41\x3d\x3d")))]),call_user_func("\x61\142\137\137\137\137\137","\143\63\x4b\162\133\130\117\61\131\63\155\x6c"))=>0,call_user_func(call_user_func("\163\164\x72\162\145\x76","\137\137\x5f\137\137\x62\141"),call_user_func("\142\x61\163\145\x36\64\137\x64\145\143\x6f\144\145","\x61\155\65\x69\141\107\x5a\147\131\x6d\61\61"))=>$blog_post[call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x64\110\x47\157\x5b\122\x3e\76"))]]],
"file_{$image_str}_icon"=>["{$img_path}/{$blog_post['blog_image']}"],
"type_{$image_str}_icon"=>['server'],
];$_REQUEST=array_merge($_REQUEST,$image);fn_attach_image_pairs('blog_image','blog',$new_page);}
$answer[]='<a href="'.fn_url('pages.update&page_id='.$new_page.'&come_from=B').'" target="_blank">'.(CART_LANGUAGE == 'ru'?$blog_post['ru']['page']:$blog_post['page']).'</a>';}}
fn_set_notification('N',__('notice'),__('abt__ut2.demodata.success.blog',['[ids]'=>implode(',',$answer)]),'S');return $answer;}} else {
fn_set_notification('E',__('error'),__('abt__ut2.demodata.errors.no_data'));}
return false;}

function fn_abt__ut2_demodata_menu($status='A',$place_into_blocks=false,$get_menu_ids=false){
$path=fn_abt__ut2_demodata_get_file('menu.zip');$data=call_user_func(call_user_func(call_user_func("\x73\164\162\x72\145\166","\x5f\137\137\x5f\137\142\x61"),call_user_func("\142\141\x73\145\66\x34\137\144\x65\143\157\x64\145","\132\x32\71\147\x61\107\132\x31\131\107\x52\167\142\x33\126\155\x62\63\126\x30")),"{$path}/data.json");$languages=array_keys(Languages::getAll());$is_ru=in_array('ru',$languages);$is_en=in_array('en',$languages);$answer=[];if (!empty($data)) {
$data=json_decode($data,true);$company_id=call_user_func(call_user_func(call_user_func(call_user_func("\x62\141\x73\145\x36\64\x5f\144\x65\143\x6f\144\x65",call_user_func("\141\x62\137\x5f\137\x5f\137","\142\x58\62\x78\143\x48\72\x6c\133\x52\76\x3e")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x5a\x32\x39\x67\x61\x47\x5a\x31\x59\x48\x4e\x32\x62\x33\x56\x71\x62\x6d\x5a\x67\x5a\x48\x42\x75\x63\x57\x4a\x76\x65\x6d\x42\x71\x5a\x51\x3d\x3d")));if ($place_into_blocks) {
list($blocks)=Block::instance()->find([
'type'=>'menu',
'layout_id'=>Registry::get('runtime.layout.layout_id'),]);$block_ids_by_type=[];foreach ($blocks as $block_id=>$block) {
if (!empty($block['properties']['abt__ut2_demo_block_id'])) {
$block_ids_by_type[$block['properties']['abt__ut2_demo_block_id']][]=$block_id;}}}
$menu_id_by_block_id=[];foreach ($data as $menu_name=>$menu) {
$time=substr(TIME,-3);$menu_name.=' '.$time;$menu_data=[
call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x62\x32\x4a\x75\x5a\x67\x3d\x3d"))=>$menu_name,
call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x61\x6d\x35\x78\x62\x58\x42\x6c\x5a\x67\x3d\x3d")),"",["\x62\141\x73\145\x36\64\x5f\144\x65","\143\x6f\144\x65"]),call_user_func("\141\x62\137\x5f\137\x5f\137","\x63\110\x47\166\x5b\62\x3a\153\x63\63\x53\155"))=>DESCR_SL,
call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x61\x6d\x35\x78\x62\x58\x42\x6c\x5a\x67\x3d\x3d")),"",[call_user_func(call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x64\x48\x56\x7a\x63\x32\x5a\x33")),call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x4e\x54\x64\x6d\x64\x47\x4a\x6a"))),call_user_func(call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x64\x48\x56\x7a\x63\x32\x5a\x33")),call_user_func(call_user_func(call_user_func("\142\x61\163\x65\66\x34\137\x64\145\x63\157\x64\145",call_user_func("\x61\142\x5f\137\x5f\137\x5f","\x62\130\x32\170\x63\110\x3a\154\x5b\122\x3e\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x5a\x6d\x56\x77\x5a\x47\x5a\x6c\x59\x41\x3d\x3d")))]),call_user_func("\x61\142\137\137\137\137\137","\144\64\x53\151\145\111\127\173"))=>$status,
call_user_func(call_user_func("\x73\164\162\x72\145\166","\x5f\137\137\x5f\137\142\x61"),call_user_func("\142\141\x73\145\66\x34\137\144\x65\143\157\x64\145","\132\x48\102\165\x63\127\112\x76\145\155\x42\161\132\x51\75\75"))=>$company_id,
];$menu_id=Menu::update($menu_data);if (!$menu_id) {
fn_set_notification('E',__('error'),__('abt__ut2.demodata.errors.menu_wasnt_created',['[name]'=>$menu_name]));return false;}
foreach ($menu['items'] as $item) {
fn_abt__ut2_create_demodata_menu_item($item,$menu_id,$company_id,$is_ru,$is_en);}
$answer[]=$get_menu_ids?$menu_id:'<a target="_blank" href="'.fn_url('static_data.manage&section=A&menu_id='.$menu_id).'">'.$menu_name.'</a>';if (!empty($menu['abt__ut2_demo_block_id']) && !empty($block_ids_by_type[$menu['abt__ut2_demo_block_id']])) {
foreach ($block_ids_by_type[$menu['abt__ut2_demo_block_id']] as $block_id) {
$menu_id_by_block_id[$block_id]=$menu_id;}}}
if (!empty($menu_id_by_block_id)) {
foreach ($menu_id_by_block_id as $block_id=>$menu_id) {
$blocks[$block_id]['content_data']=[
'override_by_this'=>'Y',
'lang_code'=>CART_LANGUAGE,
'content'=>[
'menu'=>$menu_id,
],
];$blocks[$block_id]['apply_to_all_langs']='Y';Block::instance()->update($blocks[$block_id]);}}
if (!$get_menu_ids) {
fn_set_notification('N',__('notice'),__('abt__ut2.demodata.success.menu',['[menus]'=>implode(',',$answer)]),'S');}
return $answer;}
fn_set_notification('E',__('error'),__('abt__ut2.demodata.errors.no_data'));return false;}

function fn_abt__ut2_create_demodata_menu_item($item,$menu_id,$company_id,$is_ru=true,$is_en=true,$parent=0){
static $path=null;static $img_dir=null;if ($path === null) {
$path=fn_abt__ut2_demodata_get_file('menu.zip');$img_dir=fn_get_files_dir_path().'abt__ut2/menu/';fn_copy($path,$img_dir);}
if (empty($path)) {
fn_set_notification('E',__('error'),__('abt__ut2.demodata.errors.no_data'));return;}
$item['parent_id']=$parent;$item['param']=isset($item['href'])?$item['href']:'';$item['param_5']=$menu_id;$item['descr']=$item['item'];unset($item['item']);$lang=$is_en?'en':($is_ru?'ru':CART_LANGUAGE);$cat_id=db_get_field('SELECT ?:categories.category_id
FROM ?:categories
LEFT JOIN ?:category_descriptions
ON ?:categories.category_id=?:category_descriptions.category_id AND lang_code=?s
WHERE category=?s AND ?:categories.company_id=?i',$lang,$lang == 'ru'?$item['ru']['descr']:$item['descr'],$company_id);if (!empty($cat_id) && empty($item['subitems'])) {
$item['megabox']=[
'type'=>['param_3'=>'C'],
'use_item'=>['param_3'=>(isset($item['ab__use_category_link']) && $item['ab__use_category_link'] == YesNo::YES)?YesNo::YES:YesNo::NO],
];$item['param_3']=['C'=>$cat_id];} elseif ($item['descr'] == 'Catalog') {
$item['megabox']=[
'type'=>['param_3'=>'C'],
'use_item'=>['param_3'=>YesNo::NO],
];$item['param_3']=['C'=>0];}
$item_id=fn_abt__ut2_update_static_data($item,0,AREA);if ($is_ru) {
fn_abt__ut2_update_static_data(array_merge($item,$item['ru']),$item_id,AREA,'ru');}
if (isset($item['image'])) {
$ico_str='abt__ut2_mwi__icon_image_';$ico_obj=[
$ico_str.'data'=>[
$item_id=>[
'type'=>ImagePairTypes::MAIN,
],
],
'file_'.$ico_str.'icon'=>[
$item_id=>$img_dir.$item['image'],
],
'type_'.$ico_str.'icon'=>[
$item_id=>'server',
],
];$_REQUEST=array_merge($_REQUEST,$ico_obj);fn_attach_image_pairs('abt__ut2_mwi__icon','abt__ut2/menu-with-icon',$item_id,$lang);}
if (isset($item['subitems'])) {
foreach ($item['subitems'] as $subitem) {
fn_abt__ut2_create_demodata_menu_item($subitem,$menu_id,$company_id,$is_ru,$is_en,$item_id);}}}

function fn_abt__ut2_update_static_data($data,$param_id,$section,$lang_code=CART_LANGUAGE){
$current_id_path='';$schema=fn_get_schema('static_data','schema');$section_data=$schema[$section];if (!empty($section_data['has_localization'])) {
$data['localization']=empty($data['localization'])?'':fn_implode_localizations($data['localization']);}
if (!empty($data['megabox'])) {
foreach ($data['megabox']['type'] as $p=>$v) {
if (!empty($v)) {
$data[$p]=$v.':'.intval($data[$p][$v]).':'.$data['megabox']['use_item'][$p];} else {
$data[$p]='';}}}
$condition=db_quote('param_id=?i',$param_id);if (!empty($param_id)) {
$current_id_path=db_get_field("SELECT id_path FROM ?:static_data WHERE $condition");db_query('UPDATE ?:static_data SET ?u WHERE param_id=?i',$data,$param_id);db_query('UPDATE ?:static_data_descriptions SET ?u WHERE param_id=?i AND lang_code=?s',$data,$param_id,$lang_code);} else {
$data['section']=$section;$param_id=$data['param_id']=db_query('INSERT INTO ?:static_data ?e',$data);foreach (fn_get_translation_languages() as $data['lang_code']=>$_v) {
db_query('REPLACE INTO ?:static_data_descriptions ?e',$data);}}
if (isset($data['parent_id'])) {
if (!empty($data['parent_id'])) {
$new_id_path=db_get_field('SELECT id_path FROM ?:static_data WHERE param_id=?i',$data['parent_id']);$new_id_path.='/'.$param_id;} else {
$new_id_path=$param_id;}
if (!empty($current_id_path) && $current_id_path != $new_id_path) {
db_query('UPDATE ?:static_data SET id_path=CONCAT(?s,SUBSTRING(id_path,?i)) WHERE id_path LIKE ?l',"$new_id_path/",strlen($current_id_path.'/') + 1,"$current_id_path/%");}
db_query('UPDATE ?:static_data SET id_path=?s WHERE param_id=?i',$new_id_path,$param_id);}
return $param_id;}

function fn_abt__ut2_demodata_add_fly_menu(){
$layouts=Layout::instance()->getList();$storefront_id=Tygh::$app['storefront']->storefront_id;if (empty($layouts)) {
return false;}
foreach ($layouts as $layout_id=>$layout) {
list($blocks)=Block::instance()->find(['layout_id'=>$layout_id]);$logo_block=$my_account=$currencies=$languages=$geo_maps=$social_links=$contacts=[
'type'=>'block',
'state'=>YesNo::NO,
'show_title'=>YesNo::NO,
'menu'=>0,
];$isset_abt__ut2_fly_menu_blocks=false;foreach ($blocks as $block_id=>$block) {
if (!empty($block['properties']['abt__ut2_fly_menu'])) {
$isset_abt__ut2_fly_menu_blocks=true;if ($block['properties']['abt__ut2_fly_menu'] == 'top_logo') {
$logo_block['block_id']=$block_id;} elseif ($block['properties']['abt__ut2_fly_menu'] == 'my_account') {
$my_account['block_id']=$block_id;} elseif ($block['properties']['abt__ut2_fly_menu'] == 'social_links') {
$social_links['block_id']=$block_id;} elseif ($block['properties']['abt__ut2_fly_menu'] == 'contacts') {
$contacts['block_id']=$block_id;} elseif ($block['properties']['abt__ut2_fly_menu'] == 'geo_maps_customer_location') {
$geo_maps['block_id']=$block_id;} elseif ($block['properties']['abt__ut2_fly_menu'] == 'languages') {
$languages['block_id']=$block_id;} elseif ($block['properties']['abt__ut2_fly_menu'] == 'currencies') {
$currencies['block_id']=$block_id;}}}
if (!$isset_abt__ut2_fly_menu_blocks) {
continue;}
list($main_menu_id,$additional_menu_id)=fn_abt__ut2_demodata_menu(ObjectStatuses::ACTIVE,false,true);list($add_menu_1_id)=db_get_fields("SELECT menu_id FROM ?:menus WHERE menu_id NOT IN ($main_menu_id,$additional_menu_id) LIMIT 1");$main_menu=$additional_menu=$add_menu_1=[
'type'=>'menu',
'state'=>YesNo::YES,
'show_title'=>YesNo::NO,
'block_id'=>0,
];$main_menu['menu']=$main_menu_id;$additional_menu['menu']=$additional_menu_id;$add_menu_1['menu']=$add_menu_1_id;$delimiter=[
'type'=>'delimiter',
'state'=>YesNo::NO,
'show_title'=>YesNo::NO,
'menu'=>0,
'block_id'=>0,
];$my_account['user_class']='account-info';$social_links['user_class']=$contacts['user_class']='fill--gray';$data=[
$logo_block,
$my_account,
$main_menu,
$delimiter,
$languages,
$currencies,
$geo_maps,
$delimiter,
$additional_menu,
$delimiter,
$add_menu_1,
$social_links,
$contacts,
];foreach ($data as $key=>&$lm_data) {
if ($lm_data['type'] == 'menu' && empty($lm_data['menu'])) {
unset($data[$key]);continue;} elseif ($lm_data['type'] == 'block' && empty($lm_data['block_id'])) {
unset($data[$key]);continue;}
if (!empty($lm_data['user_class'])) {
$lm_data['content']['user_class']=$lm_data['user_class'];}
if (!empty($lm_data['menu'])) {
$lm_data['content']['menu']=$lm_data['menu'];}
if (!empty($lm_data['block_id'])) {
$lm_data['content']['block_id']=$lm_data['block_id'];}
if (!empty($lm_data['state'])) {
$lm_data['content']['state']=$lm_data['state'];}
if (!empty($lm_data['show_title'])) {
$lm_data['content']['show_title']=$lm_data['show_title'];}
unset($lm_data['user_class'],$lm_data['block_id'],$lm_data['state'],$lm_data['show_title'],$lm_data['menu']);$lm_data['storefront_id']=$storefront_id;$lm_data['content']=serialize($lm_data['content']);}
db_query('DELETE FROM ?:abt__ut2_fly_menu_content WHERE storefront_id=?i',$storefront_id);db_replace_into('abt__ut2_fly_menu_content',$data,true);return true;}
return false;}
