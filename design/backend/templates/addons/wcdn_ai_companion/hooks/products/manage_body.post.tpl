<td>

	{if $product.ai_content}
		{if $product.ai_content.status eq "P"}
				<svg xmlns="http://www.w3.org/2000/svg" height="20" viewBox="0 0 48 48" width="20" class="cm-tooltip" title="Pending"><path d="M26 22.086V11a1 1 0 0 0-1-1h-2a1 1 0 0 0-1 1v12.586a1 1 0 0 0 .293.707l6.3 6.3a1 1 0 0 0 1.414 0l1.336-1.336a1 1 0 0 0 0-1.414l-5.054-5.054a1 1 0 0 1-.289-.703Z"/><path d="M40.063 26A16.193 16.193 0 1 1 22 7.937V4.1A20 20 0 1 0 43.9 26ZM32.171 5.759A19.839 19.839 0 0 0 26 4.1v3.837a16.063 16.063 0 0 1 4.261 1.148ZM37.026 14.419l3.344-1.87a20.117 20.117 0 0 0-4.726-4.8l-1.917 3.338a16.4 16.4 0 0 1 3.299 3.332ZM38.975 17.914A15.972 15.972 0 0 1 40.063 22H43.9a19.827 19.827 0 0 0-1.566-5.965Z"/></svg>
		{else}
			{if $product.ai_content.applied eq "Y"}
				{$score = $product.ai_content.score}
				
				{if $score > 0 && $score < 61}
				
					{$background = "conic-gradient(#db3438 0% {$product.ai_content.score}%, #e0e0e0 `$product.ai_content.score`% 100%)"}
					{$color = '#db3438'}
					
				{elseif $score >= 61 && $score <= 80}
					
					{$background = "conic-gradient(#ff8437 0% {$product.ai_content.score}%, #e0e0e0 `$product.ai_content.score`% 100%)"}
					{$color = '#ff8437'}
					
				{else}
				
					{$background = "conic-gradient(#1abc33 0% {$product.ai_content.score}%, #e0e0e0 `$product.ai_content.score`% 100%)"}
					{$color = '#1abc33'}
					 
				{/if}
				
				<div class="circular-border" style="background:{$background};"><span style="color: {$color};">{$product.ai_content.score}</span></div>
			{else}
				<svg enable-background="new 0 0 20 20" height="20" class="cm-tooltip" title="{__('ai_companion_done_but_not_applied')}" viewBox="0 0 20 20" width="20" xmlns="http://www.w3.org/2000/svg"><path d="m0 0h20v20h-20z" fill="none"/><path d="m10 3c-3.87 0-7 3.13-7 7s3.13 7 7 7 7-3.13 7-7-3.13-7-7-7zm0 13c-3.31 0-6-2.69-6-6s2.69-6 6-6 6 2.69 6 6-2.69 6-6 6z"/><circle cx="6.5" cy="10" r="1"/><circle cx="13.5" cy="10" r="1"/><circle cx="10" cy="10" r="1"/></svg>
			{/if}
		{/if}
	{/if}
</td> 