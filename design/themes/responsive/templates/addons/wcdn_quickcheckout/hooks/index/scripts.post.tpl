{if $smarty.request.dispatch eq "quickcheckout.checkout"}
<script>

$(document).on('change', '[name="user_data[fields][42]"]', function()
{
	check_invoice_type();
	check_required_fields_for_checkout();
});


$(document).on('change', '[name="ship_to_another"]', function()
{
	check_invoice_type();
	check_required_fields_for_checkout();
	fn_calculate_total_shipping_cost_quickcheckout(true, true);
});


setTimeout(function()
{
	check_invoice_type();
	check_required_fields_for_checkout();
	
}, 200);

function check_invoice_type()
{
	
	var value = $('[name="user_data[fields][42]"]:checked').val();
	var billing_type = $('[name="ship_to_another"]:checked').val();
	
	if($("#ba").length == 0)
	{
		billing_type = 1;
	}

	if(billing_type == 1)
	{
		if(value == 1)
		{
			//pers. fizica
			$('[name="user_data[fields][36]"]').parent().hide().find('label').removeClass('cm-required');
			$('[name="user_data[fields][38]"]').parent().hide().find('label').removeClass('cm-required');
			$('[name="user_data[fields][40]"]').parent().hide().find('label').removeClass('cm-required');
		}
		else
		{
			//pers juridica
			$('[name="user_data[fields][36]"]').parent().show().find('label').addClass('cm-required');
			$('[name="user_data[fields][38]"]').parent().show().find('label').addClass('cm-required');
			$('[name="user_data[fields][40]"]').parent().show().find('label').addClass('cm-required');
		}
	}
	else
	{
		$('[name="user_data[fields][36]"]').parent().hide().find('label').removeClass('cm-required');
		$('[name="user_data[fields][38]"]').parent().hide().find('label').removeClass('cm-required');
		$('[name="user_data[fields][40]"]').parent().hide().find('label').removeClass('cm-required');
	}
}

function check_required_fields_for_checkout()
{
	var billing_type = $('[name="ship_to_another"]:checked').val();
	if(billing_type == 1)
	{
		$("#ba").find('label.keep-required').addClass('cm-required').removeClass('keep-required');
	}
	else
	{
		$("#ba").find('label.cm-required').addClass('keep-required').removeClass('cm-required');
	}
	
	$("#ba").find('[name="user_data[fields][40]"]').parent().find('label').removeClass('cm-required');
}

$(function()
{
	$('input[name="user_data[b_state]"]').remove();
	$('input[name="user_data[b_city]').remove();
	$('input[name="user_data[s_state]"]').remove();
	$('input[name="user_data[s_city]').remove();
});

$(document).on('change', '[name="user_data[b_state]"]', function()
{
	change_state('b_state', 'b_city');
});

$(document).on('change', '[name="user_data[s_state]"]', function()
{
	change_state('s_state', 's_city');
});
$(document).on('change', '[name="user_data[s_city]"]', function()
{
	fn_calculate_total_shipping_cost_quickcheckout();
});

function change_state(state_input, city_input)
{
	var state = $('[name="user_data['+ state_input +']"]').val();

	if(typeof state != "undefined" && state.length > 0)
	{
		var selected_city = $('[name="user_data['+ city_input +']"]').attr('data-value');
		var get_cities = $.ajax('?dispatch=quickcheckout.cities&state='+state);
		
		$('[name="user_data['+ city_input +']"]').html('<option value="">-selectati localitate-</option>');
		
		get_cities.done(function(response)
		{
			var cities = JSON.parse(response);
			$(cities).each(function(i, city)
			{
				var selected = (city == selected_city) ? 'selected' : '';
				$('[name="user_data['+ city_input +']"]').append('<option value="'+city+'" '+selected+'>'+city+'</option>')
			});
		});
	}
}


$(document).on('blur', '[name^="user_data"]', function()
{
	fn_calculate_total_shipping_cost_quickcheckout(true, true);
});


	
{literal}
function fn_calculate_total_shipping_cost_quickcheckout(hidden = false, no_update = false)
{
    params = [];
    parents = Tygh.$('.ajax-change');
    radio = Tygh.$('input[type=radio]:checked', parents);
    
    var result_ids = 'shipping_rates_list,checkout_info_summary_*,checkout_info_order_info_*,checkout*,content_payments*,step_two_body';
    if(no_update == true)
    {
    	result_ids = '';
    }

    Tygh.$.each(radio, function(id, elm) {
        params.push({name: elm.name, value: elm.value});
    });

    $('form[name="paymens_form"] input').each(function()
    {
    	var input_type = $(this).attr('type');
    	
    	if(input_type == "text" || input_type == "email")
    	{
    		params.push({name: $(this).attr('name'), value: $(this).val()});
    	}
    });
    
    $('form[name="paymens_form"] select').each(function()
    {
    	params.push({name: $(this).attr('name'), value: $(this).val()});
    });
    
    
    var ship_to_another = $('[name="ship_to_another"]:checked').val();
    
    if(typeof ship_to_another == "undefined")
    {
    	ship_to_another = 0;
    }
     params.push({name: 'ship_to_another', value: ship_to_another});
 

    url = fn_url('?dispatch=quickcheckout.checkout');

    for (var i in params) {
        url += '&' + params[i]['name'] + '=' + escape(params[i]['value']);
    }
	
	prevent_scroll = true;
	
    Tygh.$.ceAjax('request', url, {
        result_ids: result_ids,
        method: 'get',
        full_render: true,
        hidden: hidden
    });
    
    setInterval(check_invoice_type(), 500);
}
{/literal}
</script>
{/if} 