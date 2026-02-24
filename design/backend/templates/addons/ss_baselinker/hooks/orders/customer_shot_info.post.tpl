{assign var="ss_bl_point" value=$smarty.request.order_id|fn_ss_bl_get_point_from_order}
{if $ss_bl_point|is_array}
    <span style="color:red;font-weight:bold"> {__("ss_bl_point_receive")}:</span>
    <br>
    <strong>{__("ss_bl_point_name")}</strong>: {$ss_bl_point.name}<br>
    <strong>{__("ss_bl_point_code")}</strong>: {$ss_bl_point.code}<br>
    <strong>{__("ss_bl_point_type")}</strong>: {$ss_bl_point.type}<br>
    <strong>{__("ss_bl_point_country_code")}</strong>: {$ss_bl_point.country_code}<br>
{/if}