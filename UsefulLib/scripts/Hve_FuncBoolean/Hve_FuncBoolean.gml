function is_integer(val) { return (val - floor(val)) == 0; }

function is_digit(str) { return (0 < string_length(str) and string_digits(str) == str) }

///@argu ins
function is_room_outside()
{
	var ins = argument_count > 0 ? argument[0] : self;

	return (ins.bbox_right < 0 or ins.bbox_left > room_width or ins.bbox_bottom < 0 or ins.bbox_top > room_height);
}