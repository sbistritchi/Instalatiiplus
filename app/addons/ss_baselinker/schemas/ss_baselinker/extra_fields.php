<?php
/***************************************************************************
 *                                                                         *
 *    Copyright (c) SoftSolid. All rights reserved.                        *
 *    https://cs-cart.pl, office@cs-cart.com.pl                            *
 *                                                                         *
 **************************************************************************/
if (!defined('BOOTSTRAP')) { die('Access denied'); }

use Tygh\Registry;

$addon_params = Registry::get('addons.ss_baselinker');

$schema = [
    'avail_since' => [
        'table' => 'products',
        'type'  => 'internal',
        'check' => false 
    ],
    'age_limit' => [
        'table' => 'products',
        'type'  => 'addon',
        'check' => true
    ],
    'search_words' => [
        'table' => 'product_descriptions',
        'type'  => 'internal',
        'check' => false
    ]
];

return $schema;