<?php

use Tygh\Registry;
use Tygh\Settings;

defined('BOOTSTRAP') or die('Access denied');

/**
 * Runs on addon install — disables Klaro cookie consent from GDPR addon.
 */
function fn_ip_cookie_consent_install()
{
    // Disable Klaro by setting GDPR cookie consent to "none"
    $setting = Settings::instance()->getSettingDataByName('gdpr_cookie_consent');
    if (!empty($setting['object_id'])) {
        Settings::instance()->updateValueById($setting['object_id'], 'none');
    }
}

/**
 * Runs on addon uninstall — restores Klaro cookie consent.
 */
function fn_ip_cookie_consent_uninstall()
{
    // Restore GDPR cookie consent to implicit mode
    $setting = Settings::instance()->getSettingDataByName('gdpr_cookie_consent');
    if (!empty($setting['object_id'])) {
        Settings::instance()->updateValueById($setting['object_id'], 'implicit');
    }
}
