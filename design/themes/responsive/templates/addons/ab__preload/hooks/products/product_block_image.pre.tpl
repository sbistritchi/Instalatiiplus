{if $block.type == "main"}
    {counter name="products_without_options" assign="c" print=false}
    {if $c <= $ab__preload_settings.products_without_options - $ab__preload_settings.ignore_products_without_options}
        {$ab__preload = $ab__preload_settings.products_without_options_pov scope="parent"}
    {/if}
{/if}