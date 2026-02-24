
{if $runtime.mode == "checkout"}
    {if $cart.coupons|floatval}<input type="hidden" name="c_id" value="" />{/if}
    {hook name="checkout:form_data"}
    {/hook}
{/if}

<a href="{"checkout.cart"|fn_url}" class="ty-btn ty-btn-back-to-cart">Inapoi la cos</a>

<div id="cart_items">

	{if $cart_products}
		{foreach from=$cart_products item="product" key="key" name="cart_products"}
			{assign var="obj_id" value=$product.object_id|default:$key}
			<div class="cart-item">
				<div class="image">
					{include file="common/image.tpl" image_width="70" images=$product.main_pair}
				</div>
				
				<div class="name">
					{strip}<a href="{"products.view?product_id=`$product.product_id`"|fn_url}" class="ty-cart-content__product-title">{$product.product nofilter}</a>{/strip}
					
					{if $product.product_options}
						{foreach item="option" from=$product.product_options}
							<div class="options"><span class="option">{$option.option_name}: {if $option.option_type eq "I"}{$option.value}{else}{$option.variants[$option.value].variant_name}{/if}</span></div>
						{/foreach}	
					{/if}
				</div>

				
				<div class="price">
					{if $product.list_price > $product.display_price}
						{if $product.amount > 1}{$product.amount} x {/if}{include file="common/price.tpl" value=$product.list_price span_id="product_price_`$key`" class="ty-sub-price"}
					{/if}
					
					{if $product.amount > 1}{$product.amount} x {/if}{include file="common/price.tpl" value=$product.display_price span_id="product_price_`$key`" class="ty-price"}
				</div>
			</div>
		{/foreach}
	{/if}


</div>

