function round_toward_zero(x) { return - sign(x) * floor( - abs(x) + 0.5 ); }

function round_toward_inf(x) { return - sign(x) * floor( - abs(x) - 0.5 ); }

///@param value
///@param divide
function modulo(val, _div)
{
	if _div == 0
		return NaN
	
	var isneg = (_div < 0)
	val = val mod abs(_div)
	
	if !isneg
		return (val >= 0) ? val : val + _div
	else
		return (val <= 0) ? val : val - _div
}

///@desc return 0~1
///@argu index
///@argu cycle
function floating(ind, cycle)
{
	var i, res;

	i = (ind) * 360 / cycle
	res = 1 - (dcos(i) + 1) * 0.5;

	return res;
}

function invlerp(st, ed, val)
{
	var r = ed - st;
	val -= st;
	
	return val / r;
}

///@argu	array
///@argu	interpolate
function lerp_array(arr, p) {
	p = clamp(p, 0.0, 1.0);

	if is_array(arr)
	{
		var res, size;
		var n, a, b;
		size = array_length(arr) - 1;
		n = p * size;
		a = floor(n);
		b = ceil(n);
		res = lerp(arr[a], arr[b], n - a);
	
		return res;
	}
	return undefined;
}


function value_move_to(from, to, spd) {
	if abs(from - to) <= spd
		return to;
	else if from < to
		return (from + spd);
	else
		return (from - spd);
}

function floor_toward_zero(val) {
	return 0 < val ? floor(val) : ceil(val)
}