{* <div class="control-group {$no_hide_input_if_shared_product}">
    <label for="product_description_ss_baselinker_name" class="control-label">{__("ss_baselinker_name")}:</label>
    <div class="controls">
        <input class="input-large" form="form" type="text" name="product_data[ss_baselinker_name]" id="product_description_ss_baselinker_name" size="55" value="{$product_data.ss_baselinker_name}" />
        {include file="buttons/update_for_all.tpl" display=$show_update_for_all object_id="ss_baselinker_name" name="update_all_vendors[ss_baselinker_name]"}
    </div>
</div>

<div class="control-group cm-no-hide-input {$no_hide_input_if_shared_product}" >
    <label class="control-label" for="elm_product_ss_baselinker_descr">{__("ss_baselinker_description")}:</label>
    <div class="controls">
        {include file="buttons/update_for_all.tpl" display=$show_update_for_all object_id="ss_baselinker_description" name="update_all_vendors[ss_baselinker_description]"}
        <textarea id="elm_product_ss_baselinker_descr"
                  name="product_data[ss_baselinker_description]"
                  cols="55"
                  rows="8"
                  class="cm-wysiwyg input-large"
                  data-ca-is-block-manager-enabled="{fn_check_view_permissions("block_manager.block_selection", "GET")|intval}"
        >{$product_data.ss_baselinker_description}</textarea>
    </div>
</div> *}