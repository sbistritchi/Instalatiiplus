
    <ul class="ty-payments-list ajax-change">
        {hook name="checkout:payment_method"}
            {foreach from=$payments item="payment"}

                <li class="ty-payments-list__item {if $payment_id == $payment.payment_id}selected{/if}">

                    <input id="payment_{$payment.payment_id}" onclick="fn_calculate_total_shipping_cost_quickcheckout();" class="ty-payments-list__checkbox cm-select-payment form-check-input" type="radio" name="payment_id" value="{$payment.payment_id}"  {if $payment_id == $payment.payment_id}checked="checked"{/if} {if $payment.disabled}disabled{/if} />

                        
                            <label for="payment_{$payment.payment_id}" class="ty-payments-list__item-title">
                                {if $payment.image}
                                    <div class="ty-payments-list__image">
                                    {include file="common/image.tpl" obj_id=$payment.payment_id images=$payment.image class="ty-payments-list__image"}
                                    </div>
                                {/if}
                                {$payment.payment}
                                
                                <small>{$payment.description}</small>
                            </label>
                </li>
            {/foreach}
        {/hook}
    </ul>