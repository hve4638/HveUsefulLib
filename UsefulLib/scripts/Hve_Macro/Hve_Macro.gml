#macro vk_plus 187
#macro vk_minus 189
#macro vk_grave 192	// ` ~

#macro NL "\n"

#macro copyargument if argument_count > 0									\
					{														\
						argument_array = array_create(argument_count);		\
						for(__i = 0; __i < argument_count; __i++)			\
							argument_array[__i] = argument[__i]				\
					}														\
					else													\
						argument_array = [];

#macro copyargu		if argument_count > 0									\
					{														\
						argument_array = array_create(argument_count);		\
						for(__i = 0; __i < argument_count; __i++)			\
							argument_array[__i] = argument[__i]				\
					}														\
					else													\
						argument_array = [];

function nope() {}

///@argu function_or_method
///@argu arguments
function function_execute(func) {
	if argument_count > 1
	{
		var argu = argument[1]
		
		if is_array(argu)
		{
			switch(array_length(argu))
			{
				case 16: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8], argu[9], argu[10], argu[11], argu[12], argu[13], argu[14], argu[15]); 
				case 15: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8], argu[9], argu[10], argu[11], argu[12], argu[13], argu[14]); 
				case 14: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8], argu[9], argu[10], argu[11], argu[12], argu[13]); 
				case 13: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8], argu[9], argu[10], argu[11], argu[12]); 
				case 12: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8], argu[9], argu[10], argu[11]); 
				case 11: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8], argu[9], argu[10]); 
				case 10: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8], argu[9]); 
				case  9: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7], argu[8]); 
				case  8: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6], argu[7]);
				case  7: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5], argu[6]); 
				case  6: return func(argu[0], argu[1], argu[2], argu[3], argu[4], argu[5]); 
				case  5: return func(argu[0], argu[1], argu[2], argu[3], argu[4]); 
				case  4: return func(argu[0], argu[1], argu[2], argu[3]); 
				case  3: return func(argu[0], argu[1], argu[2]); 
				case  2: return func(argu[0], argu[1]); 
				case  1: return func(argu[0]); 
				case  0: return func();
			
				default:
					throw "function_execute() : Invaild argument (out of range)"
			}
		}
		else
			return func(argu)
	}
	else
		return func(argu)
}