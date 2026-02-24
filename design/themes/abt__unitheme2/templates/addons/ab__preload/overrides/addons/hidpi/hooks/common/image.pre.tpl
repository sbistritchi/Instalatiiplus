{if $image_data.is_thumbnail}
    {$width = $image_data.width * 2}
    {$height = $image_data.height * 2}
    {$image_data2x = $images|fn_image_to_display:$width:$height}
{elseif $images.icon.is_high_res}
    {$image_data2x = $image_data}
    {$image_data = $images|fn_image_to_display:$images.icon.image_x:$images.icon.image_y scope=parent}
{elseif $images.original_image_path}
    {$image_data2x = $images}
    {$image_data2x["image_path"] = $images.original_image_path}
{/if}


{if $ab__preload && $image_data2x.image_path && $app.ab__total_pov <= 100}
    {if ($smarty.cookies.ab__p_dpr && $smarty.cookies.ab__p_dpr >= 2) || (!$smarty.cookies.ab__p_dpr && $settings.ab__device === "mobile")}
        {$app.ab__total_pov = $app.ab__total_pov + $ab__preload|default:1}

        <!--ab__image_preload:{$image_data2x.image_path}<{$ab__preload}>-->
        {$ab__preload = false scope="global"}
    {/if}
    {$lazy_load = false  scope="parent"}
    {$diable_lazy_load = true   scope="parent"}
{/if}

{if $lazy_load}
    {$attr_name = 'data-srcset'}
{else}
    {$attr_name = 'srcset'}
{/if}

{if $image_data2x.image_path}
    {if $capture_image}
        {capture name="icon_image_path_hidpi"}{$image_data2x.image_path} 2x{/capture}
    {else}
        {$image_additional_attrs[$attr_name] = "{$image_data2x.image_path} 2x" scope=parent}
    {/if}
{/if}
