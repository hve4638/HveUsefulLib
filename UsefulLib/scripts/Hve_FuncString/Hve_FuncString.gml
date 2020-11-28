function string_char(str, index) { return string_char_at(str, index); }

function string_str(str, st, ed) {
	var len = string_length(str)
	st = st != 0 ? st : 1
	ed = ed != 0 ? ed : len
	st = modulo(st - 1, len) + 1
	ed = modulo(ed - 1, len) + 1
	
	if st > ed
		return ""
		
	return string_copy(str, st, ed - st + 1)
}

function string_pos_all(substr, str) {
	var pos, cnt, arr
	cnt = string_count(substr, str)
	
	if cnt > 0
	{
		arr = array_create(cnt)
		pos = string_pos(substr, str)
	
		var i = 0;
		while(pos != 0)
		{
			arr[i++] = pos
			pos = string_pos_ext(substr, str, pos)
		}
		
		return arr
	}
	
	return []
}

function string_group(str, substr) {
	var st, ed;
	st = string_pos_all(string_char(substr, 1), str);
	ed = string_pos_all(string_char(substr, 2), str);
	
	var subsize, len;
	len = string_length(str);
	subsize = array_length(st);
	
	if subsize == 0
		return [ str ]
	else if subsize != array_length(ed)
		throw "string_group() : The number of group characters is not same." + "\n" + str
	
	
	var ls = ds_list_create()
	
	if (st[0] > 1)
		ds_list_add(ls, string_str(str, 1, st[0] - 1))
	
	var i, sstr
	var st, ed
	for(i = 0; i < subsize; i++)
	{
		sstr = string_str(str, st[i], ed[i])
		ds_list_add(ls, sstr)
		
		if i < subsize - 1
		{
			sstr = string_str(str, ed[i] + 1, st[i + 1] - 1)
			
			if string_length(sstr)
				ds_list_add(ls, sstr)
		}
	}
	
	if (ed[subsize - 1] + 1 < len)
		ds_list_add(ls, string_str(str, ed[subsize - 1] + 1, len))
		
	var lssize = ds_list_size(ls);
	var arr = array_create(lssize)
	
	for(i = 0; i < lssize; i++)
		arr[i] = ls[| i];
	
	ds_list_destroy(ls)
	
	return arr
}

///@argu	str
///@argu	substr
function string_split(str) {
	var substr = argument_count > 1 ? argument[1] : " "
	var pos = string_pos_all(substr, str)
	var size = array_length(pos)
	
	var ls = ds_list_create();
	
	sub = string_str(str, 1, pos[0] - 1)
		
	if string_length(sub)
		ds_list_add(ls, sub)
	
	var i, sub
	for(i = 0; i < size - 1; i++)
	{
		sub = string_str(str, pos[i] + 1, pos[i + 1] - 1)
		
		if string_length(sub)
			ds_list_add(ls, sub)
	}
	
	sub = string_str(str, pos[size - 1] + 1, string_length(str))
		
	if string_length(sub)
		ds_list_add(ls, sub)
	
	
	var lssize = ds_list_size(ls)
	var arr = array_create(lssize)
	for(i = 0; i < lssize; i++)
		arr[i] = ls[| i];
	
	ds_list_destroy(ls)
	
	return arr
}

function string_strip(str) {
	var len = string_length(str)
	
	var i
	for(i = 1; i < len; i++)
	{
		if string_char(str, i) != " "
			break
	}
	
	var j
	for(j = len; j > 1; j--)
	{
		if string_char(str, j) != " "
			break
	}
	
	return string_str(str, i, j)
}

function string_lsort(str, space) {
	var space_char = argument_count > 2 ? argument[2] : " "
	var len = max(space - string_length(str), 0)
	
	if len <= 0
		return str
	
	var ch = ""
	while(len-- > 0)
		ch += space_char
	
	return str + ch
}

function string_rsort(str, space) {
	var space_char = argument_count > 2 ? argument[2] : " "
	var len = max(space - string_length(str), 0)
	
	if len <= 0
		return str
	
	var ch = ""
	while(len-- > 0)
		ch += space_char
	
	return ch + str
}

function string_msort(str, space) {
	var space_char = argument_count > 2 ? argument[2] : " "
	var len = max(space - string_length(str), 0)
	
	if string_length(space_char) != 1
		space_char = " "
	
	if len <= 0
		return str
	
	var lenleft, lenright;
	lenleft = floor(len / 2)
	lenright = ceil(len / 2)
	
	var chleft = ""
	while(lenleft-- > 0)
		chleft += space_char
		
	var chright = ""
	while(lenright-- > 0)
		chright += space_char
	
	return chleft + str + chright
}

function format(str, argu) {
	var arr = string_group(str, "{}")
	var defindex = 0
	var result = ""
	
	var f = regex_compile(@"\{(\d*)\}")
	var fsort = regex_compile(@"\{(\d*):(.?)([<>^])(\d+)\}")
	
	var i, size;
	size = array_length(arr)
	for(i = 0; i < size; i++)
	{
		var sub = arr[i];
		
		var g;
		var ind, str_t, temp;
		if regex_match(f, sub)
		{
			try {
				g = regex_group_convert(regex_gmatch(f, sub))
				ind = is_digit(g.group[1]) ? real(g.group[1]) : defindex++;
				
				temp = string(argu[ind])
			}
			catch(ex) { temp = "" }
			
			result += temp
		}
		else if regex_match(fsort, sub)
		{
			try {
				var ws_char, sort_type, ws_len;
				
				g = regex_group_convert(regex_gmatch(fsort, sub))
				ind = is_digit(g.group[1]) ? real(g.group[1]) : def_index++;
				
				ws_char = g.group[2]
				sort_type = g.group[3]
				ws_len = real(g.group[4])
				
				temp = string(argu[ind])
				
				switch(sort_type)
				{
					case "<":
						temp = string_lsort(temp, ws_len, ws_char)
					break
					case ">":
						temp = string_rsort(temp, ws_len, ws_char)
					break
					case "^":
						temp = string_msort(temp, ws_len, ws_char)
					break
				}
			}
			catch(ex) { temp = "" }
			
			result += temp
		}
		else
			result += sub
	}
	
	regex_destroy(f)
	regex_destroy(fsort)
	
	return result
} 

function merge_string() {
	var str, nx;
	str = ""
	
	var ind;
	for(var i = 0; i < argument_count; i++)
	{
		ind = argument[i];
		
		if is_bool(ind)
			ind = (ind ? "True" : "False")
		else
			ind = string(ind);
		
		if ind == "\n"
			str += "\n"
		else
			str += ind + " "
	}

	return str
}