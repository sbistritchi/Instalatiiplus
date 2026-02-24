{if "ab__ab_bots.manage"|fn_check_view_permissions:"GET"}
{if !in_array($block.type, ['main'])}
{include file="common/subheader.tpl" title=__("ab__antibot") target="#ab__antibot"}
<div id="ab__antibot" class="collapsed in{if !fn_check_permissions("ab__ab_bots", "update", "admin", "POST")} cm-hide-inputs{/if}">
<div class="control-group">
<label class="control-label" for="block_{$html_id}_ab__ab_hide_block">{__("ab__ab.hide_block")}</label>
<div class="controls">
<select name="block_data[ab__ab_hide_block]" id="block_{$html_id}_ab__ab_hide_block">
{foreach ["Tygh\Enum\Addons\Ab_antibot\Modes::DO_NOT_HIDE"|constant, "Tygh\Enum\Addons\Ab_antibot\Modes::HIDE_EXCEPT_WHITE_LIST"|constant, "Tygh\Enum\Addons\Ab_antibot\Modes::HIDE"|constant] as $mode}
{if $block.type == 'ab__intelligent_accessories'}
<option value="{$mode}"{if $mode == "Tygh\Enum\Addons\Ab_antibot\Modes::HIDE"|constant} selected="selected"{else} disabled="disabled"{/if}>{__("ab__ab.hide_block.variants.{$mode|lower}")}</option>
{else}
<option value="{$mode}"{if $mode == $block.ab__ab_hide_block} selected="selected"{/if}>{__("ab__ab.hide_block.variants.{$mode|lower}")}</option>
{/if}
{/foreach}
</select>
</div>
</div>
</div>
{/if}
{/if}
