<?php
/***************************************************************************
 *                                                                         *
 *    Copyright (c) SoftSolid. All rights reserved.                        *
 *    https://cs-cart.pl, office@cs-cart.com.pl                            *
 *                                                                         *
 **************************************************************************/

$schema['controllers']['ss_baselinker_logger'] = array (
    'permissions' => true,
);

/**
 * Możliwo�.�. zablokowania dost�.pu do mapowania dodatkowych pól przy produkcie w BL
 */
$schema['controllers']['ss_baselinker_extra_fields'] = array (
    'modes' => array (
        'manage' => array(
            'permissions' => 'ss_baselinker_extra_fields.manage'
        ),
        'view' => array(
            'permissions' => 'ss_baselinker_extra_fields.view'
        ),
    )
);

return $schema;