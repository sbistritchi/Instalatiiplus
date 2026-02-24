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
namespace Tygh\Addons\Ab_lazyLoad;
class ImagePlaceholders
{
private $storage = [];
private $placeholder;
private $default_placeholder = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAQAAAAD+Fb1AAAADklEQVR42mNkgAJG3AwAAH4ABWjFc8IAAAAASUVORK5CYII=';
private static $instance = null;
private function __construct()
{
$storefront_id = fn_ab__ll_get_storefront_id();
$this->placeholder = fn_get_image_pairs($storefront_id, 'ab__ll_placeholder', 'M', true, true);
}

public function get_placeholer($width, $height, $is_hidpi = false)
{
$suffix = '';
if (!$this->placeholder) {
return $this->default_placeholder;
}
if($is_hidpi){
$width *= 2;
$height *= 2;
$suffix = ' 2x';
}
$key = $width . '_' . $height;
if (!isset($this->storage[$key])) {
$this->storage[$key] = fn_image_to_display($this->placeholder, $width, $height);
}
return $this->storage[$key]['image_path'].$suffix;
}
public static function instance()
{
if (self::$instance === null) {
self::$instance = new self();
}
return self::$instance;
}
}
