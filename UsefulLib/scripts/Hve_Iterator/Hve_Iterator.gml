#macro ENDOFITER "StopIteration"

function Iterator() constructor {
	init = nope
	
	next = function() {
		throw ENDOFITER;
	}
	
	free = nope
}

function iter(argu) {
	if is_array(argu)
	{
		var _iter = new Iterator()

		with(_iter)
		{
			array = argu;
			index = 0;
			end_index = array_length(array);
			
			init = function() {
				self.index = 0;
				self.end_index = array_length(self.array);
			}
			
			next = function() {
				if self.index < self.end_index
				{
					return self.array[self.index++]
				}
				else
					throw ENDOFITER
			}
		}
		
		return _iter
	}
	else if is_struct(argu)
	{
		if instanceof(argu) == "Iterator"
			return argu
		
		if variable_struct_exists(argu, "iterator")
			return argu.iterator()
	}
	
	return undefined
}

function is_iterator(val) { return (is_struct(val) && (instanceof(val) == "Iterator")) }

function iterator_next(it) {
	var val
	try { val = it.next() }
	catch(ex) { endofiter_check(ex) }
	
	return val
}

function iterator_array(it) {
	var arr, ls
	
	ls = ds_list_create()
	foreach(it, method({ ls : ls }, function(i) { ds_list_add(ls, i); }))
	
	arr = ds_list_array(ls)
	ds_list_destroy(ls)

	return arr
}

function endofiter_check(ex)
{
	if !(is_string(ex) && (ex == ENDOFITER))
		throw ex
}

///@argu iterator
///@argu function
///@argu struct_ref
function foreach(it, func) {
	var needfree = false
	if !is_iterator(it)
	{
		it = iter(it)
		needfree = true

		if is_undefined(it)
			throw "Foreach() : Invaild iterator"
	}

	if argument_count > 2
		func = method(argument[2], func);

	var cnt = 0
	try
	{
		it.init()

		while(true)
		{
			func(it.next())
			cnt++
		}
	}
	catch(ex) { endofiter_check(ex) }

	if needfree
	{
		it.free()
		delete it
	}
	return cnt
}








