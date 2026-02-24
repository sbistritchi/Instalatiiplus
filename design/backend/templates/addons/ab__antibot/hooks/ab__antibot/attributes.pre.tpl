{if in_array($block_data.ab__ab_hide_block, ['W','A'])}
{foreach ['for_white_bots', 'for_black_and_other_bots'] as $ab__antibot_view}
data-ca-ab-antibot-view-{$ab__antibot_view}="{if $ab__antibot_view == 'for_white_bots' && $block_data.ab__ab_hide_block == 'W'}true{else}false{/if}"
{/foreach}
{/if}