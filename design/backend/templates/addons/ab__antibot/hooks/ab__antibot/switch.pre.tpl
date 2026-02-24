{$ab__antibot_views = [
"for_real_users" => [
"name" => __("ab__ab.view_layout.for_real_users"),
"btn_class" => "btn btn-primary"
],
"for_white_bots" => [
"name" => __("ab__ab.view_layout.for_white_bots"),
"btn_class" => "btn"
],
"for_black_and_other_bots" => [
"name" => __("ab__ab.view_layout.for_black_and_other_bots"),
"btn_class" => "btn"
]
]}
<div class="ab-antibot-views mobile-hidden hidden" id="ab__antibot_views">
<span>{__("ab__ab.view_layout")}</span>
<div class="clearfix"></div>
<div class="btn-group ab-antibot-views-switch">
{foreach $ab__antibot_views as $ab__antibot_view_id => $ab__antibot_view}
{btn type="text"
text=$ab__antibot_view.name
raw=true
class="ab-antibot-view disabled {$ab__antibot_view.btn_class}"
data=["data-ca-ab-antibot-view" => $ab__antibot_view_id]
}
{/foreach}
</div>
<!--ab__antibot_views--></div>
