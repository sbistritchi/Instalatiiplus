{capture name="mainbox"}

{if $ss_baselinker_extra_fields}
    {assign var="id" value=$ss_baselinker_extra_fields.ss_baselinker_extra_fields_id}
{else}
    {assign var="id" value=0}
{/if}

{if defined('AJAX_REQUEST')}
    {$in_popup = true}
{/if}

<div id="content_group_{$id}">
    <form action="{""|fn_url}" method="post" name="ss_baselinker_extra_fields_form_{$id}" class="form-horizontal form-edit cm-disable-empty-files {$hide_inputs_class}" enctype="multipart/form-data"">
        <input type="hidden" class="cm-no-hide-input" name="fake" value="1" />
        <input type="hidden" class="cm-no-hide-input" name="ss_baselinker_extra_fields_id" value="{$id}" />
        <div id="content_general">
            <fieldset>
                <div class="control-group">
                    <label class="control-label cm-required" for="elm_ss_baselinker_extra_fields_name">{__("ss_baselinker_extra_fields_name_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_extra_fields_name_tooltip)}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_extra_fields[name]" id="elm_ss_baselinker_extra_fields_name" size="35" value="{$ss_baselinker_extra_fields.name}" class="input-large" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label cm-required" for="elm_ss_baselinker_extra_fields_bl_field">{__("ss_baselinker_extra_fields_bl_field_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_extra_fields_bl_field_tooltip)}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_extra_fields[bl_field]" id="elm_ss_baselinker_extra_fields_bl_field" size="35" value="{$ss_baselinker_extra_fields.bl_field}" class="input-large" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label " for="elm_ss_baselinker_extra_fields_custom">{__("ss_baselinker_extra_fields_custom_field")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_extra_fields_custom_tooltip)}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_extra_fields[custom]" id="elm_ss_baselinker_extra_fields_custom" size="35" value="{$ss_baselinker_extra_fields.custom}" class="input-large" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label " for="elm_ss_baselinker_extra_fields_position">{__("ss_baselinker_extra_fields_position_field")}:</label>
                    <div class="controls">
                        <input type="text" name="ss_baselinker_extra_fields[position]" id="elm_ss_baselinker_extra_fields_position" size="5" value="{$ss_baselinker_extra_fields.position}" class="input-medium" />
                    </div>
                </div>
                {include file="common/select_status.tpl" input_name="ss_baselinker_extra_fields[status]" id="elm_ss_baselinker_extra_fields_status" obj=$ss_baselinker_extra_fields}
            </fieldset>
        </div>

        {if $in_popup}
            <div class="buttons-container">
                {include file="buttons/save_cancel.tpl" but_name="dispatch[ss_baselinker_extra_fields.update]" cancel_action="close" hide_first_button=$hide_first_button save=$id}
            </div>
        {else}
            {capture name="buttons"}
                {include file="buttons/save_cancel.tpl" but_role="submit-link" but_name="dispatch[ss_baselinker_extra_fields.update]" but_target_form="ss_baselinker_extra_fields_form_{$id}" save=$id}
            {/capture}
        {/if}
    </form>
<!--content_group_{$id}--></div>
{/capture}

{if $in_popup}
    {$smarty.capture.mainbox nofilter}
{else}
    {include file="common/mainbox.tpl" title=__("ss_baselinker_extra_fields_new") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons}
{/if}