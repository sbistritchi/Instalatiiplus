/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2023   *
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
let removePercentClass = () => {
Array.from(document.getElementsByClassName('ab__p_show_percent')).forEach((el) => {
el.removeAttribute('data-ca-percent');
el.removeAttribute('data-ca-settings-percent');
el.classList.remove('ab__p_show_percent');
el.classList.remove('ab__p_lcp_missing');
el.classList.remove('ab__p_preloaded');
});
$.ceNotification('closeAll');
document.querySelectorAll('.ab__p_tooltip').forEach(el => el.remove());
}
let addtooltip = (el,elState) => {
let tooltipContent = [];
switch (elState.preload){
case -1:
tooltipContent.push('<b>' + _.tr('ab__p_image_must_be_preloaded') + '</b>');
break;
case 0:
tooltipContent.push(_.tr('ab__p_image_is_not_preloaded'));
break;
case 1:
tooltipContent.push(_.tr('ab__p_image_is_preloaded'));
break;
}
if(elState.visible_percent){
tooltipContent.push(_.tr('ab__p_fact_pov') + ': ' + elState.visible_percent + '%')
}
if(elState.priority){
tooltipContent.push(_.tr('ab__p_settings_pov') + ': ' + elState.priority + '%')
}
$('<div class="cm-tooltip ab__p_tooltip" title="'+tooltipContent.join('<hr>')+'"></div>').appendTo(el);
}
let getSrc = (el) => {
let src;
if (el.nodeName.toLowerCase() === 'img') {
src = el.currentSrc
} else {
src = $(el).find('img')[0]?.src
if (!src && el.closest('.ut2-banner')) {
el = el.closest('.ut2-banner');
let bg = el.querySelector('.ut2-a__bg-banner').style.backgroundImage;
src = bg.replace('url(', '').replace(')', '').replace(/\"/gi, "");
}
}
return decodeURI(src);
}
let perfObs = new PerformanceObserver((entryList) => {});
let observer = new IntersectionObserver(
(entries, observer) => {
removePercentClass();
let visible_imgs = [];
entries.forEach(entry => {
if (entry.intersectionRect.width && entry.intersectionRect.height && entry.intersectionRatio > 0.7) {
if (
entry.target.parentNode.closest('.ut2-banner')
||
entry.target.parentNode.closest('.abyt_banner')
) {
return;
}
visible_imgs.push(entry.target);
}
});
observer.disconnect();
perfObs.observe({type: 'largest-contentful-paint', buffered: true});
let perfObsRecords = perfObs.takeRecords();
perfObs.disconnect();
let lcpCandidateEntry = false;
let lcpCandidateSrc = false;
for (const entry of perfObsRecords) {
if(lcpCandidateEntry.size === undefined || entry.size > lcpCandidateEntry.size){
lcpCandidateEntry = entry;
}
}
if(lcpCandidateEntry.element === null){
$.ceNotification('show', {
title: _.tr('error'),
message: _.tr('ab__p_lcp_element_missing'),
type: 'E'
});
return false;
}
if(lcpCandidateEntry.element instanceof HTMLImageElement){
lcpCandidateSrc = getSrc(lcpCandidateEntry.element);
}else if(lcpCandidateEntry.element.closest('.ut2-a__bg-banner')){
lcpCandidateSrc = getSrc(lcpCandidateEntry.element.closest('.ut2-a__bg-banner'));
}else if(lcpCandidateEntry.element.closest('.abyt-a-bg-banner')){
lcpCandidateSrc = getSrc(lcpCandidateEntry.element.closest('.abyt-a-bg-banner'));
}
let imgs_square = 0;
[all_links_with_priorities, preloaded_links] = getPreloadLinks();
visible_imgs.map((el) => {
imgs_square += el.square = el.clientHeight * el.clientWidth;
return el;
}).map((el) => {
let container = el.closest(':not(img)');
let src = getSrc(el);
let elState = {
'preload': 0
};
elState.visible_percent = Math.round((el.square / imgs_square) * 100);
container.classList.add('ab__p_show_percent');
container.setAttribute('data-ca-percent', elState.visible_percent);
if(lcpCandidateSrc === src && preloaded_links.indexOf(src) === -1){
elState.preload = -1;
container.classList.add('ab__p_lcp_missing');
}
if(preloaded_links.indexOf(src) !== -1){
elState.preload = 1;
container.classList.add('ab__p_preloaded');
}
let hasSettings = all_links_with_priorities.findIndex((item) => item.url === src) !== -1;
if (hasSettings) {
let position = all_links_with_priorities.findIndex((item) => item.url === src);
elState.priority = all_links_with_priorities[position].priority;
if (el.classList.contains('ut2-banner') || el.classList.contains('abyt_banner')) {
if (document.evaluate('count(./'+'/comment()[contains(.,"ab__image_preload")])', el, null, XPathResult.NUMBER_TYPE).numberValue === 2) {
elState.priority *= 2;
}
}
container.setAttribute('data-ca-settings-percent', elState.priority);
}
addtooltip(container,elState);
if(hasSettings){
return src
}
})
let can_be_preloaded_urls = {};
visible_imgs.forEach((el) => {
if (el instanceof HTMLImageElement) {
can_be_preloaded_urls[decodeURI(el.currentSrc)] = true
} else {
let preloadedLinksExpression = document.evaluate('./'+'/comment()[contains(.,"ab__image_preload")]', el);
let preloadedLinksIterator = preloadedLinksExpression.iterateNext();
while (preloadedLinksIterator) {
let m = preloadedLinksIterator.textContent.match(/(?<url>http[s]?:\/\/\S+)<(?<priority>\S*)>/);
can_be_preloaded_urls[decodeURI(m.groups.url)] = true;
preloadedLinksIterator = preloadedLinksExpression.iterateNext();
}
}
})
let wrong_preloaded = preloaded_links.filter((el) => {
if (!can_be_preloaded_urls[el]) {
return el;
}
})
if (wrong_preloaded.length) {
$.ceNotification('show', {
title: _.tr('ab__p_wrong_preload_images'),
message: wrong_preloaded.join('</br>'),
type: 'W'
});
}
},
{
}
);
let getPreloadLinks = () => {
let preloadedLinks = [];
let preloadeMarks = [];
let preloadedLinksExpression = document.evaluate('/'+'/link[@rel="preload" and @as="image"]/@href', document);
let preloadedLinksIterator = preloadedLinksExpression.iterateNext();
while (preloadedLinksIterator) {
preloadedLinks.push(preloadedLinksIterator.value);
preloadedLinksIterator = preloadedLinksExpression.iterateNext();
}
let preloadedMarksExpression = document.evaluate('/'+'/comment()[contains(.,"ab__image_preload")]', document);
let preloadedMarksIterator = preloadedMarksExpression.iterateNext();
while (preloadedMarksIterator) {
preloadeMarks.push(preloadedMarksIterator.textContent);
preloadedMarksIterator = preloadedMarksExpression.iterateNext();
}
preloadeMarks = preloadeMarks.map((mark) => {
var match = mark.match(/(?<url>http[s]?:\/\/\S+)<(?<priority>\S*)>/)
return match.groups;
})
return [preloadeMarks, preloadedLinks];
}
$.ceEvent('on', 'dispatch_event_pre', function (e, jelm) {
if (e.type === 'click') {
if ($(e.target).closest(".cm-ab-p-calculate-pov").length) {
window.scrollTo(0, 0);
document.querySelectorAll('#tygh_container img,.ut2-banner, .abyt_banner').forEach(img => {
observer.observe(img)
});
}
}
}
)
}(Tygh, Tygh.$));