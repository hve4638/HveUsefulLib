///@argu spr
///@argu img*
///@argu spd*
function sprite_change(spr) {
	var img, spd;
	img = argument_count > 1 ? argument[1] : 0;
	spd = argument_count > 2 ? argument[2] : image_speed;

	sprite_index = spr;
	image_index = img;
	image_speed = spd;
}

function sprite_get_frame(spr) {
	var spd, type, res, size;
	
	spd = sprite_get_speed(spr);
	type = sprite_get_speed_type(spr);
	res = 0;
	
	switch(type)
	{
		case spritespeed_framespergameframe:
			return (1 / spd)
		
		case spritespeed_framespersecond:
			return room_speed / spd
	}
}

function sprite_get_size() {
	var xs, ys;
	var spr = sprite_index;

	xs = abs(image_xscale * sprite_get_width(spr));
	ys = abs(image_yscale * sprite_get_height(spr));

	return [xs, ys];
}

function sprite_set_size(w, h) {
	var spr = sprite_index
	
	var xsign, ysign
	xsign = sign(image_xscale)
	ysign = sign(image_yscale)
	
	if !xsign xsign = 1
	if !ysign ysign = 1

	image_xscale = w / sprite_get_width(spr) * xsign
	image_yscale = h / sprite_get_height(spr) * ysign
}