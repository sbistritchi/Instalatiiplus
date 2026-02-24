{if $ab__p_ignore_product_preload_positions &&
    $ab__p_ignore_product_preload_layout &&
    $ab__preload_settings[$ab__p_ignore_product_preload_layout]}
        {foreach $ab__p_ignore_product_preload_positions as $pos}
            {if $pos <= $ab__preload_settings[$ab__p_ignore_product_preload_layout]}
                {$ab__preload_settings["ignore_{$ab__p_ignore_product_preload_layout}"] = $ab__preload_settings["ignore_{$ab__p_ignore_product_preload_layout}"] + 1 scope="global"}
            {/if}
        {/foreach}
{/if}
