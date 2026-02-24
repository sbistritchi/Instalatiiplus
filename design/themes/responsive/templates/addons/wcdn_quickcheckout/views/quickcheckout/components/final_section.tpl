{$show_place_order = false}

{if $cart|fn_allow_place_order:$auth}
    {$show_place_order = true}
{/if}

{if $recalculate && !$cart.amount_failed}
    {$show_place_order = true}
{/if}

{if $show_place_order}

	
    <div class="clearfix {if !$is_payment_step} checkout__block{/if} customer-notes-terms">
    
    	
        
        {include file="addons/wcdn_quickcheckout/views/quickcheckout/components/customer_notes.tpl"}
       {hook name="checkout:final_section_customer_notess"} {/hook}
        
        {if !$suffix}
            {assign var="suffix" value=""|uniqid}
        {/if}
        {include file="addons/wcdn_quickcheckout/views/quickcheckout/components/terms_and_conditions.tpl" suffix=$suffix}
    </div>

    <input type="hidden" name="update_steps" value="1" />
    
    {if !$is_payment_step}
        <div class="clearfix">
            <div class="ty-checkout-buttons cm-checkout-place-order-buttons">
                {include file="buttons/place_order.tpl" but_text=__("submit_my_order") but_name="dispatch[quickcheckout.place_order]" but_id="place_order"}
            </div>

            {if $recalculate && $cart.shipping_required}
                <input type="hidden" name="next_step" value="step_two" />
                <div class="ty-checkout-buttons cm-checkout-recalculate-buttons hidden">
                    {include file="buttons/button.tpl" but_meta="ty-btn__secondary cm-checkout-recalculate" but_name="dispatch[checkout.update_steps]" but_text=__("recalculate_shipping_cost")}
                </div>
            {/if}
        </div>
    {/if}

{else}

    {if $cart.shipping_failed}
        <p class="ty-error-text ty-center">{__("text_no_shipping_methods")}</p>
    {/if}

    {if $cart.amount_failed}
        <div class="checkout__block">
            <p class="ty-error-text">{__("text_min_order_amount_required")}&nbsp;<strong>{include file="common/price.tpl" value=$settings.General.min_order_amount}</strong></p>
        </div>
    {/if}

    <div class="ty-checkout-buttons">
        {include file="buttons/continue_shopping.tpl" but_href=$continue_url|fn_url but_role="action"}
    </div>
    
{/if}

<div class="checkout-footer pt-5" style="margin-top: 20px;">
        <p class="text-center">
        	
        	<img src="images/logo_visa.svg" alt="VISA" style="max-height: 20px;">
        	<img src="images/logo_mastercard.svg" alt="Mastercard" style="max-height:  20px;">
        	<img src="images/logo_maestro.svg" alt="Maestro" style="max-height:  20px;">
        	</p>


        <div class="secure-checkout">
                <p class="mb-0"><img src="images/padlock.svg" alt="secure" style="max-height:  14px; margin-right: 5px;"> Comanda securizata</p>
        </div>

</div>


<script>

    document.getElementById('upload_invoice').addEventListener('change', function(e)
    {
		const fileName = e.target.files[0].name;
		const fileType = e.target.files[0].type;

		
		if (fileType !== 'application/pdf')
		{
			$("#upload_invoice").parent().append('<span id="upload_invoice_error_message" class="help-inline"><p>Se accepta doar fisiere PDF</p></span>');
			
			e.target.value = ''; // Clear the input
			document.querySelector('.form-group.file-upload.cm-invoice label').textContent = 'Incarca Factura';
			return;
		}

		// Update the label's text content
		document.querySelector('.form-group.file-upload.cm-invoice label').textContent = fileName;
		$("#upload_invoice_error_message").remove();
	});
	

    document.getElementById('upload_awb').addEventListener('change', function(e)
    {
		const fileName = e.target.files[0].name;
		const fileType = e.target.files[0].type;

		
		if (fileType !== 'application/pdf')
		{
			$("#upload_awb").parent().append('<span id="upload_awb_error_message" class="help-inline"><p>Se accepta doar fisiere PDF</p></span>');
			
			e.target.value = ''; // Clear the input
			document.querySelector('.form-group.file-upload.cm-awb label').textContent = 'Incarca AWB';
			return;
		}

		// Update the label's text content
		document.querySelector('.form-group.file-upload.cm-awb label').textContent = fileName;
		$("#upload_awb_error_message").remove();
	});
	
</script>