{if $block.properties.disable_first_banner_lazy_load == "Y"}
    {counter name="banners" assign="c" print=false}
    {if $c === 1}
        {$data_backgroud_url = $data_backgroud_url|default:$background_url|default:false}
        {$pov = $block.properties["pov_`$settings.abt__device`"]|default:2}
        {if $data_backgroud_url && $b.abt__yt_main_image.icon.image_path}
            {$pov = $pov/2}
        {/if}
        {if $data_backgroud_url}
            {$background_url=$data_backgroud_url scope="parent"}
            {$data_backgroud_url=null scope="parent"}
            <!--ab__image_preload:{$background_url}<{$pov}>-->
            {$ab__preload = $pov scope="parent"}
        {/if}
        {if $b.abt__yt_main_image.icon.image_path}
            {$ab__preload = $pov scope="parent"}
        {/if}
    {/if}
{/if}