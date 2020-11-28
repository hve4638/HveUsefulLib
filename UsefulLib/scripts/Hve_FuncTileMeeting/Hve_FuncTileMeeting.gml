///@desc tile_cling
///@param x
///@param y
///@param tilemap_element_id
function tile_cling(xx, yy, tilemap_eleid) {
	var b_right, b_left, b_top, b_bottom;
	b_right = xx + (bbox_right - x)
	b_left = xx + (bbox_left - x)
	b_top = yy + (bbox_top - y)
	b_bottom = yy + (bbox_bottom - y)
	
	var lt, rt, lb, rb;
	lt = tilemap_get_at_pixel(tilemap_eleid, b_left, b_top)
	rt = tilemap_get_at_pixel(tilemap_eleid, b_right, b_top)
	lb = tilemap_get_at_pixel(tilemap_eleid, b_left, b_bottom)
	rb = tilemap_get_at_pixel(tilemap_eleid, b_right, b_bottom)
	
	var iscollision;
	iscollision = (lt && rt) || (lb && rb) || (lb && lt) || (rb && rt);
	
	return iscollision
}

///@desc tile_meeting
///@param x
///@param y
///@param tilemap_element_id
function tile_meeting(xx, yy ,tilemap_eleid) {
	var b_right, b_left, b_top, b_bottom;
	b_right = xx + (bbox_right - x)
	b_left = xx + (bbox_left - x)
	b_top = yy + (bbox_top - y)
	b_bottom = yy + (bbox_bottom - y)
	
	var lt, rt, lb, rb;
	lt = tilemap_get_at_pixel(tilemap_eleid, b_left, b_top)
	rt = tilemap_get_at_pixel(tilemap_eleid, b_right, b_top)
	lb = tilemap_get_at_pixel(tilemap_eleid, b_left, b_bottom)
	rb = tilemap_get_at_pixel(tilemap_eleid, b_right, b_bottom)
	
	var iscollision;
	iscollision = (lt || rt || lb || rb)
	
	return iscollision
}

///@param x
///@param y
///@param obj
///@param list
function instance_cling_list(xx, yy, obj, ls) {
	var b_right, b_left, b_top, b_bottom;
	b_right = xx + (bbox_right - x)
	b_left = xx + (bbox_left - x)
	b_top = yy + (bbox_top - y)
	b_bottom = yy + (bbox_bottom - y)
	
	var lt, rt, lb, rb;
	lt = instance_position(b_left, b_top, obj);
	rt = instance_position(b_right, b_top, obj);
	lb = instance_position(b_left, b_bottom, obj);
	rb = instance_position(b_right, b_bottom, obj);
	
	if (lt && rt)
		ds_list_add(ls, [lt, rt])

	if (lb && rb)
		ds_list_add(ls, [lb, rb])

	if (lb && lt)
		ds_list_add(ls, [lb, lt])
		
	if (rb && rt)
		ds_list_add(ls, [rb, rt])

	return ds_list_size(ls);
}

///@param x
///@param y
///@param tilemap_element_id
///@param list
function tile_place_list(xx, yy, tilemap_eleid, list) {
	var s = tilemap_meeting_pixel(xx, yy, tilemap_eleid);
	
	if s.lt
		ds_list_add(list, s.lt);
	if s.rt
		ds_list_add(list, s.rt);
	if s.lb
		ds_list_add(list, s.lb);
	if s.rb
		ds_list_add(list, s.rb);
	
	return ds_list_size(list);
}

///@param x
///@param y
///@param tilemap_element_id
///@param list
function tile_cling_list(xx, yy, tilemap_eleid, list) {
	var s = tilemap_meeting_pixel(xx, yy, tilemap_eleid);

	if (s.lt && s.rt)
		ds_list_add(list, [s.lt, s.rt]);

	if (s.lb && s.rb)
		ds_list_add(list, [s.lb, s.rb]);

	if (s.lb && s.lt)
		ds_list_add(list, [s.lb, s.lt]);
		
	if (s.rb && s.rt)
		ds_list_add(list, [s.rb, s.rt]);
	
	return ds_list_size(list);
}

///@param x
///@param y
///@param tilemap_element_id
function tilemap_meeting_pixel(xx, yy, tilemap_eleid) {
	var b_right, b_left, b_top, b_bottom;
	b_right = xx + (bbox_right - x)
	b_left = xx + (bbox_left - x)
	b_top = yy + (bbox_top - y)
	b_bottom = yy + (bbox_bottom - y)
	
	var s = {}
	s.lt = tilemap_get_at_pixel(tilemap_eleid, b_left, b_top)
	s.rt = tilemap_get_at_pixel(tilemap_eleid, b_right, b_top)
	s.lb = tilemap_get_at_pixel(tilemap_eleid, b_left, b_bottom)
	s.rb = tilemap_get_at_pixel(tilemap_eleid, b_right, b_bottom)
	
	
	return s;
}







