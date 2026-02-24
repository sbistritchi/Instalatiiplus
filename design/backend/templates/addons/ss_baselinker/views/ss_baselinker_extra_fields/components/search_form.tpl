{if $in_popup}
    <div class="adv-search">
    <div class="group">
{else}
    <div class="sidebar-row">
    <h6>{__("search")}</h6>
{/if}
<form name="ss_baselinker_extra_fields_search_form" action="{""|fn_url}" method="get" class="{$form_meta}">
{capture name="simple_search"}
{if $smarty.request.redirect_url}
<input type="hidden" name="redirect_url" value="{$smarty.request.redirect_url}" />
{/if}

{if $selected_section != ""}
<input type="hidden" id="selected_section" name="selected_section" value="{$selected_section}" />
{/if}

{if $put_request_vars}
    {array_to_fields data=$smarty.request skip=["callback"] escape=["data_id"]}
{/if}

{$extra nofilter}

<div class="sidebar-field">
<label for="elm_name">{__("ss_baselinker_extra_fields_name_field")}</label>
<div class="break">
<input type="text" name="ss_baselinker_extra_fields_name" id="elm_ss_baselinker_extra_fields_name" />
</div>
</div>
<div class="sidebar-field">
<label for="elm_name">{__("ss_baselinker_extra_fields_bl_field_field")}</label>
<div class="break">
<input type="text" name="ss_baselinker_extra_fields_bl_field" id="elm_ss_baselinker_extra_fields_bl_field" />
</div>
</div>
<div class="sidebar-field">
<label for="elm_name">{__("ss_baselinker_extra_fields_custom_field")}</label>
<div class="break">
<input type="text" name="ss_baselinker_extra_fields_custom" id="elm_ss_baselinker_extra_fields_custom" />
</div>
</div>


{/capture}

{include file="common/advanced_search.tpl" simple_search=$smarty.capture.simple_search advanced_search=false dispatch=$dispatch view_type="expenses_table" in_popup=$in_popup method="GET" no_adv_link=true}

</form>

{if $in_popup}
</div></div>
{else}
</div><hr>
{/if}