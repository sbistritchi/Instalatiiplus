{if $block.type == "main"}
    {counter name="short_list" assign="c" print=false}
    {if $c <= $ab__preload_settings.short_list - $ab__preload_settings.ignore_short_list}
        {$ab__preload = $ab__preload_settings.short_list_pov scope="parent"}
    {/if}
{/if}