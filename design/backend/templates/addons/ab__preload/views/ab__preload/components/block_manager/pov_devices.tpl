{$devices = $option.devices|default:['desktop', 'tablet', 'mobile']}
{$default_value = $option.default_value|default:15}
{$icons = [
"desktop" => "icon-desktop",
"mobile" => "icon-mobile-phone",
"tablet" => "icon-tablet"
]}
{include file="common/subheader.tpl" meta="" title=__("ab__p.expert_settings") target="#ab__p_expert_settings"}
<div id="ab__p_expert_settings" class="collapse">
<div class="control-group">
<label class="control-label" style="margin-top: 23px;">{__("ab__p.pov")}:</label>
<div class="controls">
<table>
<thead>
<tr>
{foreach $devices as $device}
{$tr = "ab__p.pov_`$device`"}
<th><label for="pov_{$device}"><i class="{$icons.$device}"></i> {__($tr)}</th>
{/foreach}
</tr>
</thead>
<tbody>
<tr>
{foreach $devices as $device}
{$elem = "pov_`$device`"}
<td>
<input id="pov_{$device}" name="block_data[properties][{$elem}]" type="text" class="input-medium" value="{$block.properties.$elem|default:$default_value}">
</td>
{/foreach}
</tr>
</tbody>
</table>
</div>
</div>
{* <h4>
{__("ab__p.examples_description")}
</h4>
<a href="design/backend/media/images/addons/ab__preload/examples/mobile_1_ru.jpg" target="_blank"><img src="design/backend/media/images/addons/ab__preload/examples/mobile_1_ru.jpg" style="height:197px;border: 3px solid gray;" alt=""></a>
<a href="design/backend/media/images/addons/ab__preload/examples/pc_1_ru.jpg" target="_blank"><img src="design/backend/media/images/addons/ab__preload/examples/pc_1_ru.jpg" style="height:197px;border: 3px solid gray;" alt=""></a>
<a href="design/backend/media/images/addons/ab__preload/examples/pc_2_ru.jpg" target="_blank"><img src="design/backend/media/images/addons/ab__preload/examples/pc_2_ru.jpg" style="height:197px;border: 3px solid gray;" alt=""></a>*}
</div>
<hr>