function pdir(x, y) { return point_direction(0, 0, x, y); }

function pdis(x, y) { return point_distance(0, 0, x, y); }

function xdir(dir) { return lengthdir_x(1, dir); }

function ydir(dir) { return lengthdir_y(1, dir); }

function tilemap_id(layername) {
	var lid = layer_get_id(layername);
	
	if lid >= 0
		return layer_tilemap_get_id(layer_get_id(layername));
	else
		return -1;
}

function rgb(r, g, b) { return make_color_rgb(r, g, b); }

function hsv(h, s, v) { return make_color_hsv(h, s, v); }

function timeline_reset(index) {
	timeline_index = index;
	timeline_position = 0;
	timeline_speed = 1;
	timeline_loop = false;
	timeline_running = true;
}

function timeline_play() { timeline_running = true }

function timeline_stop() {
	timeline_running = false
	timeline_index = 0
}

function timeline_pause() { timeline_running = false }

function is_single() {
	return instance_number(object_index) == 1
}

function sleep(ms) {
	var c = current_time
	var t = 0;
	while(current_time - c < ms)
		t = 0;
}

function font_height() { return string_height(" ") }

function is(val1, val2) {
	return typeof(val1) == typeof(val2) and val1 == val2
}

function ds_list_demark(ls) {
	var i
	var pos = ds_list_size(ls) - 1
	
	for(i = pos; i >= 0; i--)
		ds_list_delete(ls, i);
}

function resolution_reset(w, h) {
	window_set_size(w, h);
	surface_resize(application_surface, w, h);
}

function camera_enable(index) {
	view_enabled = true;
	view_visible[index] = true;
}
