<div class="ty-cart-total">
    <div class="ty-cart-total__wrapper clearfix" id="checkout_totals">

        {hook name="checkout:payment_options"}
        {/hook}
        
        <ul class="ty-cart-statistic ty-statistic-list">
		<li class="ty-cart-statistic__item ty-statistic-list-subtotal">
			<span class="ty-cart-statistic__title">Total produse</span>
			<span class="ty-cart-statistic__value">{include file="common/price.tpl" value=$cart.display_subtotal}</span>
		</li>
		
		{hook name="checkout:checkout_totals"}
		

				<li class="ty-cart-statistic__item ty-statistic-list-subtotal">
					<span class="ty-cart-statistic__title">Cost transport</span>
					<span class="ty-cart-statistic__value">{include file="common/price.tpl" value=$cart.display_shipping_cost}</span>
				</li>

			
		{/hook}
		
		
		<li class="ty-cart-statistic__item ty-statistic-list-discount" style="display: inline-block;width: 100%;">
			{include file="addons/wcdn_quickcheckout/views/quickcheckout/components/promotion_coupon.tpl"}
		</li>
		
		{if ($cart.discount|floatval)}
		<li class="ty-cart-statistic__item ty-statistic-list-discount">
			<span class="ty-cart-statistic__title">Reduceri</span>
			<span class="ty-cart-statistic__value discount-price">-{include file="common/price.tpl" value=$cart.discount}</span>
		</li>
		
		{/if}

		{if ($cart.subtotal_discount|floatval)}
		<li class="ty-cart-statistic__item ty-statistic-list-subtotal-discount">
			<span class="ty-cart-statistic__title">Reduceri</span>
			<span class="ty-cart-statistic__value discount-price">-{include file="common/price.tpl" value=$cart.subtotal_discount}</span>
		</li>
		{hook name="checkout:checkout_discount"}{/hook}
		{/if}

		<li class="ty-cart-statistic__item ty-statistic-list-total">
                <span class="ty-cart-statistic__title">{__("total_cost")}</span>
                <span class="ty-cart-statistic__value">{include file="common/price.tpl" value=$_total|default:$smarty.capture._total|default:$cart.total span_id="cart_total" class="ty-price"}</span>
            </li>
	</ul>

    <!--checkout_totals--></div>
	
	        
</div>
