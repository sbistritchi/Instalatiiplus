{if $ss_baselinker_vendor_permissions}
    {assign var="ss_baselinker_vendor_permissions_id" value=$ss_baselinker_vendor_permissions.ss_baselinker_vendor_permissions_id}
{else}
    {assign var="ss_baselinker_vendor_permissions_id" value=0}
{/if}

{capture name="mainbox"}
    <form action="{""|fn_url}" method="post" name="ss_baselinker_vendor_permissions_form" class="form-horizontal form-edit {if ""|fn_check_form_permissions} cm-hide-inputs{/if}">
        <input type="hidden" class="cm-no-hide-input" name="fake" value="1" />
        <input type="hidden" class="cm-no-hide-input" name="ss_baselinker_vendor_permissions_id" value="{$ss_baselinker_vendor_permissions_id}" />
        <div id="content_general">
            <fieldset>
                <div class="control-group">
                    <label class="control-label cm-required" for="elm_ss_baselinker_vendor_permissions_name">{__("ss_baselinker_vendor_permissions_name_field")}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_vendor_permissions[name]" id="elm_ss_baselinker_vendor_permissions_name" size="35" value="{$ss_baselinker_vendor_permissions.name}" class="input-medium" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label " for="elm_ss_baselinker_vendor_permissions_field_name">{__("ss_baselinker_vendor_permissions_field_name_field")}:</label>
                    <div class="controls">
                        <select name="ss_baselinker_vendor_permissions[field_name]" id="elm_ss_baselinker_vendor_permissions_field_name_ss_baselinker_vendor_permissions" class="input-text">
                            <option value="ss_baselinker_export_statuses" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_export_statuses"}selected="selected"{/if}>{__("ss_baselinker_export_statuses_short")}</option>
                            <option value="ss_baselinker_option_type" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_option_type"}selected="selected"{/if}>{__("ss_baselinker_option_type")}</option>
                            <option value="ss_baselinker_promotion_price" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_promotion_price"}selected="selected"{/if}>{__("ss_baselinker_promotion_price")}</option>
                            <option value="ss_baselinker_use_bl_name" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_use_bl_name"}selected="selected"{/if}>{__("ss_baselinker_use_bl_name")}</option>
                            <option value="ss_baselinker_use_bl_description" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_use_bl_description"}selected="selected"{/if}>{__("ss_baselinker_use_bl_description")}</option>
                            <option value="ss_baselinker_product_language" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_product_language"}selected="selected"{/if}>{__("ss_baselinker_product_language")}</option>
                            <option value="ss_baselinker_products_currency" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_products_currency"}selected="selected"{/if}>{__("ss_baselinker_products_currency")}</option>
                            <option value="ss_baselinker_cod_payment" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_cod_payment"}selected="selected"{/if}>{__("ss_baselinker_cod_payment")}</option>
                            <option value="ss_baselinker_orders_currency" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_orders_currency"}selected="selected"{/if}>{__("ss_baselinker_orders_currency")}</option>
                            <option value="ss_baselinker_default_shipping_id" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_default_shipping_id"}selected="selected"{/if}>{__("ss_baselinker_default_shipping_id")}</option>
                            <option value="ss_baselinker_default_payment_id" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_default_payment_id"}selected="selected"{/if}>{__("ss_baselinker_default_payment_id")}</option>
                            <option value="ss_baselinker_pay_status" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_pay_status"}selected="selected"{/if}>{__("ss_baselinker_pay_status")}</option>
                            <option value="ss_baselinker_apply_catalog_promotions" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_apply_catalog_promotions"}selected="selected"{/if}>{__("ss_baselinker_apply_catalog_promotions")}</option>
                            <option value="ss_baselinker_apply_cart_promotions" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_apply_cart_promotions"}selected="selected"{/if}>{__("ss_baselinker_apply_cart_promotions")}</option>
                            <option value="ss_baselinker_update_orders" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_update_orders"}selected="selected"{/if}>{__("ss_baselinker_update_orders")}</option>
                            <option value="ss_baselinker_logs" {if $ss_baselinker_vendor_permissions.field_name == "ss_baselinker_logs"}selected="selected"{/if}>{__("ss_baselinker_logs")}</option>
                        </select>
                    </div>
                </div>
                {assign var="companies" value=1|fn_ss_baselinker_get_companies}
                <div class="control-group">
                    <label class="control-label " for="elm_ss_baselinker_vendor_permissions_vendors">{__("ss_baselinker_vendor_permissions_vendors_field")}:</label>
                    <div class="controls">
                        <select name="ss_baselinker_vendor_permissions[vendors]" id="elm_ss_baselinker_vendor_permissions_vendors_ss_baselinker_vendor_permissions" class="input-text">
                            <option value="0" {if $ss_baselinker_vendor_permissions.vendors == "0"}selected="selected"{/if}>{__("all_vendors")}</option>
                            {foreach from=$companies.0 item=company_data}
                                <option value="{$company_data.company_id}" {if $ss_baselinker_vendor_permissions.vendors == $company_data.company_id}selected="selected"{/if}>{$company_data.company}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                {include file="common/select_status.tpl" input_name="ss_baselinker_vendor_permissions[status]" id="elm_ss_baselinker_vendor_permissions_status" obj=$ss_baselinker_vendor_permissions}
            </fieldset>
        </div>

        {capture name="buttons"}
            {include file="buttons/save_cancel.tpl" but_name="dispatch[ss_baselinker_vendor_permissions.update]" but_role="submit-link" but_target_form="ss_baselinker_vendor_permissions_form" save=$ss_baselinker_vendor_permissions_id} 
        {/capture}
    </form>
{/capture}

{if $ss_baselinker_vendor_permissions}
    {include file="common/mainbox.tpl" title="{__("ss_baselinker_vendor_permissions_edit")}: `$ss_baselinker_vendor_permissions.name`" content=$smarty.capture.mainbox select_languages=true buttons=$smarty.capture.buttons}
{else}
    {include file="common/mainbox.tpl" title=__("ss_baselinker_vendor_permissions_new") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons}
{/if}