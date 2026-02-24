{if in_array($block_data.ab__ab_hide_block, ['W','A'])}
<div class="ab-antibot-bots_block">
{if $block_data.ab__ab_hide_block == 'A'}
<div class="all" title="{__("ab__ab.layout_block.hide_block.variants.a")}">
<span class="white"></span>
<span class="black"></span>
</div>
{else}
<div class="black" title="{__("ab__ab.layout_block.hide_block.variants.w")}">
<span class="black"></span>
<span class="black"></span>
</div>
{/if}
</div>
{/if}
