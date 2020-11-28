function ParentDS() constructor {
	struct = undefined
	
	ds_type = -1;
	
	iterator = function() { return new Iterator() }
	
	export = function() {
		var it = self.iterator()
		var arr = array_create(ds_size(ds_type, struct));
		
		var s = {
			array : arr,
			index : 0
		}
		
		foreach(it, method(s, function(i) { array[index++] = i }))
		it.free()
		
		delete it
		delete s
		return arr
	}
		
	toString = function() { return array_to_string(self.export()) }
	
	read = function(str) { ds_read(ds_type, struct, str) }
	
	write = function(str) { ds_write(ds_type, struct) }
	
	free = function() { ds_destroy(ds_type, struct) }
	
	clear = function() { ds_clear(ds_type, struct) }
}

function List() : ParentDS() constructor {
	struct = ds_list_create()
	
	ds_type = ds_type_list
	
	iterator = function() {
		var it = new Iterator()
		
		it.struct = self.struct
		with(it)
		{
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
	
	push = function() {
		var i;
		for(i = 0; i < argument_count; i++)
			ds_list_add(self.struct, argument[i]);
		
		return ds_list_size(self.struct) - 1;
	}
	
	extend = function(val) {
		var it = iter(val);
		
		foreach(it, function(val) {
			ds_list_add(self.struct, val)
		})
		it.free()
	}
	
	set = function(pos, val) { ds_list_set(self.struct, pos, val) }

	insert = function(pos, val) { ds_list_insert(self.struct, pos, val); }
	
	replace = function(pos, val) { ds_list_replace(self.struct, pos, val); }
	
	remove = function(pos) { ds_list_delete(self.struct, pos); }

	get = function(pos) { return ds_list_find_value(self.struct, pos); }

	find = function(val) { return ds_list_find_index(self.struct, val); }

	top = function() {
		var pos = ds_list_size(self.struct) - 1;
		
		return ds_list_find_value(self.struct, pos);
	}

	pop = function() {
		var pos = ds_list_size(self.struct) - 1;
		var val = ds_list_find_value(self.struct, pos);
		
		ds_list_delete(self.struct, pos);
		return val;
	}

	clear = function() { ds_list_clear(self.struct); }
	
	empty = function() { return ds_list_empty(self.struct); }
	
	size = function() { return ds_list_size(self.struct); }
	
	sort = function() {
		var asc = argument_count > 0 ? argument[0] : true;
		
		ds_list_sort(self.struct, asc);
	}
	
	sum = function(pos1, pos2) {
		var size = self.size();
		pos1 = clamp(pos1, 0, size);
		pos2 = clamp(pos2, 0, size);

		var s = 0;
		for(var i = pos1; i <= pos2; i++)
			s += struct[| i];

		return s;
	}

	ave = function(pos1, pos2) {
		var size = self.size();
		pos1 = clamp(pos1, 0, size);
		pos2 = clamp(pos2, 0, size);
		
		var _ave = self.sum(pos1, pos2) / (pos2 - pos1)
		return _ave;
	}

	copy = function() {
		var cp = new List();
		ds_list_copy(cp.struct, self.struct);
		
		return cp;
	}
}

function Queue() : ParentDS() constructor {
	struct = ds_queue_create();
	
	ds_type = ds_type_queue
	
	iterator = function() {
		var it = new Iterator()
		
		it.struct = self.struct
		with(it)
		{
			struct_copy = ds_queue_create()
			
			init = function() {
				ds_queue_clear(struct_copy)
				
				ds_queue_copy(struct_copy, struct)
			}
			
			next = function() {
				if ds_queue_empty(struct_copy)
					throw ENDOFITER
				else
					return ds_queue_dequeue(struct_copy)
			}
			
			free = function() { ds_queue_destroy(struct_copy) }
		}
		
		return it;
	}

	///@argu value
	push = function() {
		for(var i = 0; i < argument_count; i++)
			ds_queue_enqueue(self.struct, argument[i]);
	}

	pop = function() { return ds_queue_dequeue(self.struct); }
	
	clear = function() { ds_queue_clear(self.struct); }
	
	empty = function() { return ds_queue_empty(self.struct); }
	
	size = function() { return ds_queue_size(self.struct); }
	
	copy = function() {
		var cp = new Queue();
		ds_queue_copy(cp.struct, self.struct);
		
		return cp;
	}
}

function Map() : ParentDS() constructor {
	struct = ds_map_create();
	
	ds_type = ds_type_map
	
	iterator = function() {
		var it = new Iterator()
		
		it.struct = self.struct
		
		if !ds_map_empty(struct)
			with(it)
			{
				init = function() {
					iterend = false;
					key = ds_map_find_first(self.struct);
					lastkey = ds_map_find_last(self.struct);
				}
			
				next = function() {
					if iterend
						throw ENDOFITER
					
					var k = key;
					
					if key != lastkey
						key = ds_map_find_next(self.struct, key)
					else
						iterend = true;
				
					return k;
				}
			}
		
		return it
	}

	add = function(key, value) { ds_map_add(self.struct, key, value); }
	
	set = function(key, value) { ds_map_set(self.struct, key, value); }
	
	remove = function(key) { ds_map_delete(self.struct, key); }
	
	del = remove
	
	get = function(key) { return self.struct[? key] }
	
	clear = function() { ds_map_clear(self.struct); }
	
	exists = function(key) { return ds_map_exists(self.struct, key) }
	
	find = function(val) {
		if ds_map_empty(self.struct)
			return undefined
		
		var it = self.iterator()
		var _struct = { struct : self.struct, result : undefined, find : val }
		var result
		
		foreach(it, method(_struct, function(i) {
			if typeof(struct[? i]) == typeof(find) && struct[? i] == find
			{
				result = i
				
				throw ENDOFITER	
			}
		}))
		
		result = _struct.result
		
		delete it
		delete _struct
		return result
	}
	
	empty = function() { return ds_map_empty(struct); }
	
	size = function() { return ds_map_size(struct); }

	keys = function() {
		var it = self.iterator()
		var arr = array_create(ds_map_size(self.struct))
		var _struct = {
			array : arr,
			index : 0
		}
		
		foreach(it, method(_struct, function(i) {
			array[index++] = i;
		}))
		
		delete it
		delete _struct
		return arr
	}
	
	values = function() {
		var it = self.iterator()
		var arr = array_create(ds_map_size(self.struct))
		var _struct = {
			struct: self.struct,
			array : arr,
			index : 0
		}
		
		foreach(it, method(_struct, function(i) {
			array[index++] = struct[? i];
		}))
		
		delete it
		delete _struct
		return arr
	}
	
	items = function() {
		var it = self.iterator()
		var arr = array_create(ds_map_size(self.struct))
		var _struct = {
			struct: self.struct,
			array : arr,
			index : 0
		}
		
		foreach(it, method(_struct, function(i) {
			array[index++] = {
				key : i,
				value : struct[? i]
			}
		}))
		
		delete it
		delete _struct
		return arr
	}
	
	copy = function() {
		var cp = new Map();
		ds_map_copy(cp.struct, struct);
		
		return cp;
	}
}

function Grid(w, h) : ParentDS() constructor {
	struct = ds_grid_create(w, h);
	
	ds_type = ds_type_grid
	
	set = function(x, y, val) { ds_grid_set(self.struct, x, y, val); }
	
	add = function(x, y, val) { ds_grid_add(self.struct, x, y, val); }
	
	get = function(x, y) { return ds_grid_get(self.struct, x, y); }
	
	add_region = function(x1, y1, x2, y2, val) { ds_grid_add_region(self.struct, x1, y1, x2, y2, val); }
	
	set_region = function(x1, y1, x2, y2, val) { ds_grid_set_region(self.struct, x1, y1, x2, y2, val); }
	
	clear = function(val) { ds_grid_clear(self.struct, val); }
	
	match = function(x, y, val) { return (self.struct[# x, y] == val); }
	
	match_region = function(x1, y1, x2, y2, val) {
		var i, j
		for(i = x1; i <= x2; i++)
		for(j = y1; j <= y2; j++)
		{
			if struct[# i, j] != val
				return false;
		}
		
		return true;
	}
	
	exists = function(x1, y1, x2, y2, val) { return ds_grid_value_exists(self.struct, x1, y1, x2, y2, val); }
	
	find = function(x1, y1, x2, y2, val) {
		if !ds_grid_value_exists(struct, x1, y1, x2, y2, val)
			return undefined;

		var st = {
			x : ds_grid_value_x(struct, x1, y1, x2, y2, val),
			y : ds_grid_value_y(struct, x1, y1, x2, y2, val)
		}
		
		return st;
	}
	
	x = function(x1, y1, x2, y2, val) { return ds_grid_value_x(struct, x1, y1, x2, y2, val); }
	
	y = function(x1, y1, x2, y2, val) { return ds_grid_value_y(struct, x1, y1, x2, y2, val); }
	
	width = function() { return ds_grid_width(struct); }

	height = function() { return ds_grid_height(struct); }
	
	export = function() {
		var w, h;
		w = ds_grid_width(struct)
		h = ds_grid_height(struct)
		
		var arr = array_create(w)
		var i, j
		for(i = 0; i < w; i++)
		{
			arr[i] = array_create(h)
			
			for(j = 0; j < h; j++)
				arr[i][j] = struct[# i, j]	
		}
		
		return arr
	}

	copy = function() {
		var w, h
		w = ds_grid_width(struct)
		h = ds_grid_height(struct)
		
		var cp = new Grid(w, h);
		ds_grid_copy(cp.struct, self.struct);
		
		return cp;
	}
}

function Stack() : ParentDS() constructor {
	struct = ds_stack_create()
	
	ds_type = ds_type_stack
	
	iterator = function() {
		var it = new Iterator()
		
		with(it)
		{
			struct = other.struct
			struct_copy = ds_stack_create()
			
			init = function() {
				ds_stack_clear(struct_copy)
				
				ds_stack_copy(struct_copy, struct)
			}
			
			next = function() {
				if ds_stack_empty(struct_copy)
					throw ENDOFITER
				else
					return ds_stack_pop(struct_copy)
			}
			
			free = function() { ds_stack_destroy(struct_copy) }
		}
		
		return it;
	}
	
	free = function() { ds_stack_destroy(self.struct); }
	
	push = function(val) { ds_stack_push(struct, val) }
	
	pop = function() { return ds_stack_pop(struct) }
	
	top = function() { return ds_stack_top(struct) }
	
	clear = function() { ds_stack_clear(struct) }
	
	size = function() { return ds_stack_size(struct) }
	
	empty = function() { return ds_stack_empty(struct) }
	
	copy = function() {
		var cp = new Stack();
		ds_stack_copy(cp.struct, struct);
		
		return cp;
	}
}

function PriorityQueue() : ParentDS() constructor {
	struct = ds_priority_create();
	
	ds_type = ds_type_priority
	
	iterator = function() {
		var it = new Iterator()
		
		var _struct = self.struct
		with(it)
		{
			struct = _struct
			struct_copy = ds_priority_create()
			
			init = function() {
				ds_priority_clear(struct_copy)
				
				ds_priority_copy(struct_copy, struct)
			}
			
			next = function() {
				if ds_priority_empty(struct_copy)
					throw ENDOFITER
				else
					return ds_priority_delete_min(struct_copy)
			}
			
			free = function() { ds_priority_destroy(struct_copy) }
		}
		
		return it;
	}

	push = function(val, priority) { ds_priority_add(self.struct, val, priority) }

	top = function() { return ds_priority_find_max(self.struct); }
	
	tail = function() { return ds_priority_find_min(self.struct); }
	
	pop_top = function() { return ds_priority_delete_max(self.struct); }
	
	pop_tail = function() { return ds_priority_delete_min(self.struct); }
	
	clear = function() { ds_priority_clear(self.struct); }
	
	empty = function() { return ds_priority_empty(self.struct); }
	
	size = function() { return ds_priority_size(self.struct); }
	
	copy = function() {
		var cp = new PriorityQueue()
		ds_priority_copy(cp.struct, struct);
		
		return cp;
	}
}

function SegTree() : ParentDS() constructor {
	struct = ds_segment_create();
	
	ds_type = ds_type_segment
	
	iterator = function() {
			
	}
	
	set = function(pos, val) { ds_segment_set(struct, pos, val) }
	
	add = function(pos, val) { ds_segment_add(struct, pos, val) }
	
	get = function(pos) { return ds_segment_get(struct, pos) }
	
	sum = function(st, ed) { return ds_segment_sum(struct, free) }
	
	sum_all = function() { return ds_segment_all(struct) }
	
	find = function(value) { return ds_segment_find(struct, value) }
	
	clear = function() { return ds_segment_clear(struct); }
}

function Trie() : ParentDS() constructor {
	struct = ds_trie_create()
	
	ds_type = ds_type_trie
	
	insert = function(str) { ds_trie_insert(struct, str) }
	
	find = function(str) { return ds_trie_find(struct, str) }
}

function Linked() : ParentDS() constructor {
	list = { top : undefined, tail : undefined }
	
	push_top = function(val) {
		var n = new Node_Linked(val);
		
		if is_undefined(list.top)
		{
			list.top = n;
			list.tail = n;
		}
		else
		{
			list.top.next = n;
			n.previous = list.top;
			list.top = n;
		}
		
		return n;
	}
	
	push_tail = function(val) {
		var n = new Node_Linked(val);
		
		if is_undefined(list.tail)
		{
			list.top = n;
			list.tail = n;
		}
		else
		{
			list.tail.previous = n;
			n.next = list.tail;
			list.tail = n;
		}
		
		return n;
	}
	
	get_top = function() {
		return list.top;
	}
	
	get_tail = function() {
		return list.tail;
	}
	
	del = function(node) {
		var nnode, pnode;
		
		if is_undefined(node.previous) && is_undefined(node.next)
		{
			list.top = undefined;
			list.tail = undefined;
		}
		else if is_undefined(node.previous)
		{
			nnode = node.next;
			
			list.tail = nnode;
			nnode.previous = undefined;
		}
		else if is_undefined(node.next)
		{
			pnode = node.previous;
			
			list.top = pnode;
			pnode.next = undefined;
		}
		else
		{
			nnode = node.next;
			pnode = node.previous;
			
			nnode.previous = pnode;
			pnode.next = nnode;
		}
		
		delete node;
	}
	
	top = function() {
		return list.top;
	}
	
	tail = function() {
		return list.tail;
	}
	
	iterator = function() {
		var it = new Iterator()
		
		with(it)
		{
			struct = other.list;
			current = undefined;
			
			init = function() {
				current = struct.tail;
			}
			
			next = function() {
				if is_undefined(current)
					throw ENDOFITER
				
				var val;
				val = current;
				
				current = current.next;
				return val;
			}
		}
		
		return it;
	}
	
	free = nope;
}

function Node_Linked(val) constructor {
	value = val;
	next = undefined;
	previous = undefined;
}

