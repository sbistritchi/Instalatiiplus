{include file="addons/ab__lazy_load/components/disable_lazy_load.tpl"}
{if !"AJAX_REQUEST"|defined && ($lazy_load|default:false || $ab__ll.enable) && !$diable_lazy_load}
    {$lazy_load = true scope="parent"}
    {$image_additional_attrs["src"]=$ab__ll.placeholders->get_placeholer($image_width,$image_height)  scope="parent"}
    {$class = $class|cat:" lazyload" scope="parent"}

    
    {if $image_additional_attrs.srcset || $image_additional_attrs["data-srcset"]}
        {if $image_additional_attrs.srcset}
            {$image_additional_attrs["data-srcset"] = $image_additional_attrs.srcset scope="parent"}
        {/if}
        {$image_additional_attrs.srcset="`$ab__ll.placeholders->get_placeholer($image_width,$image_height,true)`"  scope="parent"}
    {/if}
{/if}