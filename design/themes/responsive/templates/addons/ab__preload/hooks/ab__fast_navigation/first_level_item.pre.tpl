{if $properties.enable_preload == "YesNo::YES"|enum}
    {$setting_name = "ab__fn_number_of_columns_{$settings.abt__device|default:"desktop"}"}
    {$pov = "pov_{$settings.abt__device|default:"desktop"}"}
    {$max_items = $properties[$setting_name]}
    
    {if $max_items > $item@index}
        {$ab__preload = $properties[$pov] scope="parent"}
    {/if}
{/if}