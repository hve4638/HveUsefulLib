///@argu seed
function randgeneator_xorshift(seed) {
	var a, b;
	a = seed[0];
	b = seed[1];

	seed[@ 0] = b;
	a ^= a << 23;
	seed[@ 1] = a ^ b ^ (a >> 17) ^ (b >> 26);
	
	return seed[1] + b
}

function Rand() constructor {
	seed = [ 123, 456 ]
	
	reset = function() {}
	
	import = function(seed) { self.seed = [ seed[0], seed[1] ] }
	
	export = function() { return [ seed[0], seed[1] ] }
	
	rand = function() { return randgeneator_xorshift(seed) }
	
	next = function() {
		return self.rand()
	}
}

function RandRange(st, ed) : Rand() constructor {
	range = [ st, ed ]
	
	next = function() {
		var st, ed
		var val
		st = range[0]
		ed = range[1]
		val = modulo(self.rand(), ed - st)
		
		return val
	}
}

function RangeChoose() : Rand() constructor {
	array = array_create(argument_count)
		
	var i
	for(i = 0; i < argument_count; i++)
		array[i] = argument[i]
	
	reset = function() {
		array = array_create(argument_count)
		
		var i
		for(i = 0; i < argument_count; i++)
			array[i] = argument[i]
	}
	
	next = function() {
		var size = array_length(self.array)
		var ind
		
		ind = modulo(self.rand(), size)
		
		return array[ind]
	}
}








