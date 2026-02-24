{if $settings.Checkout.agree_terms_conditions == "Y"}


        <div class="cm-field-container form-group mb-0">
            {strip}
            <label for="id_accept_terms{$suffix}" class="cm-check-agreement cm-required">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="id_accept_terms{$suffix}" name="accept_terms" value="Y" class="cm-agreement checkbox" {if $iframe_mode}onclick="fn_check_agreements('{$suffix}');"{/if} />
                </div>
                
                {if $runtime.company_id eq 1}
                <div>Am citit si sunt de acord cu  <a target="_blank" href="/termene-si-conditii" class="popup_page">termenii si conditiile</a> si <a target="_blank" href="/politica-de-confidentialitate-gdpr" class="popup_page">politica de confidentialitate</a></div>
				{elseif  $runtime.company_id eq 2}
					<div>Am citit si sunt de acord cu  <a target="_blank" href="/termene-si-conditii-ro" class="popup_page">termenii si conditiile</a> si <a target="_blank" href="/politica-de-confidentialitate" class="popup_page">politica de confidentialitate</a></div>
				{elseif  $runtime.company_id eq 3}
					<div>Am citit si sunt de acord cu  <a target="_blank" href="/termeni-si-conditii/" class="popup_page">termenii si conditiile</a> si <a target="_blank" href="/confidentialitate/" class="popup_page">politica de confidentialitate</a></div>
				{/if}
            
            </label>
            {/strip}
        </div>


{/if}
