<style>
    #resp-table {
        width: 100%;
        display: table;
    }
    #resp-table-caption{
        display: table-caption;
        text-align: left;
        font-size: 16px;
        font-weight: bold;
        padding: 10px;
    }
    #resp-table-header{
        display: table-header-group;
        background-color: gray;
        font-weight: bold;
        font-size: 18px;
        text-align: left;
    }
    .table-header-cell{
        display: table-cell;
        padding: 20px;
        text-align: left;
        border-bottom: 1px solid black;
    }
    #resp-table-body{
        display: table-row-group;
    }
    .resp-table-row{
        display: table-row;
    }
    .table-body-cell{
        display: table-cell;
        padding: 5px 20px 5px 20px;
        font-size: 14px;
        font-weight:bold;
    }
</style>

{if $ss_baselinker_fields_send}
    {assign var="ss_baselinker_fields_send_id" value=$ss_baselinker_fields_send.ss_baselinker_fields_send_id}
{else}
    {assign var="ss_baselinker_fields_send_id" value=0}
{/if}

{capture name="mainbox"}
    <form action="{""|fn_url}" method="post" name="ss_baselinker_fields_send_form" class="form-horizontal form-edit {if ""|fn_check_form_permissions} cm-hide-inputs{/if}">
        <input type="hidden" class="cm-no-hide-input" name="fake" value="1" />
        <input type="hidden" class="cm-no-hide-input" name="ss_baselinker_fields_send_id" value="{$ss_baselinker_fields_send_id}" />
        <div id="content_general">
            <fieldset>
                <div class="control-group">
                    <label class="control-label cm-required" for="elm_ss_baselinker_fields_send_name">{__("ss_baselinker_fields_send_name_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_fields_send_name_tooltip)}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_fields_send[name]" id="elm_ss_baselinker_fields_send_name" size="35" value="{$ss_baselinker_fields_send.name}" class="input-medium" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label " for="elm_ss_baselinker_fields_send_baselinker_field">{__("ss_baselinker_fields_send_baselinker_field_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_fields_send_baselinker_field_tooltip)}:</label>
                    <div class="controls">
                        <select name="ss_baselinker_fields_send[baselinker_field]" id="elm_ss_baselinker_fields_send_baselinker_field_ss_baselinker_fields_send" class="input-text">
                            <option value="">{__("select")}</option>
                            <option value="delivery_fullname" {if $ss_baselinker_fields_send.baselinker_field == "delivery_fullname"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_fullname")}</option>
                            <option value="delivery_company"  {if $ss_baselinker_fields_send.baselinker_field == "delivery_company"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_company")}</option>
                            <option value="delivery_address"  {if $ss_baselinker_fields_send.baselinker_field == "delivery_address"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_address")}</option>
                            <option value="delivery_city"     {if $ss_baselinker_fields_send.baselinker_field == "delivery_city"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_city")}</option>
                            <option value="delivery_postcode" {if $ss_baselinker_fields_send.baselinker_field == "delivery_postcode"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_postcode")}</option>
                            <option value="delivery_country"  {if $ss_baselinker_fields_send.baselinker_field == "delivery_country"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_delivery_country")}</option>
                            <option value="invoice_fullname"  {if $ss_baselinker_fields_send.baselinker_field == "invoice_fullname"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_fullname")}</option>
                            <option value="invoice_company"   {if $ss_baselinker_fields_send.baselinker_field == "invoice_company"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_company")}</option>
                            <option value="invoice_address"   {if $ss_baselinker_fields_send.baselinker_field == "invoice_address"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_address")}</option>
                            <option value="invoice_city"      {if $ss_baselinker_fields_send.baselinker_field == "invoice_city"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_city")}</option>
                            <option value="invoice_postcode"  {if $ss_baselinker_fields_send.baselinker_field == "invoice_postcode"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_postcode")}</option>
                            <option value="invoice_country"   {if $ss_baselinker_fields_send.baselinker_field == "invoice_country"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_country")}</option>
                            <option value="invoice_nip"       {if $ss_baselinker_fields_send.baselinker_field == "invoice_nip"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_invoice_nip")}</option>
                            <option value="user_comments"     {if $ss_baselinker_fields_send.baselinker_field == "user_comments"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_user_comments")}</option>
                            <option value="phone"             {if $ss_baselinker_fields_send.baselinker_field == "phone"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_phone")}</option>
                            <option value="email"             {if $ss_baselinker_fields_send.baselinker_field == "email"}selected="selected"{/if}>{__("ss_baselinker_fields_send_baselinker_field_email")}</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="elm_ss_baselinker_order_extra_field">{__("ss_baselinker_order_extra_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_order_extra_field_tooltip)}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_fields_send[order_extra_field]" id="elm_ss_baselinker_order_extra_field" size="35" value="{$ss_baselinker_fields_send.order_extra_field}" class="input-medium" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label cm-required" for="elm_ss_baselinker_fields_send_content">{__("ss_baselinker_fields_send_content_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_fields_send_content_field_tooltip)}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_fields_send[content]" id="elm_ss_baselinker_fields_send_content" size="35" value="{$ss_baselinker_fields_send.content}" class="input-large" />
                    </div>
                </div>
                {include file="common/select_status.tpl" input_name="ss_baselinker_fields_send[status]" id="elm_ss_baselinker_fields_send_status" obj=$ss_baselinker_fields_send}
            </fieldset>
        </div>

        {assign var="ss_baselinker_fields_legend" value=1|fn_ss_baselinker_get_profile_fields_legend}
        <div id="resp-table">
            <div id="resp-table-caption">{__("ss_baselinker_fields_available_fields")}</div>
            <div id="resp-table-header">
                <div class="table-header-cell">{__("ss_bl_fields_code")}</div><div class="table-header-cell">{__("ss_bl_fields_id")}</div><div class="table-header-cell">{__("ss_bl_fields_name")}</div>
            </div>
            <div id="resp-table-body">
                {foreach from=$ss_baselinker_fields_legend item=legend_item}
                    <div class="resp-table-row">
                        <div class="table-body-cell">{$legend_item.field_name}</div>
                        <div class="table-body-cell">{$legend_item.field_id}</div>
                        <div class="table-body-cell">{$legend_item.description}</div>
                    </div>
                {/foreach}
            </div>
        </div>
        {capture name="buttons"}
            {include file="buttons/save_cancel.tpl" but_name="dispatch[ss_baselinker_fields_send.update]" but_role="submit-link" but_target_form="ss_baselinker_fields_send_form" save=$ss_baselinker_fields_send_id} 
        {/capture}
    </form>
{/capture}

{if $ss_baselinker_fields_send}
    {include file="common/mainbox.tpl" title="{__("ss_baselinker_fields_send_edit")}: `$ss_baselinker_fields_send.name`" content=$smarty.capture.mainbox select_languages=true buttons=$smarty.capture.buttons}
{else}
    {include file="common/mainbox.tpl" title=__("ss_baselinker_fields_send_new") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons}
{/if}