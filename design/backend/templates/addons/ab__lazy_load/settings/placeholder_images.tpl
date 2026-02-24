{if $ab__allowed_placeholder}
<div id="container_ab__ll_placeholder" class="attach-images control-group setting-wide">
<label class="control-label" for="elm_ab__lazy_load_placeholder_image">
{__("ab__lazy_load.placeholder_image")}:
<div class="muted description">
{__("ab__lazy_load.placeholder_image.tooltip")}
</div>
</label>
<div class="controls">
{include file="common/attach_images.tpl"
image_name="ab__ll_placeholder"
image_object_type="ab__ll_placeholder"
image_pair=$ab__ll_placeholder
no_detailed=true
hide_titles=true
hide_alt=true
}
</div>
</div>
{/if}