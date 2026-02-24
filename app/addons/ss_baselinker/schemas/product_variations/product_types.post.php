<?php
/***************************************************************************
 *                                                                         *
 *    Copyright (c) SoftSolid. All rights reserved.                        *
 *    https://cs-cart.pl, office@cs-cart.com.pl                            *
 *                                                                         *
 **************************************************************************/

use Tygh\Addons\ProductVariations\Product\Type\Type;

defined('BOOTSTRAP') or die('Access denied');

if (defined('PRODUCT_TYPE_VENDOR_PRODUCT_OFFER') && defined('PRODUCT_TYPE_PRODUCT_OFFER_VARIATION')) {
    $schema[PRODUCT_TYPE_VENDOR_PRODUCT_OFFER]['tabs'][]   = 'ss_baselinker';
    $schema[PRODUCT_TYPE_VENDOR_PRODUCT_OFFER]['fields'][] = 'ss_baselinker_name';
    $schema[PRODUCT_TYPE_VENDOR_PRODUCT_OFFER]['fields'][] = 'ss_baselinker_description';
} // end if

$schema[Type::PRODUCT_TYPE_VARIATION]['tabs'][]   = 'ss_baselinker';
$schema[Type::PRODUCT_TYPE_VARIATION]['fields'][] = 'ss_baselinker_name';
$schema[Type::PRODUCT_TYPE_VARIATION]['fields'][] = 'ss_baselinker_description';

return $schema;