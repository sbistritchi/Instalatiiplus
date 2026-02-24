{if $block.type == "main"}
    {counter name="products_multicolumns" assign="c" print=false}
    {if $c <= $ab__preload_settings.products_multicolumns - $ab__preload_settings.ignore_products_multicolumns}
        {$ab__preload = $ab__preload_settings.products_multicolumns_pov scope="parent"}
    {/if}
{/if}