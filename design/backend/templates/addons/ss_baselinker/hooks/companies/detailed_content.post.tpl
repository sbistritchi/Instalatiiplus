{if "MULTIVENDOR"|fn_allowed_for}
    {include file="common/subheader.tpl" title=__("ss_baselinker_settings_vendor") target="#ss_baselinker_settings_vendor" meta="collapsed"}
    <div id="ss_baselinker_settings_vendor" class="collapse">
        {if $smarty.session.auth.user_type == "A"}
        <div class="control-group">
            <label class="control-label" for="ss_baselinker_api_allow">{__("ss_baselinker_api_allow")}:</label>
            <div class="controls">
                <input type="hidden" name="company_data[ss_baselinker_api_allow]" value="N"/>
                <input type="checkbox" name="company_data[ss_baselinker_api_allow]" id="ss_baselinker_api_allow" value="Y" {if $company_data.ss_baselinker_api_allow == "Y"}checked="checked"{/if} class="checkbox" />
            </div>
        </div>
        {/if}
        {if $company_data.ss_baselinker_api_allow == "Y" || $company_data.plan_id|fn_ss_baselinker_get_plan_api_allow}
            {assign var="disallowed_fields_table" value=$smarty.session.auth.company_id|fn_ss_baselinker_get_disallowed_fields}
            {include file="common/subheader.tpl" title=__("ss_baselinker_general") target="#ss_baselinker_general"}
            <div id="ss_baselinker_general" class="in collapse">
                <!-- START section ss_baselinker_general -->
                <div class="control-group">
                    <label for="ss_baselinker_password" class="control-label">{__("ss_baselinker_password")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_password_tooltip)}:</label>
                    <div class="controls">
                        <input type="text" style="width:300px" value="{$company_data.ss_baselinker.ss_baselinker_password}" name="company_data[ss_baselinker][ss_baselinker_password]" id="ss_baselinker_password" class="input-medium">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="ss_baselinker_vendor_link_tooltip">{__("ss_baselinker_vendor_link")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_vendor_link_tooltip)}:</label>
                    <div class="controls">
                        {assign var="link" value=$company_data.company_id|fn_ss_baselinker_data_exchange_link:"company_data"}
                        {assign var="link_clean" value=$company_data.company_id|fn_ss_baselinker_data_exchange_link:"clean"}
                        <p id="ss_baselinker_vendor_link_tooltip">{$link nofilter}
                        <a class="btn_clip" onclick="fn_ss_bl_jsCopyClipboard('{$link_clean}', '{__('ss_bl_csmv_copy_to_clip_info')}', '{__('ss_bl_csmv_copy_to_clip_message')}')" title="{__("ss_bl_csmv_copy_to_clip_title")}">
                        <span class="btn_clip_span"></span>{__("ss_bl_csmv_copy_to_clip")}</a>
                        </p>
                    </div>
               </div>
            </div>
            <!-- STOP section ss_baselinker_general -->
            <!-- START section ss_baselinker_profile_fields -->
            <!-- STOP section ss_baselinker_profile_fields -->

            <!-- START section ss_baselinker_send_products -->
            {include file="common/subheader.tpl" title=__("ss_baselinker_send_products") target="#ss_baselinker_send_products"}
            <div id="ss_baselinker_send_products" class="in collapse">
                {if $disallowed_fields_table.ss_baselinker_export_statuses != "Y"}
                <div class="control-group">
                   <label class="control-label">{__("ss_baselinker_export_statuses")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_export_statuses_tooltip)}:</label>
                   <div class="controls">
                       <input type="hidden" name="company_data[ss_baselinker][ss_baselinker_export_statuses]" value="" />
                       <label class="checkbox" for="elm_statuses_A"><input type="checkbox" class="cm-combo-checkbox cm-toggle-element" name="company_data[ss_baselinker][ss_baselinker_export_statuses][A]" id="elm_statuses_A" value="A" {if ($company_data.ss_baselinker.ss_baselinker_export_statuses.A == "Y")}checked="checked"{/if}/>{__("active")}</label>
                       <label class="checkbox" for="elm_statuses_H"><input type="checkbox" class="cm-combo-checkbox cm-toggle-element" name="company_data[ss_baselinker][ss_baselinker_export_statuses][H]" id="elm_statuses_H" value="H" {if ($company_data.ss_baselinker.ss_baselinker_export_statuses.H == "Y")}checked="checked"{/if}/>{__("hidden")}</label>                                    
                   </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_option_type != "Y"}
                <div class="control-group">
                   <label class="control-label" for="ss_baselinker_option_type">{__("ss_baselinker_option_type")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_option_type_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_baselinker_option_type]" id="ss_baselinker_option_type">
                           <option value="variants" {if $company_data.ss_baselinker.ss_baselinker_option_type == "variants"}selected="selected"{/if}>{__("ss_baselinker_option_type_variants")}</option>
                           <option value="combinations" {if $company_data.ss_baselinker.ss_baselinker_option_type == "combinations"}selected="selected"{/if}>{__("ss_baselinker_option_type_combinations")}</option>
                       </select>
                   </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_promotion_price != "Y"}
                <div class="control-group">
                    <label class="control-label" for="ss_baselinker_promotion_price">{__("ss_baselinker_promotion_price")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_promotion_price_tooltip)}:</label>
                    <div class="controls">
                        <input type="hidden" name="company_data[ss_baselinker][ss_baselinker_promotion_price]" value="N" />
                        <input id="ss_baselinker_promotion_price" type="checkbox" name="company_data[ss_baselinker][ss_baselinker_promotion_price]" value="Y" {if $company_data.ss_baselinker.ss_baselinker_promotion_price eq 'Y'} checked="checked"{/if}/>
                    </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_use_bl_name != "Y"}
                <div class="control-group">
                    <label class="control-label" for="ss_baselinker_use_bl_name">{__("ss_baselinker_use_bl_name")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_use_bl_name_tooltip)}:</label>
                    <div class="controls">
                        <input type="hidden" name="company_data[ss_baselinker][ss_baselinker_use_bl_name]" value="N" />
                        <input id="ss_baselinker_use_bl_name" type="checkbox" name="company_data[ss_baselinker][ss_baselinker_use_bl_name]" value="Y" {if $company_data.ss_baselinker.ss_baselinker_use_bl_name eq 'Y'} checked="checked"{/if}/>
                    </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_use_bl_description != "Y"}
                <div class="control-group">
                    <label class="control-label" for="ss_baselinker_use_bl_description">{__("ss_baselinker_use_bl_description")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_use_bl_description_tooltip)}:</label>
                    <div class="controls">
                        <input type="hidden" name="company_data[ss_baselinker][ss_baselinker_use_bl_description]" value="N" />
                        <input id="ss_baselinker_use_bl_description" type="checkbox" name="company_data[ss_baselinker][ss_baselinker_use_bl_description]" value="Y" {if $company_data.ss_baselinker.ss_baselinker_use_bl_description eq 'Y'} checked="checked"{/if}/>
                    </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_product_language != "Y"}
                {assign var="languages" value=""|fn_ss_baselinker_product_language}
                <div class="control-group">
                   <label class="control-label" for="ss_baselinker_product_language">{__("ss_baselinker_product_language")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_product_language_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_baselinker_product_language]" id="ss_baselinker_product_language">
                           {foreach $languages item="lang_name" key="lang_code"}
                                <option value="{$lang_code}" {if $company_data.ss_baselinker.ss_baselinker_product_language == $lang_code}selected="selected"{/if}>{$lang_name}</option>
                           {/foreach}
                       </select>
                   </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_products_currency != "Y"}
                {assign var="currencies" value=""|fn_ss_baselinker_products_currency_for_vendors}
                <div class="control-group">
                   <label class="control-label" for="ss_baselinker_products_currency">{__("ss_baselinker_products_currency")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_products_currency_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_baselinker_products_currency]" id="ss_baselinker_products_currency">
                           {foreach $currencies item="currency_name" key="currency_id"}
                                <option value="{$currency_id}" {if $company_data.ss_baselinker.ss_baselinker_products_currency == $currency_id}selected="selected"{/if}>{$currency_name}</option>
                           {/foreach}
                       </select>
                   </div>
                </div>
                {/if}
            </div>
            <!-- STOP section ss_baselinker_send_products -->

            <!-- START section ss_baselinker_get_products -->
            {include file="common/subheader.tpl" title=__("ss_baselinker_get_products") target="#ss_baselinker_get_products"}
            <div id="ss_baselinker_get_products" class="in collapse">
                <div class="control-group">
                   <label class="control-label" for="ss_bl_csmv_import_prod_status">{__("ss_bl_csmv_import_prod_status")}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_bl_csmv_import_prod_status]" id="ss_bl_csmv_import_prod_status">
                           <option value="A" {if $company_data.ss_baselinker.ss_bl_csmv_import_prod_status == "A"}selected="selected"{/if}>{__("active")}</option>
                           <option value="D" {if $company_data.ss_baselinker.ss_bl_csmv_import_prod_status == "D"}selected="selected"{/if}>{__("disabled")}</option>
                           <option value="H" {if $company_data.ss_baselinker.ss_bl_csmv_import_prod_status == "H"}selected="selected"{/if}>{__("hidden")}</option>
                       </select>
                   </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="ss_bl_csmv_update_prices">{__("ss_bl_csmv_update_prices")}{include file="common/tooltip.tpl" tooltip=__(ss_bl_csmv_update_prices_tooltip)}:</label>
                    <div class="controls">
                        <input type="hidden" name="company_data[ss_baselinker][ss_bl_csmv_update_prices]" value="N" />
                        <input id="ss_bl_csmv_update_prices" type="checkbox" name="company_data[ss_baselinker][ss_bl_csmv_update_prices]" value="Y" {if $company_data.ss_baselinker.ss_bl_csmv_update_prices eq 'Y'} checked="checked"{/if}/>
                    </div>
                </div>
                {assign var="taxes" value=1|fn_ss_baselinker_ss_bl_csmv_tax_id_get_list}
                <div class="control-group">
                   <label class="control-label" for="ss_bl_csmv_tax_id">{__("ss_bl_csmv_tax_id")}{include file="common/tooltip.tpl" tooltip=__(ss_bl_csmv_tax_id_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_bl_csmv_tax_id]" id="ss_bl_csmv_tax_id">
                       {foreach $taxes item="tax_name" key="tax_id"}
                           <option value="{$tax_id}" {if $company_data.ss_baselinker.ss_bl_csmv_tax_id == $tax_id}selected="selected"{/if}>{$tax_name}</option>
                       {/foreach}
                       </select>
                   </div>
                </div>
                <div class="control-group">
                   <label class="control-label" for="ss_bl_csmv_product_lang">{__("ss_bl_csmv_product_lang")}{include file="common/tooltip.tpl" tooltip=__(ss_bl_csmv_product_lang_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_bl_csmv_product_lang]" id="ss_bl_csmv_product_lang">
                           {foreach $languages item="lang_name" key="lang_code"}
                                <option value="{$lang_code}" {if $company_data.ss_baselinker.ss_bl_csmv_product_lang == $lang_code}selected="selected"{/if}>{$lang_name}</option>
                           {/foreach}
                       </select>
                   </div>
                </div>
            </div>
            <!-- STOP section ss_baselinker_get_products -->

            <!-- START section ss_baselinker_products_codes -->
            <!-- STOP section ss_baselinker_products_codes -->

            <!-- START section ss_baselinker_send_bl -->
            {include file="common/subheader.tpl" title=__("ss_baselinker_send_bl") target="#ss_baselinker_send_bl"}
            <div id="ss_baselinker_send_bl" class="in collapse">
                {if $disallowed_fields_table.ss_baselinker_cod_payment != "Y"}
                <div class="control-group">
                    <label class="control-label" for="is_returnable">{__("ss_baselinker_orders_cod_payment")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_orders_cod_payment_tooltip)}:</label>
                    <div class="controls">
                       {foreach $payments item="payment" key="payment_id"}
                         <label class="checkbox">
                         <input type="checkbox" name="company_data[ss_baselinker][ss_baselinker_cod_payment][]" id="ss_baselinker_cod_payment_{$payment_id}" value="{$payment_id}" {if $company_data.ss_baselinker.ss_baselinker_cod_payment[$payment_id] eq 'Y'} checked="checked"{/if} />{$payment}
                         </label>
                        {/foreach}
                    </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_orders_currency != "Y"}
                <div class="control-group">
                   <label class="control-label" for="ss_baselinker_orders_currency">{__("ss_baselinker_orders_currency")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_orders_currency_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_baselinker_orders_currency]" id="ss_baselinker_orders_currency">
                           {foreach $currencies item="currency_name" key="currency_id"}
                                <option value="{$currency_id}" {if $company_data.ss_baselinker.ss_baselinker_orders_currency == $currency_id}selected="selected"{/if}>{$currency_name}</option>
                           {/foreach}
                       </select>
                   </div>
                </div>
                {/if}
            </div>
            {include file="common/subheader.tpl" title=__("ss_baselinker_get_bl") target="#ss_baselinker_get_bl"}
            <div id="ss_baselinker_get_bl" class="in collapse">
                {if $disallowed_fields_table.ss_baselinker_default_shipping_id != "Y"}
                <div class="control-group">
                   <label class="control-label" for="ss_baselinker_default_shipping_id">{__("ss_baselinker_default_shipping_id")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_default_shipping_id_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_baselinker_default_shipping_id]" id="ss_baselinker_default_shipping_id">
                           {foreach $shipping_list key="shipping_id" item="shipping_data"}
                                <option value="{$shipping_id}" {if $company_data.ss_baselinker.ss_baselinker_default_shipping_id == $shipping_id}selected="selected"{/if}>{$shipping_data.shipping}</option>
                           {/foreach}
                       </select>
                   </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_default_payment_id != "Y"}
                <div class="control-group">
                   <label class="control-label" for="ss_baselinker_default_payment_id">{__("ss_baselinker_default_payment_id")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_default_payment_id_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_baselinker_default_payment_id]" id="ss_baselinker_default_payment_id">
                           {foreach $payment_default key="payment_default_id" item="payment_default_name"}
                                <option value="{$payment_default_id}" {if $company_data.ss_baselinker.ss_baselinker_default_payment_id == $payment_default_id}selected="selected"{/if}>{$payment_default_name}</option>
                           {/foreach}
                       </select>
                   </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_pay_status != "Y"}
                <div class="control-group">
                   <label class="control-label" for="ss_baselinker_pay_status">{__("ss_baselinker_pay_status")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_pay_status_tooltip)}:</label>
                   <div class="controls">
                       <select name="company_data[ss_baselinker][ss_baselinker_pay_status]" id="ss_baselinker_pay_status">
                           {foreach $statuses key="status_id" item="status_name"}
                                <option value="{$status_id}" {if $company_data.ss_baselinker.ss_baselinker_pay_status == $status_id}selected="selected"{/if}>{$status_name}</option>
                           {/foreach}
                        </select>
                   </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_apply_catalog_promotions != "Y"}
                <div class="control-group">
                    <label class="control-label" for="ss_baselinker_apply_catalog_promotions">{__("ss_baselinker_apply_catalog_promotions")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_apply_catalog_promotions_tooltip)}:</label>
                    <div class="controls">
                        <input type="hidden" name="company_data[ss_baselinker][ss_baselinker_apply_catalog_promotions]" value="N" />
                        <input id="ss_baselinker_apply_catalog_promotions" type="checkbox" name="company_data[ss_baselinker][ss_baselinker_apply_catalog_promotions]" value="Y" {if $company_data.ss_baselinker.ss_baselinker_apply_catalog_promotions eq 'Y'} checked="checked"{/if}/>
                    </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_apply_cart_promotions != "Y"}
                <div class="control-group">
                    <label class="control-label" for="ss_baselinker_apply_cart_promotions">{__("ss_baselinker_apply_cart_promotions")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_apply_cart_promotions_tooltip)}:</label>
                    <div class="controls">
                        <input type="hidden" name="company_data[ss_baselinker][ss_baselinker_apply_cart_promotions]" value="N" />
                        <input id="ss_baselinker_apply_cart_promotions" type="checkbox" name="company_data[ss_baselinker][ss_baselinker_apply_cart_promotions]" value="Y" {if $company_data.ss_baselinker.ss_baselinker_apply_cart_promotions eq 'Y'} checked="checked"{/if}/>
                    </div>
                </div>
                {/if}
                {if $disallowed_fields_table.ss_baselinker_update_orders != "Y"}
                <div class="control-group">
                    <label class="control-label" for="ss_baselinker_update_orders">{__("ss_baselinker_update_orders")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_update_orders_tooltip)}:</label>
                    <div class="controls">
                        <input type="hidden" name="company_data[ss_baselinker][ss_baselinker_update_orders]" value="N" />
                        <input id="ss_baselinker_update_orders" type="checkbox" name="company_data[ss_baselinker][ss_baselinker_update_orders]" value="Y" {if $company_data.ss_baselinker.ss_baselinker_update_orders eq 'Y'} checked="checked"{/if}/>
                    </div>
                </div>
                {/if}
            </div>
            <!-- START section ss_baselinker_api -->
            {if $disallowed_fields_table.ss_baselinker_api != "Y"}
                {include file="common/subheader.tpl" title=__("ss_baselinker_api") target="#ss_baselinker_api"}
                <div id="ss_baselinker_api" class="in collapse">
                    <label class="control-label" for="ss_baselinker_token">{__("ss_baselinker_token")}{include file="common/tooltip.tpl" tooltip=__(ss_baselinker_token_tooltip)}:</label>
                    <div class="controls">
                        <textarea id="ss_baselinker_token"
                                  name="company_data[ss_baselinker][ss_baselinker_token]"
                                  cols="55"
                                  rows="3"
                                  class="input-large"
                        >{$company_data.ss_baselinker.ss_baselinker_token}</textarea>
                    </div>
                </div>
            {/if}
            <!-- STOP section ss_baselinker_api -->

            <!-- START section ss_baselinker_logs -->
            {if $disallowed_fields_table.ss_baselinker_logs != "Y"}
                {include file="common/subheader.tpl" title=__("ss_baselinker_logs") target="#ss_baselinker_logs"}
                <div id="ss_baselinker_logs" class="in collapse">
                    {foreach $log_test_link item="link" key="method"}
                    <div class="control-group">
                        <label class="control-label" for="ss_baselinker_logs_{$method}"><a href="{$link}" target="_blank">{__("ss_baselinker_logs_`$method`")}</a>:</label>
                        <div class="controls">
                            <input type="hidden" name="company_data[ss_baselinker][ss_bl_logs_{$method}]" value="N" />
                            <input id="ss_bl_logs_{$method}" type="checkbox" name="company_data[ss_baselinker][ss_bl_logs_{$method}]" value="Y" {if $company_data.ss_baselinker.ss_bl_logs eq 'Y'} checked="checked"{/if}/>
                        </div>
                    </div>
                    {/foreach}
                </div>
            {/if}
            <!-- STOP section ss_baselinker_logs -->
        {else}
            {if $smarty.session.auth.user_type != "A"}
                {__("ss_baselinker_api_no_access")}
            {/if}
        {/if}
    </div>
{/if}