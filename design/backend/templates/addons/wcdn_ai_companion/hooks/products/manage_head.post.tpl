<th>AI</th>

<div class="hidden form-horizontal form-edit"  id="content_ai_companion_generate_content">
	

	<div class="control-group" style="padding-top: 20px;padding-bottom: 30px;">
		<label for="ai_companion_template" class="control-label">{__("ai_companion_template")}</label>
		<div class="controls">
			<select name="ai_companion_template_id" id="ai_companion_template">
			{foreach item="template" from=$ai_companion_templates}
				<option value="{$template.template_id}">{$template.template_name}</option>
			{/foreach}
			</select>
		</div>
	</div>

	<div class="buttons-container buttons-container-picker">
		<a class="cm-dialog-closer cm-cancel tool-link btn">{__('cancel')}</a>
		<input class="btn btn-primary " type="submit" name="dispatch[ai_companion.generate]" value="{__('generate')}">
	</div>
</div>