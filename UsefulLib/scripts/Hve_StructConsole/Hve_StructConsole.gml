/*function console_create() {
	var struct = new Console();
	struct.this = struct;
	struct.output("console enable");
	
	return struct;
}

function Console() constructor {
	cmdlist = new Map();
	outputlog = new List();
	console_string = "";

	trie = new Trie()
	
	active = false;
	
	autocomplete_array = undefined;
	autocomplete_index = undefined;
	
	command_add = function (func) {
		var str = func.cmd
		
		if is_method(func.execute)
			func.execute = method(self, func.execute)
		
		cmdlist.set(str, func)
		trie.insert(str)
	}
	
	input = function() {
		if !active
			return false;

		if keyboard_lastkey == -1
			return false;
		
		switch(keyboard_lastkey)
		{
			case vk_backspace:
				console_string = string_str(console_string, 1, -2)
				autocomplete_update()
				break

			case vk_enter:
				if string_length(console_string) > 0
				{
					var it = iter(string_split(console_string))
					it.init()
					
					command_active(cmdlist, it, ptr(self))
					
					console_string = ""
					autocomplete_update()
				}
				break
		
			case vk_tab:
				if is_undefined(autocomplete_array) or array_length(autocomplete_array) == 0
					break
			
				autocomplete_index = modulo(autocomplete_index + 1, array_length(autocomplete_array))
				console_string = autocomplete_array[autocomplete_index]
				break

			default:
				console_string += keyboard_string
				autocomplete_update()
				break
		}
		keyboard_string = ""
		keyboard_lastkey = -1

		return true;
	}
	
	output = function() {
		copyargument
		outputlog.push(function_execute(merge_string, argument_array));
	}
	
	autocomplete_update = function() {
		autocomplete_array = trie.find(console_string)
		autocomplete_index = 0
	}
	
	enable = function() { active = true; keyboard_lastkey = -1; keyboard_string = "" }
	
	disable = function() { active = false; }
	
	draw = function() {
		if !active
			return false;

		var undoset = new DrawSet()
		draw_set_alpha(1.0)
		draw_set_color(c_white)
		
		var w = room_width
		var h = room_height
		draw_rectangle_ext(0, 0, w, h, c_black, 0.7)

		var strh = font_height()
		var hsize = (h div strh) - 1
		
		var start = max(0, outputlog.size() - hsize)
		var hlen = min(hsize, outputlog.size())

		for(var i = 0 ; i < hlen; i++)
			draw_text(0, (i) * strh, outputlog.get(start + i))
		draw_text(0, (hsize + 0.5) * strh, console_string)
		
		//autocomplete list
		if array_length(autocomplete_array) > 0
		{
			var str = ""
			var len = array_length(autocomplete_array)

			for(var i = 0; i < len; i++)
				str += autocomplete_array[i] + NL;
			
			var x1, x2, y1, y2;
			x1 = 0
			y1 = (hsize + 0.5 - len) * strh
			x2 = w
			y2 = (hsize + 0.5) * strh
			draw_rectangle_ext(x1, y1, x2, y2, c_black, 0.7)
			
			draw_set_valign(fa_bottom)
			draw_text(0, (hsize + 0.5) * strh, str)
		}
		
		undoset.set()
	}
	
	free = function() {
		cmdlist.free()
		outputlog.free()
	}
}

function console_set_cmd(console) {
	var push = console.command_add

	push({
		cmd : "restart",
		type : eCmdType.execute,
		cmdlist : undefined,
		execute : function(it) {
			game_restart();
		}
	})
	
	push({
		cmd : "test",
		type : eCmdType.execute,
		cmdlist : undefined,
		execute : function(it) {
			while(true)
			{
			}
			output()
		}
	})

	push({
		cmd : "clear",
		type : eCmdType.execute,
		redirect : undefined,
		cmdlist : undefined,
		execute : function(it) {
			outputlog.clear();
		}
	});
	/**/
	/*
	{
		cmd : "temp",
		type : eCmdType.nop,
		redirect : undefined,
		cmdlist : undefined,
		execute : undefined
	}
	/**/
	/*
}

///@argu cmd list
///@argu iter
///@argu main console
function command_active(cmd, it, console) {
	var func
	
	func = iterator_next(func)
	
	if is_undefined(func)
		return 0

	switch(func.type)
	{
		case eCmdType.redirect:
			func = cmd[? func.redirect]
					
			if is_undefined(func)
				console.output("Unknown Command : ", cmd)
		break
			
		case eCmdType.execute:
			func.execute(it)
		break
			
		case eCmdType.nop:
			console.output("nop")
		break
	}
}

enum eCmdType
{
	execute,
	compare,
	redirect,
	nop
}
/**/