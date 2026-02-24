{if $product_groups}
    {foreach from=$product_groups key=group_key item=group}
        {if $group.shippings && !$group.shipping_no_required}
            <div class="controls">
				{* sprawdzy czy dostawa jest powiązana z mapką z Baselinker *}
				{assign var="ss_bl" value=$cart.chosen_shipping.$group_key|fn_ss_bl_get_info_map}
				{if $ss_bl.show_map eq "Y"}
				    {* ss_bl *}
				    {if $cart.user_data.s_address}
				        {assign var="ss_bl_address" value=$cart.user_data.s_address}
				    {elseif $cart.user_data.b_address}
				        {assign var="ss_bl_address" value=$cart.user_data.b_address}
				    {else}
				        {assign var="ss_bl_address" value=""}
				    {/if}
				    {if $cart.user_data.s_city}
				        {assign var="ss_bl_city" value=$cart.user_data.s_city}
				    {elseif $cart.user_data.b_city}
				        {assign var="ss_bl_city" value=$cart.user_data.b_city}
				    {else}
				        {assign var="ss_bl_city" value=""}
				    {/if}
				    {* zwróć parametry potrzebne dla stworzenie dodatkowych parametów wysyłki *}
				    {assign var="ss_bl_shipping_params" value=$cart.chosen_shipping.$group_key|fn_get_shipping_params}
				    {if $ss_bl_shipping_params.ss_baselinker_point_type == 'ONLY_COD'}
				        {assign var="pointTypesFilter" value="'cod_only'"}
				    {else}
				        {assign var="pointTypesFilter" value=''}
				    {/if}
				    {*pokaż mapę *}
			        <script type="text/javascript" src="https://furgonetka.pl/js/dist/map/map.js" data-no-defer></script>
			        <script type="text/javascript" data-no-defer>
			        function ss_bl_callbackFunc_{$group_key}_{$cart.chosen_shipping.$group_key}(properties) {
			            url = fn_url('ss_base.save_info_points');
			            url += '&' + 'shipping_id=' + '{$cart.chosen_shipping.$group_key}';
			            url += '&' + 'company_id=' + '{$group.company_id}';
			            url += '&' + 'name=' + properties.name;
			            url += '&' + 'code=' + properties.code;
			            url += '&' + 'country_code=' + properties.point.country_code;
			            url += '&' + 'type=' + properties.point.type;
			            Tygh.$.ceAjax('request', url, {
			                method: 'get',
			                hidden: true,
			            });
                        console.log('{$cart.chosen_shipping.$group_key}');
			            console.log(properties);
			            var nameArr = properties.name.split(',');
			            console.log(nameArr);
			            document.getElementById('ss_bl_show_point_' + '{$group.company_id}' + '_' + '{$cart.chosen_shipping.$group_key}').innerHTML = '<div class="bl_point"><div class="bl_point_value">' + nameArr[0] + '<br>' + nameArr[1] + '</div></div>';
			            document.getElementById('ss_bl_name_' + '{$group.company_id}' + '_' + '{$cart.chosen_shipping.$group_key}').value = properties.code;
			            document.getElementById('ss_bl_show_point_name_' + '{$group.company_id}' + '_' + '{$cart.chosen_shipping.$group_key}').value = properties.name;
			        }
			        </script>
                    <a class="btn  btn-primary" href="#"
                         onclick="new window.Furgonetka.Map({
                         courierServices: [{$ss_bl.services}],
                         city: '{$ss_bl_city}',
                         street: '{$ss_bl_address}',
                         mapBounds: 'eu',
                         pointTypesFilter:[{$pointTypesFilter nofilter}],
                         callback: ss_bl_callbackFunc_{$group_key}_{$cart.chosen_shipping.$group_key}
                         }).show(); return false;">{__("ss_bl_button_description")}
                    </a>
                    {assign var="company_id" value=$group.company_id}
                    <label for="ss_bl_show_point_name_{$group.company_id}_{$cart.chosen_shipping.$group_key}"></label>
                    <input class="hidden" type="text" value="{if $smarty.session.ss_bl.$company_id.name}{$smarty.session.ss_bl.$company_id.name}{/if}" id="ss_bl_show_point_name_{$group.company_id}_{$cart.chosen_shipping.$group_key}" name="ss_bl_show_point_name_{$group.company_id}_{$cart.chosen_shipping.$group_key}">
                       
			        <span id="ss_bl_show_point_{$group.company_id}_{$cart.chosen_shipping.$group_key}" name="ss_bl_show_point_{$group.company_id}_{$cart.chosen_shipping.$group_key}">
			            {if $smarty.session.ss_bl.$company_id.$shipping_id.name}
			                <div class="bl_point">
			                    <div class="bl_point_value">
			                        {$smarty.session.ss_bl.$company_id.$shipping_id.code}, {$smarty.session.ss_bl.$company_id.$shipping_id.name}
			                    </div>
			                </div>
			            {/if}
			        </span>
			        <input type='hidden' id="ss_bl_name_{$group.company_id}_{$cart.chosen_shipping.$group_key}" name='ss_bl_point[{$group.company_id}][{$cart.chosen_shipping.$group_key}][name]' value='' />
			        <span style="color:red;font-weight:bold" id="ss_bl_point_delivery">  </span>
				{/if}
            </div>
        {elseif $group.shipping_no_required}
            {__("no_shipping_required")}
        {else}
            {__("text_no_shipping_methods")}
            {assign var="is_empty_rates" value="Y"}
        {/if}
    {/foreach}
{/if}