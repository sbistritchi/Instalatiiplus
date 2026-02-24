<?php
/***************************************************************************
 *                                                                         *
 *    Copyright (c) SoftSolid. All rights reserved.                        *
 *    https://cs-cart.pl, office@cs-cart.com.pl                            *
 *                                                                         *
 **************************************************************************/

/**
 * Możliwość zablokowania dostępu do logów przez innych adminów
 */
$schema['ss_baselinker_logger'] = array (
    'modes' => array (
        'manage' => array(
            'permissions' => 'ss_baselinker_logger.manage'
        ),
        'show' => array(
            'permissions' => 'ss_baselinker_logger.show'
        ),
    )
);

/**
 * Możliwość zablokowania dostępu do edycji pól profilu
 */
$schema['ss_baselinker_fields_send'] = array (
    'modes' => array (
        'manage' => array(
            'permissions' => 'ss_baselinker_fields_send.manage'
        ),
        'view' => array(
            'permissions' => 'ss_baselinker_fields_send.view'
        ),
    )
);

/**
 * Możliwość zablokowania dostępu do mapowania dodatkowych pól przy produkcie w BL
 */
$schema['ss_baselinker_extra_fields'] = array (
    'modes' => array (
        'manage' => array(
            'permissions' => 'ss_baselinker_extra_fields.manage'
        ),
        'view' => array(
            'permissions' => 'ss_baselinker_extra_fields.view'
        ),
    )
);

/**
 * Możliwość zablokowania dostępu do logów przez innych adminów
 */
$schema['ss_baselinker_vendor_permissions'] = array (
    'modes' => array (
        'manage' => array(
            'permissions' => 'ss_baselinker_vendor_permissions.manage'
        ),
        'view' => array(
            'permissions' => 'ss_baselinker_vendor_permissions.view'
        ),
    )
);

return $schema;