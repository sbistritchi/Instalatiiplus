

    <div class="ty-step__body" id="step_two_body">
    
    	

            {if $smarty.request.profile == "new"}
                {assign var="hide_profile_name" value=false}
            {else}
                {assign var="hide_profile_name" value=true}
            {/if}
            
            {$address_flag = true}
            
			 {if $cart.chosen_shipping[0] == 7 || $cart.chosen_shipping[0] == 10}
				{$settings.Checkout.address_position = "billing_first"}
				{$profile_fields[$sec_section] = false}
				{$address_flag = false}
			{else}
				{$settings.Checkout.address_position = "shipping_first"}
				{$address_flag =true}
			{/if}
			
            
            {if $settings.Checkout.address_position == "billing_first"}
                {assign var="first_section" value="B"}
                {assign var="first_section_text" value=__("billing_address")}
                {assign var="sec_section" value="S"}
                {assign var="sec_section_text" value=__("shipping_address")}
                {assign var="ship_to_another_text" value=__("text_ship_to_billing")}
                {assign var="body_id" value="sa"}
            {else}
                {assign var="first_section" value="S"}
                {assign var="first_section_text" value=__("shipping_address")}
                {assign var="sec_section" value="B"}
                {assign var="sec_section_text" value=__("billing_address")}
                {assign var="ship_to_another_text" value=__("text_billing_same_with_shipping")}
                {assign var="body_id" value="ba"}
            {/if}

			{if $cart.chosen_shipping[0] == 7}
				{$profile_fields[$sec_section] = false}
			{/if}
			
			{if $cart.chosen_shipping[0] == 10}
				{$profile_fields[$sec_section] = false}
				
				{$profile_fields['B'][14].required = 'Y'}
				{$profile_fields['B'][16].required = 'Y'}
				{$profile_fields['B'][24].required = 'Y'}
				{$profile_fields['B'][22].required = 'Y'}
				{$profile_fields['B'][18].required = 'Y'}
				{$profile_fields['B'][30].required = 'Y'}
				
			{/if}
			
			{$email_field = $profile_fields['C'][32]}
			{$profile_ss = $profile_fields[$first_section]|array_unshift:$email_field}
			

			{if $profile_fields[$first_section]}
				<div class="clearfix" data-ct-address="billing-address" id="shipping_section">
					<div class="checkout__block">
						
						{include file="addons/wcdn_quickcheckout/views/profiles/components/profile_fields.tpl" section=$first_section body_id="" ship_to_another=false address_flag=false title=$first_section_text}
					</div>
				<!--shipping_section--></div>
			{/if}

			{if $profile_fields[$sec_section]}
				<div class="clearfix shipping-address__switch" data-ct-address="shipping-address" id="billing_section">
					<div class="checkout__block">
						{include file="addons/wcdn_quickcheckout/views/profiles/components/profile_fields.tpl" nothing_extra=true section=$sec_section body_id=$body_id address_flag=$address_flag ship_to_another=$cart.ship_to_another title=$sec_section_text grid_wrap="checkout__block"}
					</div>
				<!--billing_section--></div>
			{/if}
<!--step_two_body--></div>