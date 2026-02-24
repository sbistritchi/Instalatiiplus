{if $block.properties.disable_first_banner_lazy_load == "Y"}
    {if $b_iteration === 1 && $b.type == "G"}
        {$pov = $block.properties["pov_`$settings.abt__device`"]|default:2}
        {$ab__preload = $pov scope="parent"}
    {/if}
{/if}