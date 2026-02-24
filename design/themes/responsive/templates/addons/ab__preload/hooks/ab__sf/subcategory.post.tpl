{counter name="subcategories" assign="s_counter" print=false}
{if $s_counter <= $ab__preload_settings.preload_subcategories}
    {$ab__preload = $ab__preload_settings.subcategories_pov scope = "parent"}
{/if}