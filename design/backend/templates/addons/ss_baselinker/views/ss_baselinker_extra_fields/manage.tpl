{script src="js/tygh/tabs.js"}

{capture name="mainbox"}
    {include file="common/pagination.tpl"}
    {assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
    {assign var="rev" value=$smarty.request.content_id|default:"pagination_contents"}
    {assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
    {assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

<form action="{""|fn_url}" method="post" name="ss_baselinker_extra_fields_form" id="ss_baselinker_extra_fields_form">
<input type="hidden" name="return_url" value="{$config.current_url}">
<div class="items-container{if ""|fn_check_form_permissions} cm-hide-inputs{/if}" id="ss_baselinker_extra_fields_list">
{if $ss_baselinker_extra_fields}
    <div class="table-responsive-wrapper">
    <table width="100%" class="table table-middle table-objects table-responsive">
    <thead>
    <tr>
        <th width="1%" class="left mobile-hide">{include file="common/check_items.tpl"}</th>
        <th width="5%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=id&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">{__("ss_baselinker_extra_fields_id_field")}{if $search.sort_by == id}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="5%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=position&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">{__("ss_baselinker_extra_fields_position_field")}{if $search.sort_by == position}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="30%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">{__("ss_baselinker_extra_fields_name_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_extra_fields_name_tooltip)}{if $search.sort_by == name}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="30%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=bl_field&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">{__("ss_baselinker_extra_fields_bl_field_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_extra_fields_bl_field_tooltip)}{if $search.sort_by == bl_field}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="30%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=custom&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">{__("ss_baselinker_extra_fields_custom_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_extra_fields_custom_tooltip)}{if $search.sort_by == custom}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th class="mobile-hide">&nbsp;</th>
        <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$ss_baselinker_extra_fields item=ss_baselinker_extra_fields_row}
    <tr class="cm-row-status-{$ss_baselinker_extra_fields_row.status|lower}">
        <td class="left mobile-hide"><input type="checkbox" name="ss_baselinker_extra_fields_ids[]" value="{$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id}" class="cm-item"/></td>
        <td class="row-status" style="text-align:center" data-th="{__("ss_baselinker_extra_fields_id_field")}"><a class="cm-ajax cm-dialog-opener" data-ca-target-id="content_group_{$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id}" title="{__("edit")}" href="{"ss_baselinker_extra_fields.update?ss_baselinker_extra_fields_id=`$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id`"|fn_url}">#{$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id}</a></td>
        <td class="row-status" style="text-align:center" data-th="{__("ss_baselinker_extra_fields_position_field")}"><input type="text" name="ss_baselinker_extra_fields[{$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id}][position]" value="{$ss_baselinker_extra_fields_row.position}" class="input-micro" /></td>
        <td class="row-status" style="text-align:center" data-th="{__("ss_baselinker_extra_fields_name_field")}"><a class="cm-ajax cm-dialog-opener" data-ca-target-id="content_group_{$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id}" title="{__("edit")}" href="{"ss_baselinker_extra_fields.update?ss_baselinker_extra_fields_id=`$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id`"|fn_url}">{$ss_baselinker_extra_fields_row.name}</a></td>
        <td class="row-status" style="text-align:center" data-th="{__("ss_baselinker_extra_fields_bl_field_field")}">{$ss_baselinker_extra_fields_row.bl_field}</td>
        <td class="row-status" style="text-align:center" data-th="{__("ss_baselinker_extra_fields_custom_field")}">{$ss_baselinker_extra_fields_row.custom}</td>
        <td class="center nowrap mobile-hide">
            {capture name="tools_list"}
                <li>{include file="common/popupbox.tpl" id="content_group_`$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id`" title_start=__("edit") title_end="`$ss_baselinker_extra_fields_row.name`" act="edit" href="ss_baselinker_extra_fields.update?ss_baselinker_extra_fields_id=`$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id`" no_icon_link=true}  </li>
                <li>{btn type="list" class="cm-confirm" text=__("delete") href="ss_baselinker_extra_fields.delete?ss_baselinker_extra_fields_id=`$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id`"}</li>
                <li>{btn type="list" class="cm-confirm" text=__("clone") href="ss_baselinker_extra_fields.clone?ss_baselinker_extra_fields_id=`$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id`"}</li>
            {/capture}
            <div class="hidden-tools right">
                {dropdown content=$smarty.capture.tools_list}
            </div>
        </td>
        <td class="right nowrap" data-th="{__("status")}">
            {include file="common/select_popup.tpl" popup_additional_class="dropleft" id=$ss_baselinker_extra_fields_row.ss_baselinker_extra_fields_id status=$ss_baselinker_extra_fields_row.status hidden=false object_id_name="ss_baselinker_extra_fields_id" table="ss_baselinker_extra_fields"}
        </td>

    </tr>
    {/foreach}
    </tbody>
    </table>
    </div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

<!--update_customs_list--></div>
</form>

{include file="common/pagination.tpl"}
{capture name="buttons"}
    {if $ss_baselinker_extra_fields}
        {capture name="tools_list"}
            <li>{btn type="delete_selected" dispatch="dispatch[ss_baselinker_extra_fields.m_delete]" form="ss_baselinker_extra_fields_form"}</li>
            
        {/capture}
        {dropdown content=$smarty.capture.tools_list}
        {include file="buttons/save_cancel.tpl" but_role="submit-link" but_name="dispatch[ss_baselinker_extra_fields.m_update]" but_target_form="ss_baselinker_extra_fields_form" save=true}
    {/if}
{/capture}

{capture name="adv_buttons"}
    {capture name="add_picker_ss_baselinker_extra_fields"}
        {include file="addons/ss_baselinker/views/ss_baselinker_extra_fields/update.tpl" in_popup=true return_url=$config.current_url}
    {/capture}
    {include file="common/popupbox.tpl" id="add_new_ss_baselinker_extra_fields" text=__("ss_baselinker_extra_fields_add") title=__("ss_baselinker_extra_fields_add") content=$smarty.capture.add_picker_ss_baselinker_extra_fields act="general" icon="icon-plus"}
{/capture}

{capture name="sidebar"}
    {include file="addons/ss_baselinker/components/submenu.tpl"}
    {include file="addons/ss_baselinker/views/ss_baselinker_extra_fields/components/placeholders.tpl"}
    {include file="addons/ss_baselinker/views/ss_baselinker_extra_fields/components/search_form.tpl" dispatch="ss_baselinker_extra_fields.manage"}
    {*{include file="addons/ss_baselinker/components/reviews.tpl" addon=ss_baselinker prefix=$lp}*}
{/capture}

{/capture}

{include file="common/mainbox.tpl"
    title={__("ss_baselinker_extra_fields_manage")}
    sidebar=$smarty.capture.sidebar
    content=$smarty.capture.mainbox
    tools=$smarty.capture.tools
    select_languages=true
    buttons=$smarty.capture.buttons
    adv_buttons=$smarty.capture.adv_buttons
}
