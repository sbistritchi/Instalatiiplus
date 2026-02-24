{if $placeholders.extra_fields}
    <div class="sidebar-row">
        {include file="addons/ss_baselinker/components/subheader.tpl" title=__("ss_baselinker_ph_params") tooltip=__("ss_baselinker_ph_params_tooltip")}
        <div id="ss_baselinker_extra_fields_placeholders" class="in collapse">
            {foreach from=$placeholders.extra_fields item="ph" key="ph_key"}
                <div class="control-group">
                    <code>[{$ph_key}]</code><br>
                    <span>{__("`$ph`")}{include file="common/tooltip.tpl" tooltip=__("`$ph`_tooltip")}</span>
                </div>
            {/foreach}
        </div>
    </div>
{/if}