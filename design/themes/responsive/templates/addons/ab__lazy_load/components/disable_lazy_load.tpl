{$diable_lazy_load = false}


{if  $block.properties.template|default:"" == "blocks/static_templates/logo.tpl"}
    {$diable_lazy_load = true scope="parent"}
{/if}
