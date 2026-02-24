{$show_pictograms = false}
{$theme_name = fn_get_theme_path('[theme]')}

{if $theme_name === 'abt__youpitheme'}
    {$theme_settings = $settings.abt__yt}
{else}
    {$theme_settings = $settings.abt__ut2}
{/if}

{if (!$tmpl && $smarty.request.dispatch === 'products.view' && ($block.type === 'main' || (empty($block) && !$smarty.request.full_render))) || $smarty.request.dispatch === 'products.quick_view'}
    {if $theme_name === 'abt__youpitheme'}
        {$show_pictograms = $theme_settings.products.ab__s_pictogram_position[$settings.abt__device] === $position}
    {else}
        {$show_pictograms = $theme_settings.products.view.ab__s_pictogram_position[$settings.abt__device] === $position}
    {/if}

    {if empty($block)}
        {$block = fn_ab__stickers_get_main_block()}
    {/if}

{elseif $tmpl}
    {$show_pictograms = $theme_settings.product_list.$tmpl.ab__s_pictogram_position[$settings.abt__device] === $position}
{else}
    {$show_pictograms = $theme_settings.product_list.ab__s_pictogram_position[$settings.abt__device] === $position}
{/if}

{if $show_pictograms}
    {include file="addons/ab__stickers/views/ab__stickers/components/pictograms_wrapper.tpl" details_page=$details_page product=$product block=$block}
{/if}