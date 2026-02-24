{if $field.field_name eq "b_state"}

	<select class="form-control form-select" name="user_data[b_state]" id="{$id_prefix}elm_{$field.field_id}">
		<option value="">-selectati judet-</option>
		{foreach item="state" from=$states key="state_code"}
			<option value="{$state_code}" {if $state_code eq  $user_data.b_state} selected{/if}>{$state}</option>
		{/foreach}
	</select>
	
{/if}

{if $field.field_name eq "b_city"}
	<select class="form-control form-select" name="user_data[b_city]" id="{$id_prefix}elm_{$field.field_id}"> 
		<option value="">-selectati localitate-</option>
		
		{if $b_cities}
			{foreach item="city" from=$b_cities}
				<option value="{$city}" {if $user_data.b_city|strtolower eq $city|strtolower} selected {/if}>{$city}</option>
			{/foreach}
		{/if}
	</select>
{/if}


{if $field.field_name eq "s_state"}
	<select class="form-control form-select" name="user_data[s_state]" id="{$id_prefix}elm_{$field.field_id}">
		<option value="">-selectati judet-</option>
		{foreach item="state" from=$states key="state_code"}
			<option value="{$state_code}" {if $state_code eq  $user_data.s_state} selected{/if}>{$state}</option>
		{/foreach}
	</select>
{/if}

{if $field.field_name eq "s_city"}
	<select class="form-control form-select" name="user_data[s_city]" id="{$id_prefix}elm_{$field.field_id}"> 
		<option value="">-selectati localitate-</option>
		
		{if $s_cities}
			{foreach item="city" from=$s_cities}
				<option value="{$city}" {if $user_data.s_city|strtolower eq $city|strtolower} selected {/if}>{$city}</option>
			{/foreach}
		{/if}
	</select>
{/if}

