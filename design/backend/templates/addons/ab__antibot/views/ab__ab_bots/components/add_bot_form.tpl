<form action="{""|fn_url}" method="post" class="form-horizontal form-edit" name="add_bot_form">
<input type="hidden" name="return_url" value="{$config.current_url}"/>
{$f="pattern"}
{$f_id="add_bot_{$f}"}
<div class="control-group">
<label class="control-label cm-required cm-trim" for="{$f_id}">{__("ab__ab.bot.{$f}")}</label>
<div class="controls">
<input class="span9" type="text" id="{$f_id}" name="bot_data[0][{$f}]" value=""/>
</div>
</div>
{$f="group_name"}
{$f_id="add_bot_{$f}"}
<div class="control-group">
<label class="control-label" for="{$f_id}">{__("ab__ab.bot.{$f}")}</label>
<div class="controls">
<input class="span9" type="text" id="{$f_id}" name="" value="Users" disabled="disabled"/>
</div>
</div>
{$f="type"}
{$f_id="add_bot_{$f}"}
<div class="control-group">
<label class="control-label cm-required" for="{$f_id}">{__("ab__ab.bot.{$f}")}</label>
<div class="controls">
<select name="bot_data[0][{$f}]" id="{$f_id}">
{foreach $bot_types as $type}
<option value="{$type}"{if !empty($smarty.request.type) && in_array($type, $smarty.request.type)} selected="selected"{/if}>{__("ab__ab.bot.type.variants.{$type|lower}")}</option>
{/foreach}
</select>
</div>
</div>
{$f="status"}
{$f_id="add_bot_{$f}"}
{include file="common/select_status.tpl" input_name="bot_data[0][{$f}]" id="{$f_id}"}
<div class="buttons-container">
{include file="buttons/save_cancel.tpl" but_name="dispatch[ab__ab_bots.update]" cancel_action="close" text=__("ab__ab.bot.add")}
</div>
</form>
