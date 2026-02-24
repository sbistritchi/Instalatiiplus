{include file="common/subheader.tpl" title=__("ss_baselinker_title_section") target="#ss_baselinker_settings_vendor_plans" meta="collapsed"}
<div id="ss_baselinker_settings_vendor_plans" class="collapse">
    <div class="control-group">
        <label class="control-label" for="elm_ss_baselinker_api_allow_{$id}">{__("ss_baselinker_api_allow")}:</label>
        <div class="controls">
            <input type="hidden" name="plan_data[ss_baselinker_api_allow]" value="N"/>
            <input type="checkbox" name="plan_data[ss_baselinker_api_allow]" id="elm_ss_baselinker_api_allow" value="Y" {if $plan.ss_baselinker_api_allow == "Y"}checked="checked"{/if} class="checkbox" />
        </div>
    </div>
</div>