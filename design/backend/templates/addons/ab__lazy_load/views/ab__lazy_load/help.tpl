{capture name="mainbox"}
<p>{__('ab__lazy_load.help.docs')}</p>
{/capture}
{include file="addons/ab__addons_manager/views/ab__am/components/menu.tpl" addon="ab__lazy_load"}
{include file="common/mainbox.tpl"
title_start=__("ab__lazy_load")|truncate:40
title_end=__("ab__lazy_load.help")
content=$smarty.capture.mainbox
buttons=$smarty.capture.buttons
adv_buttons=$smarty.capture.adv_buttons
sidebar=$smarty.capture.sidebar}