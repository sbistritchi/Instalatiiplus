{** Use this variables to check sticker style **}
{$text_style = "Tygh\Enum\Addons\Ab_stickers\StickerStyles::TEXT"|constant}
{$graphic_style = "Tygh\Enum\Addons\Ab_stickers\StickerStyles::GRAPHIC"|constant}
{$pictogram_style = "Tygh\Enum\Addons\Ab_stickers\StickerStyles::PICTOGRAM"|constant}

{$controller_mode = "`$runtime.controller`.`$runtime.mode`"}

{$skip = false}
{if $controller_mode == "product_features.compare" && $block.type == "main"}
    {$skip = true}
{/if}

{if $smarty.request.dispatch == "products.view" && $block.type == "main"}
    {$key_1 = "display_on_detailed_pages"}
    {$key_2 = ""}
{elseif $block.type != "main" && $block.properties.template}
    {$key_1 = "display_on_lists"}
    {$key_2 = $block.properties.template}
{elseif $ab__stickers_current_tmpl}
    {$key_1 = "display_on_lists"}
    {$key_2 = $ab__stickers_current_tmpl}
{/if}

{$pictogram_views = ['small_size' => [0], 'full_size' => [0]]}

{foreach $product.ab__s_pictograms as $pictogram}
    {$view_type = $pictogram.$key_1}
    {if $key_2}
        {$view_type = $view_type.$key_2}
    {/if}

    {$view_type_var = "`$view_type`_image_size"}
    {$pictogram_views[$view_type][] = $pictogram.appearance.$view_type_var}
{/foreach}

{$pictogram_views = array_merge($pictogram_views['small_size'], $pictogram_views['full_size'])}
{$pictogram_views = array_unique($pictogram_views)}

{if $skip === false}
    {hook name="ab__stickers:product_pictograms"}
        {hook name="ab__stickers:product_pictograms_pre"}
        {if $product.ab__s_pictograms}
            <div class="ab-s-pictograms-wrapper ab-s-pictograms-wrapper-h-{$pictogram_views|max}{if $position} ab-s-pictograms-wrapper-{$position}{/if}{if $key_1} ab-s-pictograms-wrapper-{$key_1}{/if}">
        {/if}
        {/hook}
            {if $product.ab__s_pictograms}
                {foreach $product.ab__s_pictograms as $pictogram}
                    {$view_type = $pictogram.$key_1}
                    {if $key_2}
                        {$view_type = $view_type.$key_2}
                    {/if}

                    <div class="ab-s-pictogram ab-sticker-{$view_type|default:"full_size"} small-image-size-{$pictogram.appearance.small_size_image_size} full-image-size-{$pictogram.appearance.full_size_image_size}" data-ab-sticker-id="{$pictogram@key}.{$product.product_id}"{if $pictogram.placeholders} data-placeholders='{$pictogram.placeholders}'{/if} data-product-id="{$product.product_id}" data-ab-sticker-style="{$pictogram.style}"></div>
                {/foreach}
            {/if}
        {if $product.ab__s_pictograms}
            </div>
        {/if}
    {/hook}
{/if}