{if $ab__preload && $image_data.image_path}
    {if $lazy_load}
        {$restore = true}
    {/if}

    {if $app.ab__total_pov <= 100}
        {$app.ab__total_pov = $app.ab__total_pov + $ab__preload|default:1}
        {$lazy_load = false scope="parent"}
        {if $restore}

            {$image_additional_attrs['lazy_load_disabled'] = true scope="parent"}
            {$restore = false}
        {/if}

        <!--ab__image_preload:{$image_data.image_path}<{$ab__preload}>-->
    {/if}
    {$ab__preload = false scope="global"}
{/if}
