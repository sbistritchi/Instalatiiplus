<form action="{""|fn_url}" method="post" name="ab__preload_link_form" class="form-horizontal form-edit">
<div class="control-group">
<label class="control-label cm-required" for="ab__p_url">{__("ab__preload_links.form.url")}:</label>
<div class="controls">
<input type="text" name="link_data[url]" id="ab__p_url" value="" class="span9" />
</div>
</div>
<div class="control-group">
<label class="control-label" for="ab__p_format">{__("ab__preload_links.form.format")}:</label>
<div class="controls">
<select name="link_data[format]" id="ab__p_format">
<option value="">{__('ab__preload_links.undefined')}</option>
{foreach $ab__preload_formats as $format => $format_data}
<option value="{$format}">{$format_data.label}</option>
{/foreach}
</select>
</div>
</div>
<div class="control-group">
<label class="control-label" for="ab__p_use_timestamp">{__("ab__preload_links.form.use_timestamp")}:</label>
<div class="controls">
<input type="hidden" name="link_data[use_timestamp]" value="N" />
<input type="checkbox" name="link_data[use_timestamp]" id="ab__p_use_timestamp" value="Y" />
</div>
</div>
{include file="common/select_status.tpl" input_name="link_data[status]" id="ab__p_status" hidden=false}
<div class="buttons-container">
{include file="buttons/save_cancel.tpl" but_name="dispatch[ab__preload_links.update]" cancel_action="close"}
</div>
</form>