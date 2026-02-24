{capture name="mainbox"}

	{if $templates}
		<table class="table table-responsive table-hover table-middle">
			<thead>
				<tr>
					<th>{__('ai_companion_template_name')}</th>
					<th>{__('ai_companion_model')}</th>
					<th>{__('ai_companion_prompt')}</th>
					<th>{__('ai_companion_included_fields')}</th>
					<th>{__('ai_companion_generated_fields')}</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				{foreach item="template" from=$templates}
					
					<tr>
						<td><a href="{"ai_companion.update&template_id=`$template.template_id`"|fn_url}">{$template.template_name}</a></td>
						<td>{$models[$template.companion_model]}</td>
						<td width="30%"><small class="help-inline help-block">{$template.prompt|nl2br nofilter}</small></td>
						<td>
							{foreach item="included" from=$template.fields_to_include key="field" name="fields_to_include"}
								{if $included eq "Y"}
									{$fields_to_include[$field]}<br />
								{/if}
							{/foreach}
						</td>
						<td>
							{foreach item="included" from=$template.fields_to_generate key="field" name="fields_to_generate"}
								{if $included eq "Y"}
									{$fields_to_generate[$field]}<br />
								{/if}
							{/foreach}
						</td>
						<td>
							{capture name="tools_list"}
								<li>{btn type="list" text=__("edit") href="ai_companion.update?template_id=`$template.template_id`"}</li>
								<li>{btn type="list" text=__("delete") class="cm-confirm" href="ai_companion.delete_template?template_id=`$template.template_id`"}</li>
							{/capture}
							
							<div class="hidden-tools">
								{dropdown content=$smarty.capture.tools_list}
							</div>
						</td>
					</tr>
					
				{/foreach}
			</tbody>
		</table>
	{else}	
		<p class="no-items">{__('ai_companion_no_templates')}</p>
	{/if}

{/capture}

{capture name="buttons"}
	<a href="{"ai_companion.update"|fn_url}" class="btn btn-primary">{__('ai_companion_add_template')}</a>
{/capture}

{capture name="mainbox_title"}
	{__('ai_companion_templates')}
{/capture}

{include file="common/mainbox.tpl" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons title=$smarty.capture.mainbox_title}