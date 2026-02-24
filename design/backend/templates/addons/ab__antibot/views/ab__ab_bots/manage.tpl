{capture name="mainbox"}
{$return_url=$config.current_url}
<form action="{""|fn_url}" method="post" name="ab__ab_bots_form" class="{if ""|fn_check_form_permissions} cm-hide-inputs{/if}">
<input type="hidden" name="return_url" value="{$return_url}"/>
{include file="common/pagination.tpl" save_current_url=true}
{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}
{if $bots}
<div class="table-responsive-wrapper">
<table class="table table-middle table--relative table-responsive sortable">
<thead>
<tr>
<th class="center" width="1%">{include file="common/check_items.tpl"}</th>
<th width="45%"><a class="cm-history cm-ajax{if $search.sort_by == "pattern"} sort-link-{$search.sort_order_rev}{/if}" href="{"`$c_url`&sort_by=pattern&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("ab__ab.bot.pattern")}{if $search.sort_by == "pattern"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
<th width="5%"><a class="cm-history cm-ajax{if $search.sort_by == "group_name"} sort-link-{$search.sort_order_rev}{/if}" href="{"`$c_url`&sort_by=group_name&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("ab__ab.bot.group_name")}{if $search.sort_by == "group_name"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
<th width="5%"><a class="cm-history cm-ajax{if $search.sort_by == "type"} sort-link-{$search.sort_order_rev}{/if}" href="{"`$c_url`&sort_by=type&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("ab__ab.bot.type")}{if $search.sort_by == "type"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
<th width="5%">&nbsp;</th>
<th width="5%" class="right nowrap"><a class="cm-history cm-ajax{if $search.sort_by == "status"} sort-link-{$search.sort_order_rev}{/if}" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("ab__ab.bot.status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
</tr>
</thead>
<tbody>
{foreach $bots as $bot}
<tr class="cm-row-status-{$bot.status|lower}">
<td class="left mobile-hide" width="1%">
<input type="checkbox" name="bot_id[]" value="{$bot.bot_id}" class="cm-item" />
</td>
<td data-th="{__("ab__ab.bot.pattern")}">
<input type="text" name="bot_data[{$bot.bot_id}][pattern]" value="{$bot.pattern}" class="input-hidden span6" />
</td>
<td data-th="{__("ab__ab.bot.group_name")}" nowrap>
{$bot.group_name}
</td>
<td data-th="{__("ab__ab.bot.type")}" nowrap>
{if ""|fn_check_form_permissions}
<span class="view-status">{__("ab__ab.bot.type.variants.{$bot.type|lower}")}</span>
{else}
{include file="common/select_popup.tpl"
id=$bot.bot_id
status=$bot.type
dynamic_object="&is_type=Y"
items_status=['B' => __("ab__ab.bot.type.variants.b"), 'W' => __("ab__ab.bot.type.variants.w")]
update_controller="ab__ab_bots"
popup_additional_class="dropleft"
}
{/if}
</td>
<td data-th="&nbsp;" class="nowrap">
<div class="hidden-tools">
{capture name="tools_list"}
<li>{btn type="list" class="cm-confirm cm-post" text=__("delete") href="ab__ab_bots.delete?bot_id=`$bot.bot_id`&return_url={$return_url|urlencode}" method="POST"}</li>
{/capture}
{dropdown content=$smarty.capture.tools_list}
</div>
</td>
<td data-th="{__("ab__ab.bot.status")}" class="right nowrap">
{include file="common/select_popup.tpl"
id=$bot.bot_id
status=$bot.status
object_id_name="bot_id"
table="ab__ab_bots"
popup_additional_class="dropleft"
non_editable=""|fn_check_form_permissions
}
</td>
</tr>
{/foreach}
</tbody>
</table>
</div>
{else}
<p class="no-items">{__("no_data")}</p>
{/if}
{include file="common/pagination.tpl"}
{capture name="sidebar"}
{include file="common/saved_search.tpl" dispatch="ab__ab_bots.manage" view_type="ab__ab_bots"}
{include file="addons/ab__antibot/views/ab__ab_bots/components/search_form.tpl"}
{/capture}
</form>
{capture name="buttons"}
{if $bots}
<span class="mobile-hide shift-right">
{capture name="tools_list"}
<li>{btn type="delete_selected" dispatch="dispatch[ab__ab_bots.m_delete]" form="ab__ab_bots_form"}</li>
{/capture}
{dropdown content=$smarty.capture.tools_list}
</span>
{include file="buttons/save.tpl" but_name="dispatch[ab__ab_bots.m_update]" but_role="action" but_target_form="ab__ab_bots_form" but_meta="cm-post cm-submit"}
{/if}
{/capture}
{capture name="adv_buttons"}
{capture name="add_new_bot"}
{include file="addons/ab__antibot/views/ab__ab_bots/components/add_bot_form.tpl"}
{/capture}
{include file="common/popupbox.tpl" id="add_new_bot" text=__("ab__ab.bot.add") title=__("ab__ab.bot.add") act="general" content=$smarty.capture.add_new_bot icon="icon-plus"}
{/capture}
{/capture}
{include file="addons/ab__addons_manager/views/ab__am/components/menu.tpl" addon="ab__antibot"}
{include file="common/mainbox.tpl"
title_start=__("ab__antibot")|truncate:40
title_end=__("ab__ab.bots")
content=$smarty.capture.mainbox
tools=$smarty.capture.tools
sidebar=$smarty.capture.sidebar
adv_buttons=$smarty.capture.adv_buttons
buttons=$smarty.capture.buttons}
