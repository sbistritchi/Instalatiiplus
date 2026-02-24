{if $notes}
    {include file="common/help.tpl" content=$notes id=$notes_id}
{/if}
<h4>{if $tooltip}{include file="common/tooltip.tpl" tooltip=$tooltip}{/if}
    {$title}
    {if $additional_id}<small class="muted"> #{$additional_id}</small>{/if}
    {if $target}<span class="icon-caret-down"></span>{/if}
</h4>