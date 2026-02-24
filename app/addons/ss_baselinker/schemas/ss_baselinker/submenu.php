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
    'ss_baselinker_sidebar_links_menu' => [
        'ss_baselinker_extra_fields_sidebar_link_menu' => [
            'dispatch' => 'ss_baselinker_extra_fields.manage'
        ],
        'ss_baselinker_fields_send_sidebar_link_menu' => [
            'dispatch' => 'ss_baselinker_fields_send.manage'
        ],
        'ss_baselinker_logger_sidebar_link_menu' => [
            'dispatch' => 'ss_baselinker_logger.manage'
        ],
    ]
];

return $schema;