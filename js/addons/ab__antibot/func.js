/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2021   *
* / /_\ | | _____  _| |_/ /_ __ __ _ _ __   __| |_ _ __   __ _   | |_ ___  __ _ _ __ ___   *
* |  _  | |/ _ \ \/ / ___ \ '__/ _` | '_ \ / _` | | '_ \ / _` |  | __/ _ \/ _` | '_ ` _ \  *
* | | | | |  __/>  <| |_/ / | | (_| | | | | (_| | | | | | (_| |  | ||  __/ (_| | | | | | | *
* \_| |_/_|\___/_/\_\____/|_|  \__,_|_| |_|\__,_|_|_| |_|\__, |  \___\___|\__,_|_| |_| |_| *
*                                                         __/ |                            *
*                                                        |___/                             *
* ---------------------------------------------------------------------------------------- *
* This is commercial software, only users who have purchased a valid license and accept    *
* to the terms of the License Agreement can install and use this program.                  *
* ---------------------------------------------------------------------------------------- *
* website: https://cs-cart.alexbranding.com                                                *
*   email: info@alexbranding.com                                                           *
*******************************************************************************************/
(function (_, $) {
$(_.doc).on('click', '.ab-antibot-view:not(.disabled)', function(event, timeout = 0) {
var elm = $(this);
setTimeout(function () {
var view = elm.data('ca-ab-antibot-view');
$('.ab-antibot-view').removeClass('btn-primary');
elm.addClass('btn-primary');
if (view == 'for_real_users'){
$('.device-specific-block.block').removeClass('ab-antibot-hidden');
}else{
$('.device-specific-block.block[data-ca-ab-antibot-view-' + view + '="true"]:not(.hidden)').removeClass('ab-antibot-hidden');
$('.device-specific-block.block[data-ca-ab-antibot-view-' + view + '="false"]:not(.hidden)').addClass('ab-antibot-hidden');
}
}, timeout);
});
$(_.doc).on('click', '.cm-reset-device-availability', function() {
$('.ab-antibot-views').addClass('hidden');
$('.ab-antibot-view').addClass('disabled');
$('.device-specific-block.block').removeClass('ab-antibot-hidden');
});
$(_.doc).on('click', '.cm-switch-device-availability', function() {
$('.ab-antibot-views').removeClass('hidden');
$('.ab-antibot-view').removeClass('disabled');
$('.ab-antibot-view.btn-primary').trigger('click', [200]);
});
})(Tygh, Tygh.$);
