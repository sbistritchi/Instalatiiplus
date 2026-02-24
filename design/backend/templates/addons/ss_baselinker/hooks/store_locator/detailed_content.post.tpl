{*                                              *}
{assign var="storefronts_list" value=1|fn_ss_baselinker_get_storefronts_list}
<div class="control-group">
    <label class="control-label" for="elm_ss_baselinker_calculate">{__("ss_baselinker_calculate")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_calculate_tooltip)}:</label>
    <div class="controls">
        <select name="store_location_data[ss_baselinker_calculate][]" id="ss_baselinker_calculate" multiple>
           {foreach from=$storefronts_list key="storefront_id" item="storefront_name"}
               <option value="{$storefront_id}" {if $storefront_id|in_array:$store_location.ss_baselinker_calculate}selected="selected"{/if}>{$storefront_name}</option>
           {/foreach}
        </select>
    </div>
</div>
{* opcja określająca do którego magazynu mają być ładowane produkty jeśli magazyn w Baselinker jest magazynem nadrzędnym *}
<div class="control-group">
    <label class="control-label" for="elm_ss_baselinker_warehouse">{__("ss_baselinker_warehouse")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_warehouse_tooltip)}:</label>
    <div class="controls">
        <input type="hidden" name="store_location_data[ss_baselinker_warehouse]" value="N" />
        <input id="ss_baselinker_calculate" type="checkbox" name="store_location_data[ss_baselinker_warehouse]" value="Y" {if $store_location.ss_baselinker_warehouse eq 'Y'} checked="checked"{/if}/>
    </div>
</div>
