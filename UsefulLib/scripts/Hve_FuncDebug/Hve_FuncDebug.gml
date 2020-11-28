function cout() {
	if argument_count > 0
	{		
		argument_array = array_create(argument_count);
		for(var __i = 0; __i < argument_count; __i++)
			argument_array[__i] = argument[__i]
	}
	else
		argument_array = [];
	
	var str = function_execute(merge_string, argument_array);
	
	show_message(str);
}

function log() {
	if argument_count > 0
	{		
		argument_array = array_create(argument_count);
		for(var __i = 0; __i < argument_count; __i++)
			argument_array[__i] = argument[__i]
	}
	else
		argument_array = [];
	
	var str = function_execute(merge_string, argument_array);
	
	show_debug_message(str);
}

function fcout(str, argu) { show_message(format(str, argu)) }

function flog(str, argu) { show_debug_message(format(str, argu)) }