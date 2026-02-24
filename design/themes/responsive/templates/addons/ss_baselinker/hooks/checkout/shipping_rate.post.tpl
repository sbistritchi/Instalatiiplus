{* sprawdzy czy dostawa jest powiązana z mapka z Baselinker *}
{assign var="ss_bl" value=$shipping.shipping_id|fn_ss_bl_get_info_map}
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
    {assign var="ss_bl_shipping_params" value=$shipping.shipping_id|fn_get_shipping_params}
    {if $ss_bl_shipping_params.ss_baselinker_point_type == 'ONLY_COD'}
        {assign var="pointTypesFilter" value="'cod_only'"}
    {else}
        {assign var="pointTypesFilter" value=''}
    {/if}
    {*pokaż mapę *}
        <script type="text/javascript" src="https://furgonetka.pl/js/dist/map/map.js" data-no-defer></script>
        <script type="text/javascript" data-no-defer>
        function callbackFunc_{$group_key}_{$shipping.shipping_id}(properties) {
            url = fn_url('ss_base.save_info_points');
            url += '&' + 'shipping_id=' + '{$shipping.shipping_id}';
            url += '&' + 'company_id=' + '{$group.company_id}';
            url += '&' + 'name=' + properties.name;
            url += '&' + 'code=' + properties.code;
            url += '&' + 'country_code=' + properties.point.country_code;
            url += '&' + 'type=' + properties.point.type;
            Tygh.$.ceAjax('request', url, {
                method: 'get',
                hidden: true,
            });
            console.log(properties);
            var nameArr = properties.name.split(',');
            console.log(nameArr);
            document.getElementById('ss_bl_show_point_' + '{$group.company_id}' + '_' + '{$shipping.shipping_id}').innerHTML = '<div class="bl_point"><div class="bl_point_value">' + nameArr[0] + '<br>' + nameArr[1] + '</div></div>';
            document.getElementById('ss_bl_name_' + '{$group.company_id}' + '_' + '{$shipping.shipping_id}').value = properties.code;
            document.getElementById('ss_bl_show_point_name_' + '{$group.company_id}' + '_' + '{$shipping.shipping_id}').value = properties.name;
        }
        </script>
    <div class="litecheckout__field">
        <a {if $cart.chosen_shipping.$group_key == $shipping.shipping_id}class="ty-btn ty-btn__primary"{else}class="hidden"{/if} href="#" 
            onclick="new window.Furgonetka.Map({
            courierServices: [{$ss_bl.services}],
            city: '{$ss_bl_city}',
            street: '{$ss_bl_address}',
            mapBounds: 'eu',
            pointTypesFilter:[{$pointTypesFilter nofilter}],
            callback: callbackFunc_{$group_key}_{$shipping.shipping_id}
            }).show(); return false;">{__("ss_bl_button_description")}
        </a>
        {assign var="company_id" value=$group.company_id}
        {assign var="shipping_id" value=$shipping.shipping_id}
        {if $cart.chosen_shipping.$group_key == $shipping.shipping_id}
            <label class="cm-required" for="ss_bl_show_point_name_{$group.company_id}_{$shipping.shipping_id}"></label>
            <input class="hidden" type="text" value="{if $smarty.session.ss_bl.$company_id.$shipping_id.name}{$smarty.session.ss_bl.$company_id.$shipping_id.name}{/if}" id="ss_bl_show_point_name_{$group.company_id}_{$shipping.shipping_id}" name="ss_bl_show_point_name_{$group.company_id}_{$shipping.shipping_id}">
        {/if}
        <span {if $cart.chosen_shipping.$group_key == $shipping.shipping_id}class=""{else}class="hidden"{/if} id="ss_bl_show_point_{$group.company_id}_{$shipping.shipping_id}" name="ss_bl_show_point_{$group.company_id}_{$shipping.shipping_id}">
            {if $smarty.session.ss_bl.$company_id.$shipping_id.name}
            <div class="bl_point">
                <div class="bl_point_value">
                    {$smarty.session.ss_bl.$company_id.$shipping_id.code}, {$smarty.session.ss_bl.$company_id.$shipping_id.name}
                </div>
            </div>
            {/if}
        </span>
        <input type='hidden' id="ss_bl_name_{$group.company_id}_{$shipping.shipping_id}" name='ss_bl_point[{$group.company_id}][{$shipping.shipping_id}][name]' value='' />
    </div>
{/if}