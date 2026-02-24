{if $smarty.request.shipping_id|fn_ss_baselinker_check_enable_for_shipping}
    <div id="content_ss_baselinker" class="hidden">
        <div class="control-group">
            <label class="control-label" for="ss_baselinker_enable_map">{__("ss_baselinker_enable_map")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_enable_map_tooltip)}:</label>
            <div class="controls">
                <input type="hidden" name="shipping_data[service_params][ss_baselinker_enable_map]" value="N" />
                <input id="ss_baselinker_enable_map" type="checkbox" name="shipping_data[service_params][ss_baselinker_enable_map]" value="Y" {if $shipping.service_params.ss_baselinker_enable_map == "Y"}checked="checked"{/if} />
            </div>
        </div>
        <div class="control-group" id="ss_baselinker_service">
            <label class="control-label" for="ss_baselinker_service">{__("ss_baselinker_available_services")}:</label>
            <div class="controls">
                {* pobierz listę serwisów punktów dostawy dostępną przez furgonetka.pl *}
                {assign var="point_services" value=false|fn_ss_baselinker_list_point_services}
                {* przejdz pętlą i wyświetl je *}
                {foreach from=$point_services key=code item=group}
                    <input type="hidden" name="shipping_data[service_params][ss_baselinker_service][{$code}]" value="N" />
                    <input style="margin-top: 2px !important" type="checkbox" id="dhl" name="shipping_data[service_params][ss_baselinker_service][{$code}]"
                    {if isset($shipping.service_params.ss_baselinker_service.$code) && $shipping.service_params.ss_baselinker_service.$code == "Y"}checked="checked"{/if} value="Y"/>
                    &nbsp;&nbsp;&nbsp;{__("ss_bl_point_service_`$code`")}<br>
                {/foreach}
            </div>
        </div>
        <div class="control-group" id="ss_baselinker_point_type">
            <label class="control-label" for="ss_baselinker_point_type">{__("ss_baselinker_point_type")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_point_type_tooltip)}:</label>
            <div class="controls">
                <select name="shipping_data[service_params][ss_baselinker_point_type]" id="ss_baselinker_point_type">
                    <option value="ALL" {if $shipping.service_params.ss_baselinker_point_type == "ALL"}selected="selected"{/if}>{__("ss_baselinker_point_type_all")}</option>
                    <option value="ONLY_COD" {if $shipping.service_params.ss_baselinker_point_type == "ONLY_COD"}selected="selected"{/if}>{__("ss_baselinker_point_type_cod")}</option>
                </select>
            </div>
        </div>
    </div>
{/if}