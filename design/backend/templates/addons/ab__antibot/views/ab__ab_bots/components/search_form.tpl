{capture name="section"}
<div class="sidebar-row">
<h6>{__("search")}</h6>
<form action="{""|fn_url}" name="ab__ab_bots_form" method="get">
{capture name="simple_search"}
<div class="sidebar-field">
<label for="sender">{__("ab__ab.bot.pattern")}:</label>
<input type="text" name="pattern" id="pattern" value="{$search.pattern}" size="20">
</div>
<div class="sidebar-field">
<label for="group_name">{__("ab__ab.bot.group_name")}:</label>
<select name="group_name" id="group_name">
<option value="">---</option>
{foreach $bot_groups as $group_name}
<option value="{$group_name}"{if $group_name == $search.group_name} selected="selected"{/if}>{$group_name}</option>
{/foreach}
</select>
</div>
<div class="sidebar-field">
<label for="type">{__("ab__ab.bot.type")}:</label>
<select name="type[]" id="type">
<option value="">---</option>
{foreach $bot_types as $type}
<option value="{$type}"{if $type == $search.type[0]} selected="selected"{/if}>{__("ab__ab.bot.type.variants.{$type|lower}")}</option>
{/foreach}
</select>
</div>
<div class="sidebar-field">
<label for="status">{__("ab__ab.bot.status")}:</label>
<select name="status" id="status">
<option value="">---</option>
<option value="A"{if 'A' == $search.status} selected="selected"{/if}>{__("active")}</option>
<option value="D"{if 'D' == $search.status} selected="selected"{/if}>{__("disabled")}</option>
</select>
</div>
{/capture}
{include file="common/advanced_search.tpl" simple_search=$smarty.capture.simple_search dispatch="ab__ab_bots.manage" view_type="events"}
</form>
</div>
{/capture}
{include file="common/section.tpl" section_content=$smarty.capture.section}