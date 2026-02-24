{script src="js/tygh/checkout.js"}
{include file="views/profiles/components/profiles_scripts.tpl"}

<div class="quickcheckout mb-5">

	
		<div class="row row-to-order">	
			<div class="ty-checkout-block-left">
				<a href="/" class="href-logo"><img src="{$logos.theme.image.image_path}" class="logo" /></a>
				
				
				
					<form name="paymens_form" action="{""|fn_url}" method="post" enctype="multipart/form-data">
						<div class="main-checkout-content">
						
				
						
							{if !$smarty.session.auth.user_id}
				<div class="checkout__block" style="margin-top: 20px;">
					<div class="co-login">
						Ai deja un cont?
						<a class="co-login-1" href="/index.php?dispatch=client.login&return_url=index.php%3Fdispatch%3Dquickcheckout.checkout">Autentificare</a>
					</div>
				</div>
				{/if}
							{include file="addons/wcdn_quickcheckout/views/quickcheckout/steps/step_two.tpl" edit=true}
							
								{if $cart.shipping_required}
								<div class="ty-checkout-shipping py-3"  id="step_three">
									{include file="addons/wcdn_quickcheckout/views/quickcheckout/steps/step_three.tpl" edit=true}
								</div>
							{/if}

							<div class="ty-checkout-billing py-3" id="step_four">
								{include file="addons/wcdn_quickcheckout/views/quickcheckout/steps/step_four.tpl" edit=true}
							</div>
					
							<div class="ty-checkout-billing py-3" id="step_four">
							{include file="addons/wcdn_quickcheckout/views/quickcheckout/components/final_section.tpl" edit=true}
							</div>
					
						</div>
					</form>
			</div>
			
			
			<div class="ty-checkout-block-right">
				<div class="ty-checkout-block last-block sticky-top" style="top:20px">
					{include file="addons/wcdn_quickcheckout/views/quickcheckout/components/cart_content.tpl"}
				</div> 
				
			</div>
		</div>
	
</div>

