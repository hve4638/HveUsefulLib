function subarray(array)
{
	var arr = []
	var st = argument_count > 1 ? argument[1] : 0;
	var ed = argument_count > 2 ? argument[2] : array_length(array)
	
	array_copy(arr, 0, array, st, ed - st + 1)
	return arr;
}

function array_swap(arr, ind1, ind2)
{
	var t;
	t = arr[@ ind1];
	arr[@ ind1] = arr[@ ind2];
	arr[@ ind2] = t;
}

function array_exists(arr, ind) {
	var len = array_length(arr);
	
	for(var i = 0; i < len; i++)
	{
		if is(arr[@ i], ind)
			return true;
	}
	return false;
}

///@argu source
function array_extend()
{
	var i, j, size;
	var arr;
	
	size = 0
	for(i = 0; i < argument_count; i++)
	{
		var src = argument[i]
		
		if is_array(src)
			size += array_length(src)
		else
			return undefined
	}
	
	arr = array_create(size);
	
	j = 0;
	for(i = 0; i < argument_count; i++)
	{
		var src = argument[i];
		var src_size = array_length(src)
		
		array_copy(arr, j, src, 0, src_size);
		j += src_size
	}
	
	return arr
}

///@argu array
///@argu reverse
function array_sort(arr)
{
	var st, ed;
	var reverse = argument_count > 1 ? argument[1] : false;
	var s = ds_stack_create();
	
	var func;
	
	if !reverse
		func = function(a, b) { return a < b; }
	else
		func = function(a, b) { return b > a; }
	
	ds_stack_push(s, [0, array_length(arr) - 1]);
	
	var pv;
	while(!ds_stack_empty(s))
	{
		var p = ds_stack_pop(s);
		st = p[0];
		ed = p[1];
		
		if st >= ed
			continue;
		
		pv = arr[(st + ed) div 2]
		
		while(st < ed)
		{
			while(func(arr[st], pv))
				st++;
		
			while(func(pv, arr[ed]))
				ed--;
			
			if st <= ed
				array_swap(arr, st++, ed--);
			else
				break;
		}
		
		ds_stack_push(s, [p[0], ed]);
		ds_stack_push(s, [st, p[1]]);
	}
	
	ds_stack_destroy(s)
}

function array_to_string(arr)
{
	var size = array_length(arr)
	if size == 0
		return "[]"
	
	var str = "["
	for(var i = 0; i < size - 1; i++)
		str += (is_string(arr[i]) ? "\"" + arr[i] + "\"" : string(arr[i])) + ", "
	str += (is_string(arr[i]) ? "\"" + arr[i] + "\"" : string(arr[i])) + "]"

	return str
}

