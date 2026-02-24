{capture name="mainbox"}

	<div class="tabs">
    	<ul class="nav nav-tabs">
        	<li id="basic" class="{if $search.status eq "P"} active {/if}"><a href="{"ai_companion.content&status=P"|fn_url}">{__('ai_companion_content_status_pending')}</a></li> 
        	<li id="basic" class="{if $search.status eq "D"} active {/if}"><a href="{"ai_companion.content&status=D"|fn_url}">{__('ai_companion_content_status_done')}</a></li> 
        	<li id="basic" class="{if $search.status eq "A"} active {/if}"><a href="{"ai_companion.content&status=A"|fn_url}">{__('ai_companion_content_status_applied')}</a></li> 
        	<li id="basic" class="{if $search.status eq "E"} active {/if}"><a href="{"ai_companion.content&status=E"|fn_url}">Eroare la generare</a></li> 
    	</ul>
	</div>
	
	
	{if $ai_content}
	<div class="bulk-edit clearfix" data-ca-bulkedit-expanded-object="true">
		<ul class="btn-group bulk-edit__wrapper">
			<li class="btn bulk-edit__btn bulk-edit__btn--actions dropleft-mod">
				<span class="bulk-edit__btn-content dropdown-toggle" data-toggle="dropdown">{__('ai_content_bulk_remove')} <span class="caret mobile-hide"></span></span>
				<ul class="dropdown-menu">
					<li><a class="cm-process-items cm-submit " data-ca-target-form="ai_content_management" data-ca-dispatch="dispatch[ai_companion.delete_selected]">{__('ai_content_remove_selected')}</a></li>
					<li><a class="cm-process-items cm-submit " data-ca-target-form="ai_content_management" data-ca-dispatch="dispatch[ai_companion.delete_all]">{__('ai_content_remove_all')}</a></li>
				</ul>
			</li>
			
			{if $search.status eq "D" || $search.status eq "A" || $search.status eq "E"}
			<li class="btn bulk-edit__btn bulk-edit__btn--actions dropleft-mod">
				<span class="bulk-edit__btn-content dropdown-toggle" data-toggle="dropdown">{__('ai_content_bulk_reload')} <span class="caret mobile-hide"></span></span>
				<ul class="dropdown-menu">
					<li><a class="cm-process-items cm-submit " data-ca-target-form="ai_content_management" data-ca-dispatch="dispatch[ai_companion.reload_selected]">{__('ai_content_bulk_reload_selected')}</a></li>
					<li><a class="cm-process-items cm-submit " data-ca-target-form="ai_content_management" data-ca-dispatch="dispatch[ai_companion.reload_all]">{__('ai_content_bulk_reload_all')}</a></li>
				</ul>
			</li>
			
			<li class="btn bulk-edit__btn bulk-edit__btn--actions dropleft-mod">
				<span class="bulk-edit__btn-content dropdown-toggle" data-toggle="dropdown">{__('ai_content_bulk_apply')} <span class="caret mobile-hide"></span></span>
				<ul class="dropdown-menu">
					<li><a class="cm-process-items cm-submit " data-ca-target-form="ai_content_management" data-ca-dispatch="dispatch[ai_companion.apply_selected]">{__('ai_content_bulk_apply_selected')}</a></li>
					<li><a class="cm-process-items cm-submit " data-ca-target-form="ai_content_management" data-ca-dispatch="dispatch[ai_companion.apply_all]">{__('ai_content_bulk_apply_all')}</a></li>
				</ul>
			</li>
			{/if}
		</ul>
	</div>
	{/if}
	
	<form method="POST" action="{""|fn_url}" name="ai_content_management" id="ai_content_management">
	<input type="hidden" name="current_status" value="{$search.status}">
	
	{if $ai_content}
		{include file="common/pagination.tpl"}
		<table class="table table-responsive table-hover table-middle">
			<thead>
				<tr>
					<th width="1%">
						<input type="checkbox" id="check_all_items" />
					</th>
					
					<th>{__('product')}</th>
					
					{if $search.status neq "E"}
						{foreach item="field" from=$fields_to_generate key="field_id"}
							<th>{$field}</th>
						{/foreach}
					{else}
						<th>Raspuns GPT</th>
					{/if}
					
				</tr>
			</thead>
			<tbody>
				{foreach item="content" from=$ai_content}
					<tr>
						<td><input type="checkbox" name="content_ids[]" value="{$content.content_id}"></td>
						<td>	<a href="{"products.update&product_id=`$content.product_id`"|fn_url}" style="    display: flex;flex-direction: row;align-items: center;">
						
							{$score = $content.score}
							
							{if $score > 0 && $score < 61}
							
								{$background = "conic-gradient(#db3438 0% {$score}%, #e0e0e0 `$score`% 100%)"}
								{$color = '#db3438'}
								
							{elseif $score >= 61 && $score <= 80}
								
								{$background = "conic-gradient(#ff8437 0% {$score}%, #e0e0e0 `$score`% 100%)"}
								{$color = '#ff8437'}
								
							{else}
							
								{$background = "conic-gradient(#1abc33 0% {$score}%, #e0e0e0 `$score`% 100%)"}
								{$color = '#1abc33'}
								 
							{/if}
				
							<div class="circular-border" style="background:{$background}; margin-right: 10px; min-width:30px">
								<span style="color: {$color};">{$content.score}</span>
							</div>
							
							{$content.product}</a>
						</td>
						
						{if $search.status neq "E"}
							{foreach item="field" from=$fields_to_generate key="field_id"}
								<td>{$content.response.$field_id|default:''}</td>
							{/foreach}
						{else}
							<td>{$content.response}</td>
						{/if}
					</tr>
				{/foreach}
			</tbody>
		</table>
		{include file="common/pagination.tpl"}
	{else}	
		<p class="no-items">{__('ai_companion_no_items_fount')}</p>
	{/if}
	<!--ai_content_management--></form>

{/capture}

{capture name="buttons"}
	<a href="{"ai_companion.update"|fn_url}" class="btn btn-primary">{__('ai_companion_add_template')}</a>
{/capture}

{capture name="mainbox_title"}
	{__('ai_companion_generated_content')}
{/capture}

{include file="common/mainbox.tpl" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons title=$smarty.capture.mainbox_title}