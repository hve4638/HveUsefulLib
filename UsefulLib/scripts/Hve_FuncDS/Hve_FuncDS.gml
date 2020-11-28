function ds_destroy(ds_type, ds_id)
{
	switch(ds_type)
	{
		case ds_type_list:
			ds_list_destroy(ds_id);
		break
		case ds_type_map:
			ds_map_destroy(ds_id);
		break
		case ds_type_queue:
			ds_queue_destroy(ds_id);
		break
		case ds_type_stack:
			ds_stack_destroy(ds_id);
		break
		case ds_type_grid:
			ds_grid_destroy(ds_id);
		break
		case ds_type_priority:
			ds_priority_destroy(ds_id);
		break
		case ds_type_trie:
			ds_trie_destroy(ds_id);
		break
		case ds_type_segment:
			ds_segment_destroy(ds_id);
		break
		
		
		default:
			return -1
	}
	
	return 0
}

function ds_clear(ds_type, ds_id)
{
	switch(ds_type)
	{
		case ds_type_list:
			ds_list_clear(ds_id);
		break
		case ds_type_map:
			ds_map_clear(ds_id);
		break
		case ds_type_queue:
			ds_queue_clear(ds_id);
		break
		case ds_type_stack:
			ds_stack_clear(ds_id);
		break
		case ds_type_priority:
			ds_priority_clear(ds_id);
		break
		case ds_type_segment:
			ds_segment_clear(ds_id);
		break
		
		default:
			return -1
	}
	
	return 0
}

function ds_write(ds_type, ds_id)
{
	switch(ds_type)
	{
		case ds_type_list:
			return ds_list_write(ds_id);
		break
		case ds_type_map:
			return ds_map_write(ds_id);
		break
		case ds_type_queue:
			return ds_queue_write(ds_id);
		break
		case ds_type_stack:
			return ds_stack_write(ds_id);
		break
		case ds_type_grid:
			return ds_grid_write(ds_id);
		break
		case ds_type_priority:
			return ds_priority_write(ds_id);
		break
		
		default:
			return undefined
	}
}

function ds_read(ds_type, ds_id, str)
{
	switch(ds_type)
	{
		case ds_type_list:
			ds_list_read(ds_id, str);
		break
		case ds_type_map:
			ds_map_read(ds_id, str);
		break
		case ds_type_queue:
			ds_queue_read(ds_id, str);
		break
		case ds_type_stack:
			ds_stack_read(ds_id, str);
		break
		case ds_type_grid:
			ds_grid_read(ds_id, str);
		break
		case ds_type_priority:
			ds_priority_read(ds_id, str);
		break
		
		default:
			return -1
	}
	
	return 0
}

function ds_size(ds_type, ds_id)
{
	switch(ds_type)
	{
		case ds_type_list:
			return ds_list_size(ds_id);
		break
		case ds_type_map:
			return ds_map_size(ds_id);
		break
		case ds_type_queue:
			return ds_queue_size(ds_id);
		break
		case ds_type_stack:
			return ds_stack_size(ds_id);
		break
		case ds_type_priority:
			return ds_priority_size(ds_id);
		break
		
		default:
			return -1
	}
	
	return -1
}

function ds_list_array(ls)
{
	var arr, size
	size = ds_list_size(ls)
	
	arr = array_create(size, 0)
	
	var i
	for(i = 0; i < size; i++)
		arr[i] = ls[| i]
	
	return arr
}

function ds_trie_find(trie_id, str)
{
	var n = _trie_node_find(trie_id, str)
	
	var size = _trie_node_size(n)
	var arr = array_create(size)
	for(var i = 0; i < size; i++)
		arr[i] = _trie_node_value(n, i);
	_trie_node_destroy(n)
	
	return arr;
}

global.temporarylist = -1;

function ds_list_temp() {
	if !ds_exists(global.temporarylist, ds_type_list)
		global.temporarylist = ds_list_create();
	else
		ds_list_clear(global.temporarylist);
	
	return global.temporarylist;
}

function ds_list_iterator(id) {
	var it = new Iterator()

	with(it)
	{
		struct = id;
		
		init = function() {
			index = 0;
			end_index = ds_list_size(struct)
		}
			
		next = function() {
			var val
				
			if index < end_index
				return struct[| index++]
			else
				throw ENDOFITER
		}
	}
	return it
}










