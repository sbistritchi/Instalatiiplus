
{assign var="result_ids" value="checkout_totals,cart_status*,checkout*"}
<input type="hidden" name="result_ids" value="{$result_ids}" />

<div class="ty-mainbox-cart__body">
{include file="addons/wcdn_quickcheckout/views/quickcheckout/components/cart_items.tpl" disable_ids="button_cart"}

{include file="addons/wcdn_quickcheckout/views/quickcheckout/components/checkout_totals.tpl" location="checkout"}

</div>