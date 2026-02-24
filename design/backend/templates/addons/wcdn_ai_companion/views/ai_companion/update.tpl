{capture name="mainbox"}

	{* set defaults *}
	{$template.model = $template.model|default:'gpt-3.5-turbo'}

	<form name="update_companion_template" id="update_companion_template" method="POST" action="{""|fn_url}" class="form-horizontal form-edit">
		
		<input type="hidden" name="template_id" value="{$template.template_id}">
		
		<div class="control-group">
            <label for="template_name" class="control-label cm-required">{__("ai_companion_template_name_desc")}</label>
            <div class="controls">
            	<input class="input-large" type="text" name="template[template_name]" id="template_name" size="55" value="{$template.template_name}" />
            </div>
        </div>
		
		<div class="control-group">
            <label for="companion_model" class="control-label cm-required">{__("ai_companion_model")}</label>
            <div class="controls">
            	<select name="template[companion_model]" id="companion_model" value="{$template.companion_model}" />
            	{foreach item="model" from=$models key="key"}
            		<option value="{$key}" {if $template.companion_model eq $key} selected {/if}>{$model}</option>
            	{/foreach}
            	</select>
            </div>
        </div>
        
        <div class="control-group">
            <label for="max_tokens" class="control-label cm-required">Max Tokens</label>
            <div class="controls">
            	<input class="input-large" type="text" name="template[max_tokens]" id="max_tokens" size="55" value="{$template.max_tokens|default:0}" />
            	<small class="help-block help-inline">0 = Nelimitat</small>
            </div>
        </div>
        
        <div class="control-group">
            <label for="temperature" class="control-label cm-required">Temperature</label>
            <div class="controls">
            	<input class="input-large" type="text" name="template[temperature]" id="temperature" size="55" value="{$template.temperature|default:0}" />
            	<small class="help-block help-inline">0 = Nu folosi</small>
            </div>
        </div>
        
        <div class="control-group">
            <label for="top_p" class="control-label cm-required">TopP (Nucleus Sampling)</label>
            <div class="controls">
            	<input class="input-large" type="text" name="template[top_p]" id="top_p" size="55" value="{$template.top_p|default:0.0}" />
            	<small class="help-block help-inline">0 = Nu folosi</small>
            </div>
        </div>
        
        <div class="control-group">
            <label for="assistant_id" class="control-label">ID Asistent</label>
            <div class="controls">
            	<input class="input-large" type="text" name="template[assistant_id]" id="assistant_id" size="55" value="{$template.assistant_id|default:''}" />
            </div>
        </div>
        
        <div class="control-group">
            <label for="prompt" class="control-label cm-required">{__("ai_companion_prompt")}</label>
            <div class="controls">
            	<textarea class="input-large" type="text" name="template[prompt]" rows="5" id="prompt">{$template.prompt}</textarea>
            	<small class="help-block help-inline">{__('ai_companion_prompt_description')}</small>
            </div>
        </div>
        
        <div class="control-group">
			<label class="control-label">{__('ai_companion_included_fields')}</label>
			<div class="controls">
				{foreach item="field" from=$fields_to_include key="field_name"}
				<label class="checkbox" for="include_{$field_name}">
					<input type="hidden" name="template[fields_to_include][{$field_name}]" value="N">
					<input type="checkbox" name="template[fields_to_include][{$field_name}]" id="include_{$field_name}" value="Y" {if $template.fields_to_include[$field_name] eq "Y"} checked {/if}>
					{$field}
				</label>
				{/foreach}
			</div>
		</div>
		
        <div class="control-group">
			<label class="control-label">{__('ai_companion_generated_fields')}</label>
			<div class="controls">
				{foreach item="field" from=$fields_to_generate key="field_name"}
				<label class="checkbox" for="generate_{$field_name}">
					<input type="hidden" name="template[fields_to_generate][{$field_name}]" value="N">
					<input type="checkbox" name="template[fields_to_generate][{$field_name}]" id="generate_{$field_name}" value="Y" {if $template.fields_to_generate[$field_name] eq "Y"} checked {/if}>
					{$field}
				</label>
				{/foreach}
			</div>
		</div>
		
	</form>
{/capture}

{capture name="buttons"}
	{include file="buttons/save.tpl" but_role="submit-link" but_name="dispatch[ai_companion.update]" hide_first_button=true but_target_form="update_companion_template" save=$template.template_id}
{/capture}

{capture name="mainbox_title"}
	{if $template.template_id}
		{$template.template_name}
	{else}
		{__('ai_companion_new_template')}
	{/if}
{/capture}

{include file="common/mainbox.tpl" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons title=$smarty.capture.mainbox_title}