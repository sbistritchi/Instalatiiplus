<?php
/***************************************************************************
 *                                                                         *
 *    Copyright (c) SoftSolid. All rights reserved.                        *
 *    https://cs-cart.pl, office@cs-cart.com.pl                            *
 *                                                                         *
 **************************************************************************/
use Tygh\Registry;
use Tygh\Settings;
use Tygh\Languages\Languages;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

/**
 * Pobierz listę języków
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_bl_csmv_product_lang()
{
    $languages = fn_ss_baselinker_product_language();

    return $languages;
} // end function fn_settings_variants_addons_ss_baselinker_ss_bl_csmv_product_lang

/**
 * Lista podatków
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_bl_csmv_tax_id()
{
    $statuses = fn_get_statuses(STATUSES_ORDER, array(), true, true, CART_LANGUAGE);
    $taxes = fn_get_taxes(DESCR_SL);
    $retrun = array();
    foreach ($taxes as $key => $value) {
        $retrun += array($key => $value['tax']);
    } // end foreach

    return $retrun;
} // end function fn_settings_variants_addons_ss_baselinker_ss_bl_csmv_tax_id

/**
 * Lista walut
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_products_currency()
{
   return fn_ss_baselinker_get_currency();
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_products_currency

/**
 * Lista walut
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_orders_currency()
{
    return fn_ss_baselinker_get_currency();
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_orders_currency

/**
 * Pobierz listę języków
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_product_language()
{
    $languages = fn_ss_baselinker_product_language();

    return $languages;
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_product_language

/**
 * Pobranie statusów baselinker
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_default_status()
{
    $token = Settings::instance()->getSettingDataByName("ss_baselinker_token");
    $statuses = fn_ss_baselinker_get_list_statuses($token['value']);
    return $statuses;
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_default_status

/**
 * Lista statusów
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_paid_statuses()
{
    $statuses = fn_get_statuses(STATUSES_ORDER, array(), true, true, CART_LANGUAGE);
    $retrun = array();
    foreach ($statuses as $key => $value) {
        $retrun += array($key => $value['description']);
    } // end foreach

    return $retrun;
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_paid_statuses

/**
 * Lista statusów
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_sbotb_statuses_to_send()
{
    $statuses = fn_get_statuses(STATUSES_ORDER, array(), true, true, CART_LANGUAGE);
    $retrun = array();
    foreach ($statuses as $key => $value) {
        $retrun += array($key => $value['description']);
    } // end foreach

    return $retrun;
} // end function fn_settings_variants_addons_ss_baselinker_sbotb_statuses_to_send

/**
 * Lista statusów
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_pay_status()
{
    return fn_ss_baselinker_pay_status();
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_paid_statuses

/**
 * Pobierz płatności pobraniowe
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_cod_payment()
{
    return fn_get_payments(array("simple" => true, "status" => "A"));
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_cod_payment

/**
 * Pobierz domyślną dostawę
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_default_shipping_id()
{
    return fn_ss_baselinker_default_shipping_id();
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_default_shipping_id

/**
 * Pobierz domyślną płatność
 *
 * @return array
 */
function fn_settings_variants_addons_ss_baselinker_ss_baselinker_default_payment_id()
{
    return fn_ss_baselinker_default_payment_id();
} // end function fn_settings_variants_addons_ss_baselinker_ss_baselinker_default_payment_id

/**
 * Pobierz listę walut
 */
function fn_ss_baselinker_get_currency() {
    // pobierz listę walut
    $currencies = fn_get_currencies_list(array("status" => "A"));
    if (empty($currencies)) {
        $primary_currency = db_get_field("SELECT currency_code FROM ?:currencies WHERE is_primary = ?s", "Y");
        return array($primary_currency => $primary_currency);
    } // end if
    $return = array();
    foreach ($currencies as $key => $value) {
        $return += array($key => $value['currency_code']);
    } // end foreach

    return $return;
} // end function fn_ss_baselinker_get_currency