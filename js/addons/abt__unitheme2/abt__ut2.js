/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2024   *
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
function fn_abt__ut2_calc_cell(context){
if (fn_abt__ut2_calc_cell.timers === undefined) {
fn_abt__ut2_calc_cell.timers = [];
}
context.each((k,elem) => {
if (fn_abt__ut2_calc_cell.timers[elem]) {
clearTimeout(fn_abt__ut2_calc_cell.timers[elem]);
}
fn_abt__ut2_calc_cell.timers[elem] = setTimeout(fn_abt__ut2_calc_cell_execute, 100, $(elem));
})
}
function fn_abt__ut2_calc_cell_execute(context){
const [ctx, iteration = 0] = arguments;
$('div.grid-list:visible', context).each(function(){
var cell = $(this).find('[class*="ty-column"][data-ut2-grid="first-item"] > [class*="ut2-gl__item"]');
const height = cell.outerHeight(), width = cell.outerWidth();
if (height === 0 && iteration < 3) {
setTimeout(() => fn_abt__ut2_calc_cell(ctx, iteration + 1), 300)
return
}
$(this).css('--gl-item-height', height).css('--gl-item-width', width);
$('html').addClass('ut2-gl-complite');
});
}
(function(_, $) {

$(document).ready(function () {
fn_abt__ut2_calc_cell($(document));
$.ceEvent('on', 'ce.commoninit', function(context) {
fn_abt__ut2_calc_cell(context);
});
$.ceEvent('on', 'ce.tab.show', function(tab_id, tabs_elm) {
fn_abt__ut2_calc_cell(tabs_elm.parent());
});
$(window).on('resize.global', function (event) {
fn_abt__ut2_calc_cell($(document));
fn__fixStickySidebar();
});
fn__fixStickySidebar();
$(document).on('click.global', function(event) {
let $click_target = $(event.target);
if (_.abt__ut2.device === 'desktop' && window.matchMedia('(max-width: 775px)').matches) {
if (! $click_target.closest('.ut2__horizontal-product-filters-dropdown').length ) {
$('.ty-horizontal-product-filters-dropdown__wrapper.open').trigger('click');
}
}
});
function mmqMobile_statusChanges(mmq) {
if (mmq.matches) {
$(document).on('click.toggle_cvv2_info', '.ty-cvv2-about__title', toggleCvv2Info);
} else {
if ($('.ty-cvv2-about__title').length > 0) {
$('.ty-cvv2-about__title').removeClass('js-state--payment-card-cvv2_-opened');
}
$(document).off('click.toggle_cvv2_info');
}
}
window.g_mmq__mobile.addListener(mmqMobile_statusChanges);
mmqMobile_statusChanges(window.g_mmq__mobile);
$(document).on('click.copy_sku', '.ty-sku-item .ut2_copy', function () {
window.g_fn__copySkuTextToClipboard($(this).find('.ut2--sku-text'));
});

});


function fn__fixStickySidebar() {
let el__product_card_sidebar = document.querySelector('.ut2-pb__right, .ut2-pb__right-wrap');
if (_.abt__ut2.device !== 'mobile' && !window.g_mmq__mobile.matches && $(el__product_card_sidebar).length) {
let product_card_sidebar_height = $(el__product_card_sidebar).outerHeight();
let product_card_sidebar_sticky_top = parseInt(getComputedStyle(document.documentElement).getPropertyValue('--gap-s'));
let $header = $('#tygh_main_container > .tygh-header > .header-grid');
let sticky_header_elem_height = 0;
let $spt_sticky_nav = $('.ab-spt-floating-position-after_h1');
let spt_sticky_nav_height = 0;
if ($('html').hasClass('sticky-top-panel')) {
if ($header.is('.advanced-header')) {
sticky_header_elem_height = $header.children('.top-menu-grid').outerHeight();
} else if ($header.is('.default-header')) {
sticky_header_elem_height = $header.children('.container-fluid-row:first-child').outerHeight();
} else if ($header.is('.light-header')) {
sticky_header_elem_height = $header.find('.top-menu-grid:not(.second-header-grid)').outerHeight();
}
product_card_sidebar_sticky_top = product_card_sidebar_sticky_top + sticky_header_elem_height;
}
if ($spt_sticky_nav.length) {
spt_sticky_nav_height = $spt_sticky_nav.outerHeight();
product_card_sidebar_sticky_top = product_card_sidebar_sticky_top + spt_sticky_nav_height;
}
if (product_card_sidebar_height + product_card_sidebar_sticky_top > document.documentElement.clientHeight) {
$(el__product_card_sidebar).addClass('js-mode--sticky-off');
$(el__product_card_sidebar).css("top", "unset");
} else {
$(el__product_card_sidebar).removeClass('js-mode--sticky-off');
$(el__product_card_sidebar).css("top", product_card_sidebar_sticky_top + 'px');
}
}
}


window.g_fn__copySkuTextToClipboard = function ($copied) {
if ($copied.length > 0) {
const el__copied = $copied.get(0);
let cleaned_text;
cleaned_text = el__copied.textContent || el__copied.innerText || "";
cleaned_text = cleaned_text.replace(/\r?\n|\r/g, '').trim();
if (cleaned_text) {
if ('clipboard' in navigator) {
navigator.clipboard.writeText(cleaned_text).then(() => {
openCopySuccessedAlert();
}).catch((err) => {
copyTextViaExecCommand();
});
} else {
copyTextViaExecCommand();
}
} else {
openCopyFailedAlert();
}
function copyTextViaExecCommand() {
const $utility_temp_input = $('<input type="text" readonly style="position:fixed !important; inset-inline-start:-200vw !important; inset-block-start:-200vh !important; border:0 none; padding:unset; min-width:unset; width:1px !important; min-height:unset; height:1px !important;" />');
let flag__copy_status = false;
$('body').append($utility_temp_input);
$utility_temp_input.val(cleaned_text).select();
try {
if (document.execCommand("copy")) {
flag__copy_status = true;
} else {
flag__copy_status = false;
}
} catch (err) {
flag__copy_status = false;
}
$utility_temp_input.remove();
if (flag__copy_status) {
openCopySuccessedAlert();
} else {
openCopyFailedAlert();
}
}
} else {
openCopyFailedAlert();
}
function openCopySuccessedAlert() {
$.ceNotification('show', {
title: '',
message: '<div class="js-ins--notif-content-_sku-copied">' + _.tr('abt__ut2__sku_copy_status_success') + '<div>',
type: 'N',
message_state: 'I'
});
}
function openCopyFailedAlert() {
$.ceNotification('show', {
title: '',
message: '<div class="js-ins--notif-content-_sku-copied">' + _.tr('abt__ut2__sku_copy_status_fail') + '<div>',
type: 'E',
message_state: 'I'
});
}
}


function toggleCvv2Info() {
$payment_card_cvv2_btn = $(this);
if ($payment_card_cvv2_btn.length > 0) {
$payment_card_cvv2_btn.toggleClass('js-state--payment-card-cvv2_-opened', !$payment_card_cvv2_btn.hasClass('js-state--payment-card-cvv2_-opened'));
}
}


const toggleNoScroll = (flag) =>{
setTimeout(()=>{
let enableNoScroll = flag || $('.cm-abt--ut2-toggle-scroll[id^="off_"]:visible').length > 0;
if (enableNoScroll) {
$('body').data('scroll-top', window.pageYOffset);
}
$('html').toggleClass('no-scroll', enableNoScroll);
if ($('.ut2-sp-n').hasClass('open') && enableNoScroll) {
$('body').addClass('fly-menu');
} else {
$('body').removeClass('fly-menu');
}
if (!enableNoScroll) {
let scrollTop = $('body').data('scroll-top');
window.scroll(0, scrollTop);
}
}, 0);
}

$(document).ready(function() {
$.extend(_.abt__ut2, {
functions: {
toggleNoScroll: toggleNoScroll,
in_array: function (val, arr) {
var answ = 0;
if (Array.isArray(arr)) {
answ = ~arr.indexOf(val);
} else {
answ = ~Object.keys(arr).indexOf(val);
}
return Boolean(answ);
},
detect_class_changes: function (elem, callback, add_old_val) {
var vanilla_elem = elem[0];
var observer = new MutationObserver(callback);
observer.observe(vanilla_elem, {
attributes: true,
attributeOldValue: add_old_val || false,
attributeFilter: ['class']
});
},
toggle_class_on_scrolling: function (element_to_manipulate, element_to_add_class, class_name, add_to_offset, conditions) {
var additional_offset = add_to_offset;
if (_.abt__ut2.settings.general.top_sticky_panel.enable[_.abt__ut2.device] === 'Y') {
additional_offset += $('.top-menu-grid').outerHeight();
}
$(window).on('scroll resize', function () {
var scroll_top = $(window).scrollTop() - additional_offset;
var scroll_bot = scroll_top + window.innerHeight;
var element_coords = element_to_manipulate.offset();
element_coords.bottom = element_coords.top + element_to_manipulate.outerHeight();
if (scroll_bot >= element_coords.bottom) {
if (conditions != void(0) && typeof conditions.add === 'function' && !conditions.add())
return false;
element_to_add_class.addClass(class_name);
} else {
if (conditions != void(0) && typeof conditions.remove === 'function' && !conditions.remove())
return false;
element_to_add_class.removeClass(class_name);
}
});
}
}
});
if (_.abt__ut2.settings.general.top_sticky_panel.enable[_.abt__ut2.device] === 'Y') {

$('body').data('ca-scroll-to-elm-offset', 70);
}
if (_.abt__ut2.controller === 'checkout' && _.abt__ut2.mode === 'cart') {
$('.ty-dropdown-box__title:not(.open)').addClass('__cart-page');
}
if (location.pathname !== '/'){
let menuItemClases = ':is(.ty-menu__items, .ty-text-links)',
menuElemClases = '.ty-menu__submenu-item-header, .ty-menu__submenu-item, .ty-text-links__item',
activeElem = $(menuItemClases +' a[href$="'+location.pathname+'"]');
if(activeElem.length){
activeElem.parentsUntil(menuItemClases, menuElemClases).addClass('active');
activeElem.parentsUntil(menuItemClases,'.second-lvl').find('.ty-menu__submenu-item-header').addClass('active');
activeElem.parentsUntil(menuItemClases,'.ty-menu__item').find('.a-first-lvl').addClass('active');
}
}
});
$(document).ready(function(){
let ENABLE_STICKY_HEADER_PANEL = _.abt__ut2.settings.general.top_sticky_panel.enable[_.abt__ut2.device] === 'Y',
ENABLE_STICKY_PANEL = _.abt__ut2.settings.general.sticky_panel.enable_sticky_panel[_.abt__ut2.device] === 'Y',
ENABLE_STICKY_FC_PANEL = _.abt__ut2.settings.category.show_sticky_panel_filters_and_categories[_.abt__ut2.device] === 'Y';
var header_selector = '#tygh_main_container > .tygh-header > .header-grid';
var top_panel = $('#tygh_main_container > .tygh-top-panel'),
header = $(header_selector),
menu = $('.second-header-grid'),
search = $('.search-grid'),
b = $('body'),
h = $('.header-grid'),
t = $('.tygh-header'),
top_panel_height = top_panel.height() || 0,
menu_height = menu.height() || 0,
search_height = search.outerHeight(),
breadcrumbs_height = $('.ty-breadcrumbs').outerHeight(),
height = header.outerHeight();
$(':root').css({
'--top-height': `${top_panel_height}px`,
'--header-height': `${height}px`,
'--menu-height': `${menu_height}px`,
'--bc-height' : `${breadcrumbs_height}px`
});
if(ENABLE_STICKY_HEADER_PANEL){
var fixed = 'fixed-header';
}
if(ENABLE_STICKY_PANEL) {
var sticky = 'sticky-panel';
}
if(ENABLE_STICKY_FC_PANEL) {
var fc_sticky = 'sticky-fc-panel';
}
if (h.hasClass('advanced-header')) {
t.addClass('advanced_header');
}
if (h.hasClass('default-header')) {
t.addClass('default_header');
}
if (h.hasClass('light-header')) {
t.addClass('light_header');
}
if (h.hasClass('v2')) {
t.addClass('v2');
}
if(ENABLE_STICKY_HEADER_PANEL || ENABLE_STICKY_PANEL || ENABLE_STICKY_FC_PANEL){
$(window).on('resize scroll', function(e) {
var scroll = $(window).scrollTop();
if(ENABLE_STICKY_FC_PANEL) {
if (scroll > (top_panel_height + height) && !b.hasClass(fc_sticky)) {
b.addClass(fc_sticky);
} else if (scroll < (top_panel_height + height) && b.hasClass(fc_sticky)) {
b.removeClass(fc_sticky);
}
}
if(ENABLE_STICKY_HEADER_PANEL) {

if (h.hasClass('advanced-header')) {
if (Math.floor(scroll) >= (top_panel_height + height) && !b.hasClass(fixed)) {
b.addClass(fixed);
b.css('padding-top', (height - menu_height));
} else if (Math.floor(scroll) < (top_panel_height + (height - menu_height))) {
b.removeClass(fixed);
b.css('padding-top', 0);
}
}

if (h.hasClass('default-header')) {
if (document.documentElement.clientWidth > 768) {
if (Math.floor(scroll) > (top_panel_height + menu_height)) {
b.addClass(fixed);
} else {
b.removeClass(fixed);
}
} else {
if (Math.floor(scroll) > (height + top_panel_height)) {
b.addClass(fixed);
b.css('padding-top', height);
} else {
b.removeClass(fixed);
b.css('padding-top', 0);
}
}
}

if (h.hasClass('light-header') && top_panel_height >= 0) {
if (Math.floor(scroll) >= (height - top_panel_height)) {
b.addClass(fixed);
} else {
b.removeClass(fixed);
}
}
}
if (ENABLE_STICKY_PANEL && !(_.abt__ut2.controller === 'checkout' && _.abt__ut2.mode === 'checkout')) {
let scroll_distance_to_toggle_bottom_sticky_panel = top_panel_height > 0 ? top_panel_height : 34;
if (Math.floor(scroll) >= scroll_distance_to_toggle_bottom_sticky_panel && !b.hasClass(sticky)) {
b.addClass(sticky);
} else if (Math.floor(scroll) < scroll_distance_to_toggle_bottom_sticky_panel && b.hasClass(sticky)) {
b.removeClass(sticky);
}
}
const bcHeightOld = $(':root').css('--bc-height');
const bcHeightNew = ($('.ty-breadcrumbs').outerHeight() || 0) +'px';
if (bcHeightNew !== bcHeightOld) $(':root').css('--bc-height', bcHeightNew);
});
}
});
let observer = false;
const initPanelHiding = $.debounce(function(){
let intersectElements = $(document).find('.ut2-pb__button.ty-product-block__button .ty-btn__add-to-cart');
if(intersectElements.length){
if(observer){
intersectElements.each((index,button) => {
observer.unobserve(button)
})
}
if (document.documentElement.clientWidth < 900) {
observer = new IntersectionObserver((entries) => {
entries.forEach((entry) => {
let hideStickyAddToCart = Boolean(entry.target.classList.contains('ty-btn__add-to-cart') && (entry.isIntersecting || entry.isVisible));
$('.ut2-pb__sticky_add_to_cart').toggleClass('hidden', hideStickyAddToCart);
$('body').toggleClass('sticky-add-to-cart', !hideStickyAddToCart);
})
}, {});
intersectElements.each((index, button) => {
observer.observe(button)
})
}
}
}, 800);
function initStickyAddToCart(){
const stickyBtn = $('#ut2_pb__sticky_add_to_cart');
if (!stickyBtn.length) return;
const stickyBtnDocked = $('.ut2-sticky-panel__wrap .ut2-pb__sticky_add_to_cart');
if(stickyBtnDocked.get(0) !== stickyBtn.get(0)) {
stickyBtnDocked.replaceWith(stickyBtn.show()).get(0) || stickyBtn.prependTo('.ut2-sticky-panel__wrap').show();
}
initPanelHiding();
}
$.ceEvent('on', 'ce.commoninit', function(context) {
initStickyAddToCart();
let load_more_buttons = context.find('.load-more-btn');
if (load_more_buttons.length) {
$.getScript('js/addons/abt__unitheme2/components/block_load_more.js', function(){
load_more_buttons.each(function(){
this.onclick = function(){ window.ut2_load_products(this) };
});
});
}
let subscribeFooterForm = $('.ty-footer-form-block__input.cm-block-add-subscribe');
subscribeFooterForm.closest('form').on('submit', () => {
let emailErrorMessageF = $('.help-inline', subscribeFooterForm);
if (emailErrorMessageF.length) {
emailErrorMessageF.parent().append(emailErrorMessageF);
}
});
});
$.ceEvent('on', 'ce.abt__ut2_before_ajax_request', function(arguments){
let params = arguments[2];
if(params.method === 'get' &&
(
arguments[1].indexOf('block_manager.render') !== -1
||
arguments[1].indexOf('abt__ut2_load_blocks.get_block_content') !== -1
)
){
arguments[2].data = { ...arguments[2].data,
abt__ut2_initial_request:_.abt__ut2.request,
abt__ut2_assign_data:_.abt__ut2.assign_data
};
}
if(arguments[1].indexOf('geo_maps.shipping_estimation') !== -1){
arguments[2].pre_processing = function(data,params){
let product_id = params.data.product_id,
key = 'geo_maps_shipping_methods_list_' + product_id,
key_overload = key + '_overload .ty-geo-maps-shipping__popup';
if(data.html[key] !== undefined){
$('#' + key_overload)?.replaceWith(data.html[key]);
$.ceDialog('get_last')?.ceDialog('resize')
}
}
}
});
$(document).ready(function () {
if (document.documentElement.clientWidth > 768) {
var m = $('.hpo-menu');
if (m.length) {
var menu_height = m.height();
m.addClass('open-menu').find('.ty-dropdown-box__title:first').addClass('open');
var last_first_level_item = m.find('li.ty-menu__item.first-lvl.last');
var m_height = parseInt(last_first_level_item.offset().top + last_first_level_item.height());
var fixed_header = function() {
var scroll = $(window).scrollTop();
var top_panel = $('#tygh_main_container > .tygh-top-panel'),
top_panel_height = top_panel.height();
if (scroll >= m_height) {
$('.hpo-menu').removeClass('open-menu');
$('.hpo-menu > .ty-dropdown-box__title').removeClass('open');
} else {
$('body').removeClass('fixed-header').css('padding-top', '');
$('.hpo-menu').addClass('open-menu');
$('.hpo-menu > .ty-dropdown-box__title').addClass('open');
}
};
fixed_header();
$(window).scroll( fixed_header );
}
} else {
$('.ty-menu__item-link[href="javascript:void(0)"]').click(function() {
var link = $(this);
var toggler = link.prev();
if (toggler.length && toggler.hasClass('ty-menu__item-toggle')) {
toggler.click();
}
});
}
(function() {
if (_.abt__ut2.settings.products.view.show_sticky_add_to_cart[_.abt__ut2.device] === 'Y' && (_.abt__ut2.controller === 'products' && _.abt__ut2.mode === 'view') && $('.ty-product-block.sticky_add_to_cart').length) {
$('.menu-grid .ty-dropdown-box__title').on('click', function () {
var buttons = $('.ut2-pb__sticky_add_to_cart');
if (!buttons.hasClass('by_scroll')) {
buttons.toggleClass('hide_add_to_cart');
} else {
setTimeout(function () {
$(window).trigger('scroll');
}, 100);
}
});
}
})();
$('.ut2-pb.ut2-pb-mobile').on( "accordionbeforeactivate", function( event, { newHeader } ) {
newHeader?.parent().get(0).scrollIntoView({ behavior: 'instant', block: 'start' });
});
});
document.querySelectorAll('.ut2-h__menu .ty-menu__item').forEach(item => {
item.onmouseenter = function() {
var submenu = item.getElementsByClassName('ty-menu__submenu-items')[0];
if (submenu !== undefined) {
var t = 300;
submenu.style.display = 'none';
setTimeout(function () {
submenu.style.display = '';
}, t);
}
}
});
(function() {
var clicks_counter = 0;
$.ceEvent('on', 'dispatch_event_pre', function (e, jelm, processed) {
if (e.type === 'click') {


if (jelm.hasClass('cm-external-trigger') || jelm.parent('.cm-external-trigger').length) {
Array.from(document.getElementsByClassName('cm-external-triggered'), e =>{
document.getElementById('sw_'+e.closest('.cm-popup-box')?.id)?.click()
e.click();
}
);
}
}
});
}());
function ajaxDecorator(f) {
return function () {
let [method] = arguments;
if (method === 'request') {
$.ceEvent('trigger', 'ce.abt__ut2_before_ajax_request', [arguments]);
}
return f.apply(this, arguments);
}
}
$.ceAjax = ajaxDecorator($.ceAjax);
$.tools?.tooltip.addEffect('abtip', function(done){
const tip = this.getTip();
const conf = this.getConf();
if (_.abt__ut2.device !== 'desktop') {
toggleNoScroll(true);
if (!tip.has('.tooltip-content').length) {
tip.find('.tooltip-arrow').remove();
tip.removeClass('tooltip').addClass('ut2-tooltip')
.wrapInner(`<div class="tooltip-content"></div>`)
.wrapInner(`<div class="tooltip-wrap"></div>`)
.find('.tooltip-wrap')
.prepend($(`<span class="ut2-btn-close"><i class="ut2-icon-baseline-close esc" ></i></span>`)
.on('click', () => this.hide()));
}
}
tip.removeClass('hidden')
.fadeTo(conf.fadeInSpeed, conf.opacity, () => done())
.find('.tooltip-wrap')
.addClass('show');
}, function (done) {
if (_.abt__ut2.device !== 'desktop') {
toggleNoScroll(false);
this.getTip().addClass('hidden').find('.tooltip-wrap').removeClass('show');
}
this.getTip().hide();
done.call();
})
function tooltipDecorator(fn) {
return function () {
if (_.abt__ut2.settings.general.mobile_tooltip !== 'Y') return fn.apply(this, arguments)
if ((this.closest('[data-ca-dispatch],[href],.ab-hm-first-level-toggler').length) && _.abt__ut2.device !== 'desktop')
return fn.apply(this, [{
onShow() {
this.getTip().hide();
}
}, ...arguments]);
if (this.hasClass('ty-product-filters__tooltip')) return fn.apply(this, arguments);
if (!this.attr('id')?.startsWith('gdpr')) fn.apply(this, [{effect: 'abtip'}, ...arguments]);
if (_.abt__ut2.device === 'desktop') return fn.apply(this, arguments);
this.on('touchstart', function () {
const checkbox = $(this).find('input[type="checkbox"]');
checkbox.prop('checked', !checkbox.prop('checked'));
})
const $gdpr_tip = $(`#gdpr_tooltip_` + this.attr('id'));
const gdpr_tooltip = fn.apply(this, [{tip: $gdpr_tip.get(), effect: 'abtip'}], ...arguments);
$gdpr_tip.removeClass()
.addClass('ut2-tooltip hidden')
.children(':not(div)')
.remove();
$gdpr_tip.children()
.removeClass()
.addClass('tooltip-wrap')
.wrapInner(`<div class="tooltip-content"></div>`)
.prepend($(`<span class="ut2-btn-close"><i class="ut2-icon-baseline-close esc" ></i></span>`)
.on('click', () => this.data('tooltip').hide()));
return gdpr_tooltip;
}
}
$.fn.ceTooltip = tooltipDecorator($.fn.ceTooltip)
$(_.doc).on('ce:combination:switch', function(event, container, flag){
let p = container.parent();
if(p.hasClass('cm-abt--ut2-move-bottom')){
let c = p[0].classList;
c.remove('cm-abt--ut2-move-bottom', 'ty-dropdown-box', 'ty-dropdown-box2');
$('#tygh_main_container').append(container);
container.wrap("<div class='ut2-dropdown-outside-position " + c +"'></div>");
}
if (container.is('.cm-smart-position-h:visible') || container.closest('.top-grid').length) {
const id = container.attr('id');
const isRtl = document.dir === 'rtl';
const dir = isRtl ? 'right' : 'left';
const within = container.parentsUntil('.container-fluid-row').last()
container.position({
within:within.get(0),
my: `${dir} top`,
at: `${dir} bottom`,
collision: 'fit',
of: $(`#sw_${id}, #on_${id}`).get(0)
});
const tipLeft = parseInt(container.css('left')) || 'auto';
container.css({
top: '',
'--tip-left': isRtl ? 'auto' : -1 * tipLeft + 'px',
'--tip-right': isRtl ? -1 * tipLeft + 'px' : 'auto',
});
}
})
$(_.doc).on('ce:combination:switch', '.cm-abt--ut2-toggle-scroll', function (event, container, flag) {
let containerId = container[0].id;
container[0].classList.toggle('hidden', flag);
if (flag && event.target.id.startsWith('off_')){
const targetId = event.target.id.replace('off_','sw_')
_.doc.getElementById(targetId)?.classList.remove('open');
}
if (_.abt__ut2.device !== 'desktop') {
$(container).removeAttr('style');
(flag) ? $(container).removeClass('container-opened') : $(container).addClass('container-opened');
let filtersContainer = event.target.closest('.top-sticky-panel__filters');
if (filtersContainer) {
let {top} = filtersContainer.getBoundingClientRect();
let transform = !flag ? 'translateY('+ -top +'px)' : '';
let zIndex = !flag ? 1005 : '';
container.css('transform', transform);
$('html').css('--mra-top', -top + 'px');
$(filtersContainer).css('z-index', zIndex);
}
}
toggleNoScroll(!flag);
return true;
});
$(_.doc).on('ce:combination:switch', '.ty-horizontal-product-filters-dropdown__wrapper', function (event, container, flag) {
if (_.abt__ut2.device === 'desktop' && window.matchMedia('(max-width: 775px)').matches) {
let $this_head_filter = $(this);
let $this_popup_filter = container;
let $this_filter = $this_head_filter.parent('.ut2__horizontal-product-filters-dropdown');
let $other_filters = $this_filter.siblings();
if (!flag) {
$other_filters.children('.ty-horizontal-product-filters-dropdown__wrapper.open').trigger('click');
}
$this_popup_filter.toggleClass('hidden', flag);
}
});
$(_.doc).on('change', '.cm-product-filters-checkbox:enabled', (e) => {
if (_.abt__ut2.device !== 'desktop') {
$.ceEvent('on', 'ce.ajaxdone', (elements) => {
let needElem = $('.ty-horizontal-product-filters.cm-horizontal-filters.ut2-filters')
.find('#' + $(e.target).closest('.cm-horizontal-filters-content').attr('id'));
needElem.css('transition', 'unset').addClass('container-opened');
});
}
});
$(_.doc).on('click', '.ty-horizontal-product-filters.cm-horizontal-filters.ut2-filters .ty-product-filters__reset-button', () => {
if (_.abt__ut2.device !== 'desktop') {
$('html').removeClass('no-scroll');
}
});
$.ceEvent('on', 'ce:geomap:location_set_after', function (location, $container, response, auto_detect) {
if (!response.is_detected || !$(_.body).find('.cm-warehouse-block-depends-by-location').length) {
return;
}
$('.ut2-sp-f:visible')?.click();
})
$(document).ready(function() {
$('.cm-dialog-opener.ut2-append-body').each(function () {
const $self = $(this);
const content = $(`#${$self.data('caTargetId')}`);
$self.parent().addClass('object-container');
content.length && content.appendTo($self);
});
});
const dropDownMenuBtn = $('.top-menu-grid-vetrtical .ty-dropdown-box__title');
let ut2MenuInboxClone = $('.ut2-menu__inbox').clone().css({'display': 'block'}).appendTo(dropDownMenuBtn);
let ut2MenuInboxHeight = ut2MenuInboxClone.outerHeight();
ut2MenuInboxClone.remove();
let processMainMenu = () => {
let t;
clearTimeout(t);
t = setTimeout(() => {
if ($('.ut2-menu__inbox').is(':visible')) {
let compareHeight = ($('body').hasClass('fixed-header')) ?
parseInt($(window).height() - $('.tygh-header').height()) :
parseInt($(window).height() - ($('.tygh-header').height() + $('.tygh-top-panel').height()));
(ut2MenuInboxHeight > compareHeight) ?
$('.ut2-menu__inbox').height(compareHeight) :
$('.ut2-menu__inbox').removeAttr('style');
}
}, 150);
};
dropDownMenuBtn.on('click', () => {
processMainMenu();
});
$(window).on('scroll resize', () => {
processMainMenu();
$('.cm-tooltip,.ty-product-filters__tooltip').each(function (){
const tooltip = $(this).data('tooltip');
if (tooltip?.isShown()) {
tooltip.hide();
return false
}
});
});
$.ceEvent('on', 'ce.product_image_gallery.inner.beforeInit', function(ins) {
const list_type = ins.options.caProductList ?? undefined;
if (list_type) {
const type = _.abt__ut2.settings.product_list[list_type].show_gallery[_.abt__ut2.device];
ins.options.pagination = type === 'points';
ins.options.navigation = type === 'arrows';
}
})
}(Tygh, Tygh.$));
