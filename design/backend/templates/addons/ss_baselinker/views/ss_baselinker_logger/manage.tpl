{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="{$addon_id}_logger_form" id="{$addon_id}_logger_form">
<input type="hidden" name="fake" value="1" />

{include file="common/pagination.tpl" save_current_page=true save_current_url=true}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="rev" value=$smarty.request.content_id|default:"pagination_contents"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}


{if $logger_data}
    <table width="100%" class="table table-middle">
    <thead>
    <tr>
        <th width="1%" class="left">{include file="common/check_items.tpl"}</th>
        <th width="10%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=id&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">ID{if $search.sort_by == id}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="15%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=date_add&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">DATE{if $search.sort_by == date_add}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="35%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">MESSAGE{if $search.sort_by == message}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="10%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=function&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">FUNCTION{if $search.sort_by == call_function}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="10%" style="text-align:center"><a class="cm-ajax" href="{"`$c_url`&sort_by=dispatch&sort_order=`$search.sort_order_rev`"|fn_url}"data-ca-target-id="pagination_contents">DISPATCH{if $search.sort_by == dispatch}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="8%" style="text-align:center">ACTION</th>
        {*<th width="8%" style="text-align:center">POST</th>*}
        <th width="8%" style="text-align:center">DATA</th>
        {*<th width="8%" style="text-align:center">RETURN</th>*}
    </tr>
    </thead>
    {foreach from=$logger_data item=logger_row}
        {assign var="url" value="`$addon_id`_logger.show?id=`$logger_row.id`"|fn_url}
        <tr class="cm-row-status-{$logger_row.status|lower}">
            <td class="left"><input type="checkbox" name="{$addon_id}_logger_ids[]" value="{$logger_row.id}" class="cm-item"/></td>
            <td class="row-status" style="text-align:center">{$logger_row.id}</td>
            <td class="row-status" style="text-align:center;width:250px">{$logger_row.date_add}</td>
            <td class="row-status" style="text-align:center">{if $logger_row.log_level == "ERROR"}<span style="color:red;font-weight:bold">{$logger_row.message nofilter}</span>{else}{$logger_row.message nofilter}{/if}</td>
            <td class="row-status" style="text-align:center"><span title="{$logger_row.call_function}">{$logger_row.call_function|truncate:25:"..."}</span></td>
            <td class="row-status" style="text-align:center"><span title="{$logger_row.dispatch}">{$logger_row.dispatch|truncate:25:"..."}</span></td>
            <td class="row-status" style="text-align:center">{if $logger_row.log_level == "ERROR"}<span style="color:red;font-weight:bold">{$logger_row.log_level}</span>{else}{$logger_row.log_level}{/if}</td>
            {*<td class="row-status" style="text-align:center">
                <a class="ty-btn ty-btn__secondary" onclick="window.open('{$url}&param=send_data','_blank',' scrollbars=yes, menubar=no, height=700, width=700, resizable=yes,toolbar=no,location=no,status=no')">show</a>
            </td>*}
            <td class="row-status" style="text-align:center">
                <a class="ty-btn ty-btn__secondary" onclick="window.open('{$url}&param=send_data','_blank',' scrollbars=yes, menubar=no, height=700, width=700, resizable=yes,toolbar=no,location=no,status=no')">{__("show")}</a>
            </td>
        </tr>
    {/foreach}
    </table>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl"}
</form>

{capture name="buttons"}
    {if $logger_data}
        {capture name="tools_list"}
            <li>{btn type="delete_selected" dispatch="dispatch[`$addon_id`_logger.m_delete]" form="`$addon_id`_logger_form"}</li>
        {/capture}
        {dropdown content=$smarty.capture.tools_list}
    {/if}
{/capture}
{/capture}

{capture name="sidebar"}
    {include file="addons/`$addon_id`/views/`$addon_id`_logger/components/search_form.tpl" dispatch="`$addon_id`_logger.manage" addon_id=$addon_id}
{/capture}

{include file="common/mainbox.tpl" title=__("ss_baselinker_logger_log_management") sidebar=$smarty.capture.sidebar  content=$smarty.capture.mainbox buttons=$smarty.capture.buttons}
