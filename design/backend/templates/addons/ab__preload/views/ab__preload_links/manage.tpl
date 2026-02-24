{capture name="mainbox"}
{include file="common/subheader.tpl" title=__("ab__preload_links.note")}
<form action="{""|fn_url}" method="post" name="ab__preload_links_form" class="form-horizontal form-edit {if ""|fn_check_form_permissions} cm-hide-inputs{/if}">
{if $ab__preload_links}
<div class="table-responsive-wrapper">
<table width="100%" class="table table-middle table--relative table-responsive">
<thead>
<tr>
<th width="1%" class="mobile-hide">{include file="common/check_items.tpl"}</th>
<th width="69%">{__("ab__preload_links.form.url")}</th>
<th width="5%">{__("ab__preload_links.form.format")}</th>
<th width="5%">{__("ab__preload_links.form.use_timestamp")}</th>
<th width="10%">&nbsp;</th>
<th width="10%">{__("ab__preload_links.form.status")}</th>
</tr>
</thead>
{foreach $ab__preload_links as $link}
<tr class="cm-row-status-{$link.status|lower}">
<td class="mobile-hide">
<input type="checkbox" name="links_ids[]" value="{$link.link_id}" class="cm-item" />
</td>
<td data-th="{__("ab__preload_links.form.url")}">
<input type="text" class="input-hidden input-large" name="links_data[{$link.link_id}][url]" value="{$link.url}" />
</td>
<td data-th="{__("ab__preload_links.form.format")}">
<select name="links_data[{$link.link_id}][format]">
<option value="" {if !$link.format} selected{/if}>{__('ab__preload_links.undefined')}</option>
{foreach $ab__preload_formats as $format => $format_data}
<option value="{$format}"{if $format == $link.format} selected{/if}>{$format_data.label}</option>
{/foreach}
</select>
</td>
<td data-th="{__("ab__preload_links.form.use_timestamp")}">
<input type="hidden" name="links_data[{$link.link_id}][use_timestamp]" value="N" />
<input type="checkbox" name="links_data[{$link.link_id}][use_timestamp]" value="Y" {if $link.use_timestamp == "Y"}checked="checked"{/if} />
</td>
<td class="nowrap">
<div class="hidden-tools">
{capture name="tools_list"}
<li>{btn type="list" text=__("delete") class="cm-confirm" href="ab__preload_links.delete?link_id=`$link.link_id`" method="POST"}</li>
{/capture}
{dropdown content=$smarty.capture.tools_list}
</div>
</td>
<td class="nowrap right" data-th="{__("ab__preload_links.form.status")}">
{include file="common/select_popup.tpl" id=$link.link_id status=$link.status hidden=false object_id_name="link_id" table="ab__preload_links" popup_additional_class="dropleft"}
</td>
</tr>
{/foreach}
</table>
</div>
{else}
<p class="no-items">{__("no_data")}</p>
{/if}
</form>
{/capture}
{capture name="adv_buttons"}
{if "ab__preload_links.update"|fn_check_view_permissions:"POST"}
{capture name="ab__preload_add_new_link"}
{include file="addons/ab__preload/views/ab__preload_links/components/link_form.tpl"}
{/capture}
{include file="common/popupbox.tpl" id="ab__preload_add_new_link" text=__("ab__preload_add_new_link") title=__("ab__preload_add_new_link") content=$smarty.capture.ab__preload_add_new_link act="general" icon="icon-plus"}
{/if}
{/capture}
{capture name="buttons"}
<span class="mobile-hide shift-right">
{capture name="tools_list"}
{if $ab__preload_links}
<li>{btn type="delete_selected" dispatch="dispatch[ab__preload_links.m_delete]" form="ab__preload_links_form"}</li>
{/if}
{/capture}
{dropdown content=$smarty.capture.tools_list}
</span>
{if $ab__preload_links}
{include file="buttons/save.tpl" but_name="dispatch[ab__preload_links.m_update]" but_role="action" but_target_form="ab__preload_links_form" but_meta="cm-submit"}
{/if}
{/capture}
{capture name="sidebar"}{/capture}
{include file="addons/ab__addons_manager/views/ab__am/components/menu.tpl" addon="ab__preload"}
{include
file="common/mainbox.tpl"
title_start = __("ab__preload")|truncate:40
title_end = __("ab__preload_links.manage")
content = $smarty.capture.mainbox
adv_buttons = $smarty.capture.adv_buttons
buttons = $smarty.capture.buttons
}
