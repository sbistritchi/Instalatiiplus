{include file="views/profiles/components/profiles_scripts.tpl"}

{if $runtime.mode == "add" && $settings.General.quick_registration == "Y"}
    <div class="ty-account">
    
        <form name="profiles_register_form" action="{""|fn_url}" method="post">
            {include file="views/profiles/components/profile_fields.tpl" section="C" nothing_extra="Y"}
            {include file="views/profiles/components/profiles_account.tpl" nothing_extra="Y" location="checkout"}

            {hook name="profiles:account_update"}
            {/hook}

            {include file="common/image_verification.tpl" option="register" align="left" assign="image_verification"}
            {if $image_verification}
            <div class="ty-control-group">
                {$image_verification nofilter}
            </div>
            {/if}

            <div class="ty-profile-field__buttons buttons-container">
                {include file="buttons/register_profile.tpl" but_name="dispatch[quickcheckout.add_profile]"}
            </div>
        </form>
    </div>
    {capture name="mainbox_title"}{__("register_new_account")}{/capture}
{else}

    {capture name="tabsbox"}
        <div class="ty-profile-field ty-account form-wrap" id="content_general">
            <form name="profile_form" action="{""|fn_url}" method="post">
                <input id="selected_section" type="hidden" value="general" name="selected_section"/>
                <input id="default_card_id" type="hidden" value="" name="default_cc"/>
                <input type="hidden" name="profile_id" value="{$user_data.profile_id}" />
                {capture name="group"}
                    {include file="views/profiles/components/profiles_account.tpl"}
                    {include file="views/profiles/components/profile_fields.tpl" section="C" title=__("contact_information")}

                    {if $profile_fields.B || $profile_fields.S}
                        {if $settings.General.user_multiple_profiles == "Y" && $runtime.mode == "update"}
                            <p>{__("text_multiprofile_notice")}</p>
                            {include file="views/profiles/components/multiple_profiles.tpl" profile_id=$user_data.profile_id}    
                        {/if}

                        {if $settings.Checkout.address_position == "billing_first"}
                            {assign var="first_section" value="B"}
                            {assign var="first_section_text" value=__("billing_address")}
                            {assign var="sec_section" value="S"}
                            {assign var="sec_section_text" value=__("shipping_address")}
                            {assign var="body_id" value="sa"}
                        {else}
                            {assign var="first_section" value="S"}
                            {assign var="first_section_text" value=__("shipping_address")}
                            {assign var="sec_section" value="B"}
                            {assign var="sec_section_text" value=__("billing_address")}
                            {assign var="body_id" value="ba"}
                        {/if}
                        
                        {include file="views/profiles/components/profile_fields.tpl" section=$first_section body_id="" ship_to_another=true title=$first_section_text}
                        {include file="views/profiles/components/profile_fields.tpl" section=$sec_section body_id=$body_id ship_to_another=true title=$sec_section_text address_flag=$profile_fields|fn_compare_shipping_billing ship_to_another=$ship_to_another}
                    {/if}

                    {hook name="profiles:account_update"}
                    {/hook}

                    {include file="common/image_verification.tpl" option="register" align="center"}

                {/capture}
                {$smarty.capture.group nofilter}

                <div class="ty-profile-field__buttons buttons-container">
				
                    {if $runtime.mode == "create_account"}
                        {include file="buttons/register_profile.tpl" but_name="dispatch[quickcheckout.create_account]" but_id="save_profile_but"}
                    {else}
                        {include file="buttons/save.tpl" but_name="dispatch[quickcheckout.create_account]" but_meta="ty-btn__secondary" but_id="save_profile_but"}
                        <script type="text/javascript">
                        (function(_, $) {
                            var address_switch = $('input:radio:checked', '.ty-address-switch');
                            $("#shipping_address_reset").on("click", function(e) {
                                setTimeout(function() {
                                    address_switch.click();
                                }, 50);
                            });
                        }(Tygh, Tygh.$));
                        </script>
                    {/if}
                </div>
            </form>
        </div>

    {/capture}

    {$smarty.capture.tabsbox nofilter}

{/if}
