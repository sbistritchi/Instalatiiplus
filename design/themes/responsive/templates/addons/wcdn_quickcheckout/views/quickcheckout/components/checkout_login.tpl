{capture name="checkout_sign_in_login"}
{hook name="checkout:login_form"}
    <div class="ty-checkout__login">
        {include file="views/auth/login_form.tpl" id="checkout_login" style="checkout" result_ids="checkout*,account*"}
    </div>
{/hook}
{/capture}



{if $settings.Checkout.configure_sign_in_step == "returning_customer_first"}
    {$smarty.capture.checkout_sign_in_login nofilter}
    {$smarty.capture.checkout_sign_in_register nofilter}
{else}
    {$smarty.capture.checkout_sign_in_register nofilter}
    {$smarty.capture.checkout_sign_in_login nofilter}
{/if}
