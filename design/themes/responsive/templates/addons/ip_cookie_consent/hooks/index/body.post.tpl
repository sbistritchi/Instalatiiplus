{* Cookie Consent Banner — Instalatii Plus *}
{* Google Consent Mode v2: Default deny-all (must load BEFORE any tracking scripts) *}
<script data-no-defer>
    window.dataLayer = window.dataLayer || [];
    function gtag(){ldelim}dataLayer.push(arguments);{rdelim}

    gtag('consent', 'default', {ldelim}
        'ad_storage': 'denied',
        'ad_user_data': 'denied',
        'ad_personalization': 'denied',
        'analytics_storage': 'denied',
        'functionality_storage': 'denied',
        'personalization_storage': 'denied',
        'security_storage': 'granted',
        'wait_for_update': 500
    {rdelim});

    {* Restore saved consent if exists and not expired *}
    (function() {ldelim}
        var consent = localStorage.getItem('ipCookieConsent');
        var consentDate = localStorage.getItem('ipConsentDate');
        if (consent && consentDate) {ldelim}
            var saved = new Date(consentDate);
            var now = new Date();
            var diffDays = Math.floor((now - saved) / (1000 * 60 * 60 * 24));
            if (diffDays <= {$addons.ip_cookie_consent.consent_expiry_days|default:30}) {ldelim}
                var analytics = localStorage.getItem('ipAnalyticsStorage') || 'denied';
                var ads = localStorage.getItem('ipAdStorage') || 'denied';
                gtag('consent', 'update', {ldelim}
                    'ad_storage': ads,
                    'ad_user_data': ads,
                    'ad_personalization': ads,
                    'analytics_storage': analytics,
                    'functionality_storage': 'granted'
                {rdelim});
            {rdelim}
        {rdelim}
    {rdelim})();
</script>

{* Cookie Consent Banner UI *}
<div class="ip-cookie-consent" id="ip_cookie_consent_banner" style="display:none;">
    <div class="ip-cookie-consent__inner">
        <div class="ip-cookie-consent__content">
            <h3 class="ip-cookie-consent__title">{__("ip_cc.title")}</h3>
            <p class="ip-cookie-consent__desc">{__("ip_cc.description")}</p>

            <div class="ip-cookie-consent__categories">
                {* Necesare — always on *}
                <div class="ip-cookie-consent__category">
                    <label class="ip-cookie-consent__toggle">
                        <input type="checkbox" checked disabled />
                        <span class="ip-cookie-consent__slider ip-cookie-consent__slider--locked"></span>
                        <span class="ip-cookie-consent__label">{__("ip_cc.necessary_title")}</span>
                    </label>
                    <p class="ip-cookie-consent__category-desc">{__("ip_cc.necessary_desc")}</p>
                </div>

                {* Statistici *}
                <div class="ip-cookie-consent__category">
                    <label class="ip-cookie-consent__toggle">
                        <input type="checkbox" name="ip_cc_analytics" id="ip_cc_analytics" />
                        <span class="ip-cookie-consent__slider"></span>
                        <span class="ip-cookie-consent__label">{__("ip_cc.statistics_title")}</span>
                    </label>
                    <p class="ip-cookie-consent__category-desc">{__("ip_cc.statistics_desc")}</p>
                </div>

                {* Marketing *}
                <div class="ip-cookie-consent__category">
                    <label class="ip-cookie-consent__toggle">
                        <input type="checkbox" name="ip_cc_ads" id="ip_cc_ads" />
                        <span class="ip-cookie-consent__slider"></span>
                        <span class="ip-cookie-consent__label">{__("ip_cc.marketing_title")}</span>
                    </label>
                    <p class="ip-cookie-consent__category-desc">{__("ip_cc.marketing_desc")}</p>
                </div>
            </div>
        </div>

        <div class="ip-cookie-consent__actions">
            <button type="button" class="ip-cookie-consent__btn ip-cookie-consent__btn--necessary" onclick="ipCookieAcceptNecessary()">
                {__("ip_cc.accept_necessary")}
            </button>
            <button type="button" class="ip-cookie-consent__btn ip-cookie-consent__btn--selection" onclick="ipCookieAcceptSelection()">
                {__("ip_cc.accept_selection")}
            </button>
            <button type="button" class="ip-cookie-consent__btn ip-cookie-consent__btn--all" onclick="ipCookieAcceptAll()">
                {__("ip_cc.accept_all")}
            </button>
        </div>

        <div class="ip-cookie-consent__footer">
            <a href="{$addons.ip_cookie_consent.cookie_policy_url|default:'/politica-de-cookies'}" class="ip-cookie-consent__link" target="_blank">
                {__("ip_cc.read_more")}
            </a>
        </div>
    </div>
</div>

{* Persistent footer button to re-open cookie settings *}
{if $addons.ip_cookie_consent.show_settings_button == "Y"}
<button type="button" class="ip-cookie-settings-btn" id="ip_cookie_settings_btn" style="display:none;" onclick="ipCookieShowSettings()">
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="12" cy="12" r="3"></circle>
        <path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"></path>
    </svg>
    {__("ip_cc.settings_button")}
</button>
{/if}
