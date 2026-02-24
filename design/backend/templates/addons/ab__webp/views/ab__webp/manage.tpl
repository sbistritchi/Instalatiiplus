{capture name="mainbox"}
{if "ab__webp.run_queue"|fn_check_view_permissions:"POST"}
<form action="{""|fn_url}" method="post" name="manage_ab__webp" class="form-edit form-horizontal" enctype="multipart/form-data">
<div class="control-group setting-wide">
<label for="" class="control-label">{__("ab__webp.run_queue.label")}
<div class="muted description">{__("ab__webp.run_queue.description",["[limit]"=>$smarty.const.AB__WEBP_CONVERT_THRESHOLD])}</div>
</label>
<div class="controls">
<input type="hidden" name="redirect_url" value="{$config.current_url}" />
{include file="buttons/button.tpl"
but_text=__("ab__webp.run_queue")
but_role="action"
but_meta="cm-submit"
but_name="dispatch[ab__webp.run_queue]"
but_target_id="ab__webp_image_queue"
}
<div class="muted" id="ab__webp_image_queue">
{__("ab__webp.images_in_queue_amount",['[amount]'=>fn_ab__webp_get_images_in_queue_amount()])}
<!--ab__webp_image_queue--></div>
</div>
</div>
<div class="control-group setting-wide">
<label for="" class="control-label">{__("ab__webp.delete_generated_images.label")}
<div class="muted description">{__("ab__webp.delete_generated_images.description")}</div>
</label>
<div class="controls">
{include file="buttons/button.tpl"
but_text=__("ab__webp.delete")
but_role="action"
but_meta="cm-submit cm-confirm"
but_name="dispatch[ab__webp.delete_generated_images]"
but_target_id="ab__webp_total_images"
}
<div class="muted" id="ab__webp_total_images">
<!--ab__webp_total_images--></div>
</div>
</div>
</form>
<script>
(function(_, $) {
$(document).ready(function(){
$.ceAjax('request', fn_url('ab__webp.get_size'), {
hidden: true,
callback: function(data) {
if(data.response !== undefined && data.response){
$('#ab__webp_total_images').text(data.response)
}
},
});
})
}(Tygh, Tygh.$));
</script>
{/if}
{assign var="cron_cmd" value="*/30 * * * * php `$config.dir.root`/`$config.admin_index` --dispatch=ab__webp.run_queue --p"}
{include file="common/widget_copy.tpl" widget_copy_title=__("ab__webp.cron.title") widget_copy_text=__("ab__webp.cron.text") widget_copy_code_text=$cron_cmd}
{/capture}
{include file="addons/ab__addons_manager/views/ab__am/components/menu.tpl" addon="ab__webp"}
{include file="common/mainbox.tpl"
title_start=__("ab__webp")|truncate:40
title_end=__("ab__webp.manage")
content=$smarty.capture.mainbox
buttons=$smarty.capture.buttons
adv_buttons=$smarty.capture.adv_buttons
sidebar=$smarty.capture.sidebar}
