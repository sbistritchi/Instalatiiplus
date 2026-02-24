
{assign var="result_ids" value="checkout_totals,cart_status*,checkout*"}

<div class="cm-tabs-content cm-j-content-disable-convertation tabs-content clearfix">
    {foreach from=$payment_methods key="tab_id" item="payments"}
        <div id="content_payments_{$tab_id}">

            <input type="hidden" name="payment_id" value="{$payment_id}" />
            <input type="hidden" name="result_ids" value="{$result_ids}" />
            <input type="hidden" name="dispatch" value="quickcheckout.place_order" />

            {if $order_id}
                <input type="hidden" name="order_id" value="{$order_id}" />
            {else}
                <div class="ty-checkout__billing-options {if $payment_methods|count == 1}ty-notab{/if}">
            {/if}

            {include file="addons/wcdn_quickcheckout/views/quickcheckout/components/payments/payments_list.tpl"}

       </div>
        <!--content_payments_{$tab_id}--></div>
    {/foreach}
</div>


