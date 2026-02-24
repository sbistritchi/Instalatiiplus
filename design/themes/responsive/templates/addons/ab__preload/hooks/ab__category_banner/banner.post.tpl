{if $category_banner_position <= $ab__preload_settings[$layout]}
    {$ab__preload = $ab__preload_settings["`$layout`_pov"] scope="parent"}
{else}
    {$ab__preload = false scope="parent"}
{/if}