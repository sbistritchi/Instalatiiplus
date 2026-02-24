/**
 * Cookie Consent — Instalatii Plus
 * Google Consent Mode v2 integration with localStorage persistence.
 */
(function () {
    'use strict';

    var CONSENT_KEY = 'ipCookieConsent';
    var DATE_KEY = 'ipConsentDate';
    var ANALYTICS_KEY = 'ipAnalyticsStorage';
    var ADS_KEY = 'ipAdStorage';

    var banner = document.getElementById('ip_cookie_consent_banner');
    var settingsBtn = document.getElementById('ip_cookie_settings_btn');

    /**
     * Get consent expiry days from data attribute or default to 30.
     */
    function getExpiryDays() {
        if (banner && banner.dataset.expiryDays) {
            return parseInt(banner.dataset.expiryDays, 10) || 30;
        }
        return 30;
    }

    /**
     * Check if consent is still valid (not expired).
     */
    function isConsentValid() {
        var consent = localStorage.getItem(CONSENT_KEY);
        var consentDate = localStorage.getItem(DATE_KEY);

        if (!consent || !consentDate) {
            return false;
        }

        var saved = new Date(consentDate);
        var now = new Date();
        var diffDays = Math.floor((now - saved) / (1000 * 60 * 60 * 24));

        return diffDays <= getExpiryDays();
    }

    /**
     * Hide banner and save consent timestamp.
     */
    function releaseBanner() {
        localStorage.setItem(CONSENT_KEY, 'granted');
        localStorage.setItem(DATE_KEY, new Date().toISOString());

        if (banner) {
            banner.style.opacity = '0';
            banner.style.transform = 'translateY(100%)';
            setTimeout(function () {
                banner.style.display = 'none';
            }, 300);
        }

        if (settingsBtn) {
            settingsBtn.style.display = '';
        }
    }

    /**
     * Update Google Consent Mode v2.
     */
    function updateGtagConsent(analyticsGranted, adsGranted) {
        if (typeof gtag === 'function') {
            gtag('consent', 'update', {
                'ad_storage': adsGranted ? 'granted' : 'denied',
                'ad_user_data': adsGranted ? 'granted' : 'denied',
                'ad_personalization': adsGranted ? 'granted' : 'denied',
                'analytics_storage': analyticsGranted ? 'granted' : 'denied',
                'functionality_storage': 'granted'
            });
        }
    }

    /**
     * Accept only necessary cookies (deny analytics + marketing).
     */
    window.ipCookieAcceptNecessary = function () {
        localStorage.setItem(ANALYTICS_KEY, 'denied');
        localStorage.setItem(ADS_KEY, 'denied');
        updateGtagConsent(false, false);
        releaseBanner();
    };

    /**
     * Accept based on user checkbox selection.
     */
    window.ipCookieAcceptSelection = function () {
        var analyticsChecked = document.getElementById('ip_cc_analytics');
        var adsChecked = document.getElementById('ip_cc_ads');

        var analytics = analyticsChecked && analyticsChecked.checked;
        var ads = adsChecked && adsChecked.checked;

        localStorage.setItem(ANALYTICS_KEY, analytics ? 'granted' : 'denied');
        localStorage.setItem(ADS_KEY, ads ? 'granted' : 'denied');
        updateGtagConsent(analytics, ads);
        releaseBanner();
    };

    /**
     * Accept all cookies.
     */
    window.ipCookieAcceptAll = function () {
        localStorage.setItem(ANALYTICS_KEY, 'granted');
        localStorage.setItem(ADS_KEY, 'granted');
        updateGtagConsent(true, true);
        releaseBanner();
    };

    /**
     * Re-open cookie settings banner.
     */
    window.ipCookieShowSettings = function () {
        if (!banner) return;

        // Restore checkbox states from saved preferences
        var analyticsBox = document.getElementById('ip_cc_analytics');
        var adsBox = document.getElementById('ip_cc_ads');

        if (analyticsBox) {
            analyticsBox.checked = localStorage.getItem(ANALYTICS_KEY) === 'granted';
        }
        if (adsBox) {
            adsBox.checked = localStorage.getItem(ADS_KEY) === 'granted';
        }

        banner.style.display = '';
        // Trigger reflow for animation
        banner.offsetHeight;
        banner.style.opacity = '1';
        banner.style.transform = 'translateY(0)';

        if (settingsBtn) {
            settingsBtn.style.display = 'none';
        }
    };

    /**
     * Initialize on DOM ready.
     */
    function init() {
        if (!banner) return;

        if (isConsentValid()) {
            // Consent exists and is valid — hide banner, show settings button
            banner.style.display = 'none';
            if (settingsBtn) {
                settingsBtn.style.display = '';
            }
        } else {
            // No consent or expired — show banner
            localStorage.removeItem(CONSENT_KEY);
            localStorage.removeItem(DATE_KEY);
            localStorage.removeItem(ANALYTICS_KEY);
            localStorage.removeItem(ADS_KEY);

            banner.style.display = '';
            // Trigger animation
            setTimeout(function () {
                banner.style.opacity = '1';
                banner.style.transform = 'translateY(0)';
            }, 100);

            if (settingsBtn) {
                settingsBtn.style.display = 'none';
            }
        }
    }

    // Run on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
