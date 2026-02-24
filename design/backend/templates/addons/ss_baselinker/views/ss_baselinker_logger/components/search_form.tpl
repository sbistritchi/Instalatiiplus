{if $in_popup}
    <div class="adv-search">
    <div class="group">
{else}
    <div class="sidebar-row">
    <h6>{__("search")}</h6>
{/if}
<form name="{$addon_id}_search_form" action="{""|fn_url}" method="get" class="{$form_meta}">

{if $smarty.request.redirect_url}
<input type="hidden" name="redirect_url" value="{$smarty.request.redirect_url}" />
{/if}

{if $selected_section != ""}
<input type="hidden" id="selected_section" name="selected_section" value="{$selected_section}" />
{/if}

{capture name="simple_search"}
{$extra nofilter}

<div class="sidebar-field">
    <label for="elm_name">{__("ss_baselinker_logger_search_function")}</label>
    <div class="break">
        {assign var="lsf_action" value="`$addon_id`_ls_function"}
        {assign var="lsf" value=$smarty.request.$lsf_action}
        <select name="{$addon_id}_ls_function" id="{$addon_id}_ls_function" class="input-text">
            <option value="">{__("select")} </option>
            <optgroup label="Shop">
            <option {if $lsf == "Shop_SupportedMethods"}selected="selected"{/if} value="Shop_SupportedMethods">Shop_SupportedMethods</option>
            <option {if $lsf == "Shop_FileVersion"}selected="selected"{/if} value="Shop_FileVersion">Shop_FileVersion</option>
            <option {if $lsf == "Shop_ProductsCategories"}selected="selected"{/if} value="Shop_ProductsCategories">Shop_ProductsCategories</option>
            <option {if $lsf == "Shop_ProductsList"}selected="selected"{/if} value="Shop_ProductsList">Shop_ProductsList</option>
            <option {if $lsf == "Shop_ProductAdd"}selected="selected"{/if} value="Shop_ProductAdd">Shop_ProductAdd</option>
            <option {if $lsf == "Shop_CategoryAdd"}selected="selected"{/if} value="Shop_CategoryAdd">Shop_CategoryAdd</option>
            <option {if $lsf == "Shop_ProductsData"}selected="selected"{/if} value="Shop_ProductsData">Shop_ProductsData</option>
            <option {if $lsf == "Shop_ProductsPrices"}selected="selected"{/if} value="Shop_ProductsPrices">Shop_ProductsPrices</option>
            <option {if $lsf == "Shop_ProductsQuantity"}selected="selected"{/if} value="Shop_ProductsQuantity">Shop_ProductsQuantity</option>
            <option {if $lsf == "Shop_ProductsQuantityUpdate"}selected="selected"{/if} value="Shop_ProductsQuantityUpdate">Shop_ProductsQuantityUpdate</option>
            <option {if $lsf == "Shop_ProductsPriceUpdate"}selected="selected"{/if} value="Shop_ProductsPriceUpdate">Shop_ProductsPriceUpdate</option>
            <option {if $lsf == "Shop_OrdersGet"}selected="selected"{/if} value="Shop_OrdersGet">Shop_OrdersGet</option>
            <option {if $lsf == "Shop_StatusesList"}selected="selected"{/if} value="Shop_StatusesList">Shop_StatusesList</option>
            <option {if $lsf == "Shop_DeliveryMethodsList"}selected="selected"{/if} value="Shop_DeliveryMethodsList">Shop_DeliveryMethodsList</option>
            <option {if $lsf == "Shop_PaymentMethodsList"}selected="selected"{/if} value="Shop_PaymentMethodsList">Shop_PaymentMethodsList</option>
            <option {if $lsf == "Shop_OrderAdd"}selected="selected"{/if} value="Shop_OrderAdd">Shop_OrderAdd</option>
            <option {if $lsf == "Shop_OrderUpdate"}selected="selected"{/if} value="Shop_OrderUpdate">Shop_OrderUpdate</option>
            </optgroup>
            {if "MARKETPLACE"|fn_ss_baselinker_allowed_for}
                <optgroup label="Marketplace">
                    <option {if $lsf == "MP_CategoriesList"}selected="selected"{/if} value="MP_CategoriesList">MP_CategoriesList</option>
                    <option {if $lsf == "MP_CategoryDetails"}selected="selected"{/if} value="MP_CategoryDetails">MP_CategoryDetails</option>
                    <option {if $lsf == "MP_CouriersList"}selected="selected"{/if} value="MP_CouriersList">MP_CouriersList</option>
                    <option {if $lsf == "MP_ShipmentMethodsList"}selected="selected"{/if} value="MP_ShipmentMethodsList">MP_ShipmentMethodsList</option>
                    <option {if $lsf == "MP_PaymentMethodsList"}selected="selected"{/if} value="MP_PaymentMethodsList">MP_PaymentMethodsList</option>
                    <option {if $lsf == "MP_OrdersStatusesList"}selected="selected"{/if} value="MP_OrdersStatusesList">MP_OrdersStatusesList</option>
                    <option {if $lsf == "MP_TestConnection"}selected="selected"{/if} value="MP_TestConnection">MP_TestConnection</option>
                    <option {if $lsf == "MP_DeliverySchemasList"}selected="selected"{/if} value="MP_DeliverySchemasList">MP_DeliverySchemasList</option>
                    <option {if $lsf == "MP_ItemsList"}selected="selected"{/if} value="MP_ItemsList">MP_ItemsList</option>
                    <option {if $lsf == "MP_ItemDetails"}selected="selected"{/if} value="MP_ItemDetails">MP_ItemDetails</option>
                    <option {if $lsf == "MP_AddItem"}selected="selected"{/if} value="MP_AddItem">MP_AddItem</option>
                    <option {if $lsf == "MP_UpdateItem"}selected="selected"{/if} value="MP_UpdateItem">MP_UpdateItem</option>
                    <option {if $lsf == "MP_DeleteItem"}selected="selected"{/if} value="MP_DeleteItem">MP_DeleteItem</option>
                    <option {if $lsf == "MP_OrdersList"}selected="selected"{/if} value="MP_OrdersList">MP_OrdersList</option>
                    <option {if $lsf == "MP_OrderDetails"}selected="selected"{/if} value="MP_OrderDetails">MP_OrderDetails</option>
                    <option {if $lsf == "MP_UpdateOrderStatus"}selected="selected"{/if} value="MP_UpdateOrderStatus">MP_UpdateOrderStatus</option>
                    <option {if $lsf == "MP_AddOrderPackage"}selected="selected"{/if} value="MP_AddOrderPackage">MP_AddOrderPackage</option>
                    <option {if $lsf == "MP_UploadInvoice"}selected="selected"{/if} value="MP_UploadInvoice">MP_UploadInvoice</option>
                </optgroup>
            {/if}
        </select>
    </div>
