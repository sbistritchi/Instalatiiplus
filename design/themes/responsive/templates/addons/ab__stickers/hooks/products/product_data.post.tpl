{** Use this variables to check sticker style **}
{$text_style = "Tygh\Enum\Addons\Ab_stickers\StickerStyles::TEXT"|constant}
{$graphic_style = "Tygh\Enum\Addons\Ab_stickers\StickerStyles::GRAPHIC"|constant}
{$pictogram_style = "Tygh\Enum\Addons\Ab_stickers\StickerStyles::PICTOGRAM"|constant}

{$controller_mode = "`$runtime.controller`.`$runtime.mode`"}

{$skip = false}
{if $controller_mode == "product_features.compare" && $block.type == "main"}
    {$skip = true}
{/if}

{capture name="ab__stickers_`$obj_prefix``$obj_id`"}
    {if $skip === false}
        {hook name="ab__stickers:product_stickers"}
            {hook name="ab__stickers:product_stickers_pre"}
                {if $details_page && $product.ab__stickers}
                <div class="ab-stickers-wrapper ab-hidden">
                {/if}
            {/hook}
                {if $product.ab__stickers}
                    {$pos = 'list'}

                    {if $smarty.request.dispatch == "products.view" && $block.type == "main"}
                        {$pos = "detailed_page"}
                        {$key_1 = "display_on_detailed_pages"}
                        {$key_2 = ""}
                    {elseif $block.type != "main" && $block.properties.template}
                        {$key_1 = "display_on_lists"}
                        {$key_2 = $block.properties.template}
                    {elseif $ab__stickers_current_tmpl}
                        {$key_1 = "display_on_lists"}
                        {$key_2 = $ab__stickers_current_tmpl}
                    {/if}

                    {$current_position = "output_position_{$pos}"}

                    {foreach $product.ab__stickers as $position}
                        {$pos_counter = 0}
                        <div class="ab-stickers-container ab-stickers-container__{$position@key}{$addons.ab__stickers.output_position} {$addons.ab__stickers.{"`$position@key``$addons.ab__stickers.output_position`_output_type"}}-filling">
                            {foreach $position as $sticker}
                                {$view_type = $sticker.$key_1}
                                {if $key_2}
                                    {$view_type = $view_type.$key_2}
                                {/if}

                                {if $pos_counter < $addons.ab__stickers.{"`$position@key``$addons.ab__stickers.output_position`_max_count"}}
                                    {$pos_counter = $pos_counter + 1}
                                    <div class="ab-sticker-{$view_type|default:"full_size"}{if $sticker.style == $graphic_style} small-image-size-{$sticker.appearance.small_size_image_size} full-image-size-{$sticker.appearance.full_size_image_size}{/if}" data-ab-sticker-id="{$sticker@key}"{if $sticker.placeholders} data-placeholders='{$sticker.placeholders}'{/if}></div>
                                {/if}
                            {/foreach}
                        </div>
                    {/foreach}
                {/if}
            {if $details_page && $product.ab__stickers}
                </div>
            {/if}
        {/hook}
    {/if}
{/capture}

{$capture_name = "product_labels_`$obj_prefix``$obj_id`"}

{capture name=$capture_name}
    {if trim(strip_tags($smarty.capture.{"ab__stickers_`$obj_prefix``$obj_id`"}, "<div>"))}
        {$smarty.capture.{"ab__stickers_`$obj_prefix``$obj_id`"} nofilter}
    {else}
        {$smarty.capture.{"product_labels_`$obj_prefix``$obj_id`"} nofilter}
    {/if}
{/capture}

{$real_product_id = 0}

{if $product.product_id}
    {$real_product_id = $product.product_id}
{elseif $smarty.request.product_id}
    {$real_product_id = $smarty.request.product_id}
{/if}

{if $is_allow_add_common_products_to_cart_list && $real_product_id}
    {$real_capture_name = "product_labels_`$obj_prefix``$real_product_id`"}

    {capture name=$real_capture_name}
        {$smarty.capture.$capture_name nofilter}
    {/capture}
{/if}