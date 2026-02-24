{if $block.properties.disable_first_banner_lazy_load == "Y"}
    {if $b_iteration === 1 || $block.properties.template == 'addons/abt__unitheme2/blocks/abt__ut2_banner_combined.tpl'}
        {$pov = $block.properties["pov_`$settings.abt__device`"]|default:2}
        {if ($data_backgroud_url || $background_url) && $b.abt__ut2_main_image.icon.image_path}
            {$pov = $pov/2}
        {/if}
        {if $data_backgroud_url || $background_url}
            {if $data_backgroud_url}
                {$background_url=$data_backgroud_url scope="parent"}
                {$data_backgroud_url=null scope="parent"}
            {/if}
            <!--ab__image_preload:{$background_url}<{$pov}>-->
            {$app.ab__total_pov = $app.ab__total_pov + $pov}
            {$ab__preload = $pov scope="parent"}
        {/if}
        {if $b.abt__ut2_main_image.icon.image_path}
            {$ab__preload = $pov scope="parent"}
        {/if}
    {/if}
{/if}
