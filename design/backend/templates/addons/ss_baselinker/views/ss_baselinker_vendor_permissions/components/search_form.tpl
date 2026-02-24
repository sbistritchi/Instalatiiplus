{if $in_popup}
    <div class="adv-search">
    <div class="group">
{else}
    <div class="sidebar-row">
    <h6>{__("search")}</h6>
{/if}
<form name="ss_baselinker__search_form" action="{""|fn_url}" method="get" class="{$form_meta}">

{if $smarty.request.redirect_url}
<input type="hidden" name="redirect_url" value="{$smarty.request.redirect_url}" />
{/if}

{if $selected_section != ""}
<input type="hidden" id="selected_section" name="selected_section" value="{$selected_section}" />
{/if}

{if $put_request_vars}
    {array_to_fields data=$smarty.request skip=["callback"] escape=["data_id"]}
{/if}

{capture name="simple_search"}
{$extra nofilter}

<div class="sidebar-field">
<label for="elm_name">{__("ss_baselinker_fields_send_baselinker_field_field")}</label>
<div class="break">
                        <select name="ss_baselinker_fields_send_baselinker_field" id="elm_ss_baselinker_fields_send_baselinker_field_ss_baselinker_fields_send" class="input-text">
                            <option value="delivery_fullname" {if $ss_baselinker_fields_send.baselinker_field == "delivery_fullname"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_fullname")}</option>
                            <option value="delivery_company" {if $ss_baselinker_fields_send.baselinker_field == "delivery_company"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_company")}</option>
                            <option value="delivery_address" {if $ss_baselinker_fields_send.baselinker_field == "delivery_address"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_address")}</option>
                            <option value="delivery_city" {if $ss_baselinker_fields_send.baselinker_field == "delivery_city"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_city")}</option>
                            <option value="delivery_postcode" {if $ss_baselinker_fields_send.baselinker_field == "delivery_postcode"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_postcode")}</option>
                            <option value="delivery_country" {if $ss_baselinker_fields_send.baselinker_field == "delivery_country"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_country")}</option>
                            <option value="invoice_fullname" {if $ss_baselinker_fields_send.baselinker_field == "invoice_fullname"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_fullname")}</option>
                            <option value="invoice_company" {if $ss_baselinker_fields_send.baselinker_field == "invoice_company"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_company")}</option>
                            <option value="invoice_address" {if $ss_baselinker_fields_send.baselinker_field == "invoice_address"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_address")}</option>
                            <option value="invoice_city" {if $ss_baselinker_fields_send.baselinker_field == "invoice_city"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_city")}</option>
                            <option value="invoice_postcode" {if $ss_baselinker_fields_send.baselinker_field == "invoice_postcode"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_postcode")}</option>
                            <option value="invoice_country" {if $ss_baselinker_fields_send.baselinker_field == "invoice_country"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_country")}</option>
                            <option value="invoice_nip" {if $ss_baselinker_fields_send.baselinker_field == "invoice_nip"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_nip")}</option>
                            <option value="user_comments" {if $ss_baselinker_fields_send.baselinker_field == "user_comments"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_user_comments")}</option>
                        </select>
</div>
</div>


{/capture}

{include file="common/advanced_search.tpl" no_adv_link=true simple_search=$smarty.capture.simple_search dispatch=$dispatch view_type="ss_baselinker_"}

</form>

{if $in_popup}
</div></div>
{else}
</div><hr>
{/if}