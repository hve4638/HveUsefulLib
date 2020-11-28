///@argu hold
///@argu pressed
///@argu released
function keyboard_input() {
	var h, p, r;
	h = argument_count > 0 ? argument[0] : undefined;
	p = argument_count > 1 ? argument[1] : undefined;
	r = argument_count > 2 ? argument[2] : undefined;
	
	return new KeyboardInput(h, p, r)
}

function KeyboardInput(h, p, r) constructor {
	hold = undefined
	press = undefined
	release = undefined
	
	check = function() {
		res = true
		
		if res foreach(hold, function(key) { res = (res && keyboard_check(key)) })
		if res foreach(press, function(key) { res = (res && keyboard_check_pressed(key)) })
		if res foreach(release, function(key) { res = (res && keyboard_check_released(key)) })
		
		return res
	}
	
	reset = function(h, p, r) {
		hold    = is_array(h) ? h : (!is(h, undefined) ? [h] : []);
		press   = is_array(p) ? p : (!is(p, undefined) ? [p] : []);
		release = is_array(r) ? r : (!is(r, undefined) ? [r] : []);
		
		hold = iter(hold)
		press = iter(press)
		release = iter(release)
	}
	
	self.reset(h, p, r)
}

function MouseDrag() constructor {
	enable = false
	ondrag = false
	
	mb_type = mb_left
	
	first = { x : 0, y : 0 }
	second = { x : 0, y : 0 }
	
	step = function() {
		if enable && mouse_check_button_pressed(mb_type)
		{
			enable = false
			ondrag = true
			
			first.x = mouse_x;
			first.y = mouse_y;
		}
		
		if ondrag
		{
			if !mouse_check_button(mb_type)
				ondrag = false
			
			second.x = mouse_x;
			second.y = mouse_y;
		}
	}
	
	draw = function() {
		draw_rectangle_color(first.x, first.y, second.x, second.y, c_green, c_green, c_green, c_green, true)
	}
}








