<?php
/***************************************************************************
 *                                                                         *
 *    Copyright (c) SoftSolid. All rights reserved.                        *
 *    https://cs-cart.pl, office@cs-cart.com.pl                            *
 *                                                                         *
 **************************************************************************/
use Tygh\Registry;

if (fn_allowed_for('MULTIVENDOR')) {
    $schema['top']['settings']["items"]["ss_baselinker_menu"] = array(
        "attrs" => array("class" => "is-addon"),
        "href" => "ss_baselinker_logger.manage",
        "position" => 20,
        "subitems" => array(
            "ss_baselinker_logger_menu"             => array("href" => "ss_baselinker_logger.manage",            "position" => 504),
            "ss_baselinker_fields_send_menu"        => array("href" => "ss_baselinker_fields_send.manage",       "position" => 505),
            "ss_baselinker_vendor_permissions_menu" => array("href" => "ss_baselinker_vendor_permissions.manage","position" => 506),
            "ss_baselinker_extra_fields_menu"       => array("href" => "ss_baselinker_extra_fields.manage",      "position" => 507),
        ),
    );
} else {
    $schema['top']['settings']["items"]["ss_baselinker_menu"] = array(
        "attrs" => array("class" => "is-addon"),
        "href" => "ss_baselinker_logger.manage",
        "position" => 20,
        "subitems" => array(
            "ss_baselinker_logger_menu"       => array("href" => "ss_baselinker_logger.manage",      "position" => 504),
            "ss_baselinker_fields_send_menu"  => array("href" => "ss_baselinker_fields_send.manage", "position" => 505),
            "ss_baselinker_extra_fields_menu" => array("href" => "ss_baselinker_extra_fields.manage","position" => 506),
        ),
    );
} // end if

return $schema;