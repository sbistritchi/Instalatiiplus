{if !$no_images && $ab__preload_settings.preload_main_product_image == "YesNo::YES"|enum}
    {if $addons.hidpi.status === "A"}
        {$ab__preload = 50 scope="parent"}
    {else}
        {$ab__preload = 100 scope="parent"}
    {/if}
{/if}