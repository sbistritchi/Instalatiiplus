
<div id="step_three_body" class="ty-step__body clearfix">
    

    
		<div class="clearfix">
			<div class="checkout__block">
				<h3>{__("shipping_options")}</h3>
			{hook name="checkout:select_shipping"}
				{if !$cart.shipping_failed}
					{include file="addons/wcdn_quickcheckout/views/quickcheckout/components/shipping_rates.tpl" display="radio"}
				{else}
					<p class="ty-error-text">{__("text_no_shipping_methods")}</p>
				{/if}
			{/hook}
			</div>
		</div>
    </div>


