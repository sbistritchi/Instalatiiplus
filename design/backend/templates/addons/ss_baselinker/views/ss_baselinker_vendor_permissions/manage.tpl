{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="ss_baselinker_vendor_permissions_form" id="ss_baselinker_vendor_permissions_form">
<input type="hidden" name="fake" value="1" />

{include file="common/pagination.tpl" save_current_page=true save_current_url=true}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="rev" value=$smarty.request.content_id|default:"pagination_contents"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}


{if $ss_baselinker_vendor_permissions}
    <table width="100%" class="table table-middle">
    <thead>
    <tr>
        <th width="1%" class="left">{include file="common/check_items.tpl"}</th>
        <th width="10%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=id&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">{__("ss_baselinker_vendor_permissions_id_field")}{if $search.sort_by == id}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="30%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">{__("ss_baselinker_vendor_permissions_name_field")}{if $search.sort_by == name}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="20%" style="text-align:center">{__("ss_baselinker_vendor_permissions_field_name_field")}</th>
        <th>&nbsp;</th>
<th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    </tr>
    </thead>
    {foreach from=$ss_baselinker_vendor_permissions item=ss_baselinker_vendor_permissions_row}
    <tr class="cm-row-status-{$ss_baselinker_vendor_permissions_row.status|lower}">
        <td class="left"><input type="checkbox" name="ss_baselinker_vendor_permissions_ids[]" value="{$ss_baselinker_vendor_permissions_row.ss_baselinker_vendor_permissions_id}" class="cm-item"/></td>
        <td class="row-status" style="text-align:center"><a href="{"ss_baselinker_vendor_permissions.update?ss_baselinker_vendor_permissions_id=`$ss_baselinker_vendor_permissions_row.ss_baselinker_vendor_permissions_id`"|fn_url}">{$ss_baselinker_vendor_permissions_row.ss_baselinker_vendor_permissions_id}</a></td>
        <td class="row-status" style="text-align:center"><a href="{"ss_baselinker_vendor_permissions.update?ss_baselinker_vendor_permissions_id=`$ss_baselinker_vendor_permissions_row.ss_baselinker_vendor_permissions_id`"|fn_url}">{$ss_baselinker_vendor_permissions_row.name}</a></td>
        <td class="row-status" style="text-align:center">{$ss_baselinker_vendor_permissions_row.field_name}</td>
        <td class="center nowrap">
            {capture name="tools_list"}
                <li>{btn type="list" text=__("edit") href="ss_baselinker_vendor_permissions.update?ss_baselinker_vendor_permissions_id=`$ss_baselinker_vendor_permissions_row.ss_baselinker_vendor_permissions_id`"}</li>
                <li>{btn type="list" class="cm-confirm" text=__("delete") href="ss_baselinker_vendor_permissions.delete?ss_baselinker_vendor_permissions_id=`$ss_baselinker_vendor_permissions_row.ss_baselinker_vendor_permissions_id`"}</li>
            {/capture}
            <div class="hidden-tools right">
                {dropdown content=$smarty.capture.tools_list}
            </div>
        </td>
<td class="right nowrap">
{include file="common/select_popup.tpl" popup_additional_class="dropleft" id=$ss_baselinker_vendor_permissions_row.ss_baselinker_vendor_permissions_id status=$ss_baselinker_vendor_permissions_row.status hidden=false object_id_name="ss_baselinker_vendor_permissions_id" table="ss_baselinker_vendor_permissions"}</td>

    </tr>
    {/foreach}
    </table>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl"}
</form>

{capture name="buttons"}
    {if $ss_baselinker_vendor_permissions}
        {capture name="tools_list"}
            <li>{btn type="delete_selected" dispatch="dispatch[ss_baselinker_vendor_permissions.m_delete]" form="ss_baselinker_vendor_permissions_form"}</li>
        {/capture}
        {dropdown content=$smarty.capture.tools_list}
    {/if}
{/capture}

{/capture}
{capture name="adv_buttons"}
{include file="common/tools.tpl" tool_href="ss_baselinker_vendor_permissions.add" prefix="top" hide_tools=true title={__("ss_baselinker_vendor_permissions_add")} icon="icon-plus"}
{/capture}

{capture name="sidebar"}

{/capture}


{include file="common/mainbox.tpl" title={__("ss_baselinker_vendor_permissions_manage")} sidebar=$smarty.capture.sidebar  content=$smarty.capture.mainbox tools=$smarty.capture.tools select_languages=true buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons}
