{$id_prefix = ""|uniqid}

{if $display != "form"}
    <div class="nowrap">
        <div class="form-inline">
{else}
    <div class="sidebar-field">
{/if}

        {if $display != "form"}

        {else}
            </div>
            <div class="sidebar-field">
        {/if}

        <label{if $display != "form"} class="label-html"{/if}>{__("select_dates")}:</label>

        {$time_from = "`$prefix`time_from"}
        {$time_to = "`$prefix`time_to"}

        {if $display == "form"}
            {$date_meta = "input-date"}
        {else}
            {$date_meta = "input-small"}
        {/if}
        </br>
        {__("from_date")}: {include file="common/calendar.tpl" date_id="`$id_prefix`f_date" date_name="`$prefix`time_from" date_val=$search.$time_from  start_year=$settings.Company.company_start_year extra="onchange=\"Tygh.$('#`$id_prefix`period_selects').val('C');\"" date_meta=$date_meta}
        {if $display == "form"}
        {else}
            &nbsp;&nbsp;&nbsp;&nbsp;
        {/if}
        </br>
        {__("to_date")}: {include file="common/calendar.tpl" date_id="`$id_prefix`t_date" date_name="`$prefix`time_to" date_val=$search.$time_to  start_year=$settings.Company.company_start_year extra="onchange=\"Tygh.$('#`$id_prefix`period_selects').val('C');\"" date_meta=$date_meta}

        {if $display != "form"}
                </div>
            </div>
        {else}
            </div>
        {/if}

{script src="js/tygh/period_selector.js"}
<script>
Tygh.$(document).ready(function() {$ldelim}
    Tygh.$('#{$id_prefix}period_selects').cePeriodSelector({$ldelim}
        from: '{$id_prefix}f_date',
        to: '{$id_prefix}t_date'
    {$rdelim});
{$rdelim});
</script>