</div>
<div class="sidebar-field">
    <label for="elm_name">{__("action")}</label>
    <div class="break">
        {assign var="var_action" value="`$addon_id`_action"}
        {assign var="action" value=$smarty.request.$var_action}
        <select name="{$addon_id}_action" id="{$addon_id}_action" class="input-text">
            <option value="">{__("select")}</option>
            <option {if $action == "REQUEST"}selected="selected"{/if} value="REQUEST">REQUEST</option>
            <option {if $action == "RESPONSE"}selected="selected"{/if} value="RESPONSE">RESPONSE</option>
            <option {if $action == "INFO"}selected="selected"{/if} value="INFO">INFO</option>
            <option {if $action == "ERROR"}selected="selected"{/if} value="ERROR">ERROR</option>
            <option {if $action == "NOTICE"}selected="selected"{/if} value="NOTICE">NOTICE</option>
            <option {if $action == "ALERT"}selected="selected"{/if} value="ALERT">ALERT</option>
            <option {if $action == "DEBUG"}selected="selected"{/if} value="DEBUG">DEBUG</option>
            <option {if $action == "EMERGENCY"}selected="selected"{/if} value="EMERGENCY">EMERGENCY</option>
            <option {if $action == "WARNING"}selected="selected"{/if} value="WARNING">WARNING</option>
            <option {if $action == "REQ/RES"}selected="selected"{/if} value="REQ/RES">REQ/RES</option>
            {if "MARKETPLACE"|fn_ss_baselinker_allowed_for}
                <option {if $action == "MARKETPLACE"}selected="selected"{/if} value="MARKETPLACE">MARKETPLACE</option>
            {/if}
        </select>
    </div>
</div>
<div class="sidebar-field">
    <label for="elm_name">{__("find_results_with")}</label>
    <div class="break">
        {assign var="search_string" value="`$addon_id`_search_string"}
        <input type="text" name="{$addon_id}_search_string" class="input-text" id="{$addon_id}_search_string" value="{$smarty.request.$search_string}">
    </div>
</div>
<div class="sidebar-field">
    <div class="control-group">
        <div class="controls">
            {include file="addons/`$addon_id`/views/`$addon_id`_logger/components/period_selector.tpl" period=$search.period form_name="`$addon_id`_search_form"}
        </div>
    </div>
</div>

{/capture}

{include file="common/advanced_search.tpl" no_adv_link=true simple_search=$smarty.capture.simple_search dispatch=$dispatch view_type="{$addon_id}"}

</form>

{if $in_popup}
</div></div>
{else}
</div><hr>
{/if}