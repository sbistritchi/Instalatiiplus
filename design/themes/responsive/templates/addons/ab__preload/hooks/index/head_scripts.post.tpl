{$timestamp = fn_ab__p_get_css_timestamp()}
{$links = fn_ab__p_get_links()}

{if $links && $timestamp}
    {$formats = fn_get_schema('ab__preload', 'formats')}

    {foreach $links as $link}
        <link rel="preload" href="{$link.url}{if $link.use_timestamp == 'Y'}?{$timestamp}{/if}"{if $formats.{$link.format}.type} as="{$formats.{$link.format}.type}"{/if}{if $formats.{$link.format}.mime_type} type="{$formats.{$link.format}.mime_type}"{/if} crossorigin="anonymous">
    {/foreach}
{/if}