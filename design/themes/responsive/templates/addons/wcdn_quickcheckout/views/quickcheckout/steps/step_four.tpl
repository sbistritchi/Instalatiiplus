{script src="js/tygh/tabs.js"}

    <div id="step_four_body" class="ty-step__body">
    	
    	
        <div class="clearfix ty-checkout__billing-tabs">
             <div class="checkout__block">
             	<h3>{__("billing_options")}</h3>

                {if $cart|fn_allow_place_order:$auth}
                    {if $cart.payment_id}
                        <div class="clearfix">
                            {include file="addons/wcdn_quickcheckout/views/quickcheckout/components/payments/payment_methods.tpl" payment_id=$cart.payment_id}
                        </div>
                    {/if}
                {/if}
			</div>
        </div>
    </div>


<div id="place_order_data" class="hidden">
</div>