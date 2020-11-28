//Memory leak issue
function RegexMatch(match_id) constructor {
	var size = regex_group_size(match_id);
	group = array_create(size);
	
	for(var i = 0; i < size; i++)
		group[i] = regex_group(match_id, i);
	group_size = size;
	
	pre = regex_group_prefix(match_id);
	post= regex_group_postfix(match_id);
}

function regex_group_convert(group_id) {
	var g = new RegexMatch(group_id);
	regex_group_destroy(group_id);
	
	return g
}


/*
#macro re global.regex



function RegexCompile(regex_str) constructor {
	id = regex_compile(regex_str);
	str = regex_str;
	
	check = function() {
		if !regex_exists(id)
			id = regex_compile(str);
	}
	
	replace = function(str, substr) {
		return regex_replace(id, str, substr)
	}
	
	match = function(str) {
		return regex_match(id, str);
	}
	
	search = function(str) {
		return regex_search(id, str);
	}
	
	gmatch = function(str) {
		var g = regex_gmatch(id, str);
		
		if regex_group_exists(g)
		{
			var st = new RegexMatch(g);
			
			regex_group_destroy(g);
			return st;
		}
			
		return undefined;
	}
	
	gsearch = function(str) {
		var g = regex_gsearch(id, str);
		
		if regex_group_exists(g)
		{
			var st = new RegexMatch(g);
			
			regex_group_destroy(g);
			return st;
		}
			
		return undefined;
	}
	
}

re = {
	compile : function(regex_str) {
		return new RegexCompile(regex_str);
	},
	
	match : function(regex_str, str) {
		var regex_id = regex_compile(regex_str);
		var res = regex_search(regex_id, str);
		
		regex_destroy(regex_id);
		return res;
	},
	
	search : function(regex_str, str) {
		var regex_id = regex_compile(regex_str);
		var res = regex_search(regex_id, str);
		
		regex_destroy(regex_id);
		return res;
	},
	
	gmatch : function(regex_str, str) {
		var regex_id = regex_compile(regex_str);
		var match_id = regex_gmatch(regex_id, str);
		
		if regex_group_exists(match_id)
		{
			var st = new RegexMatch(match_id);
			
			regex_group_destroy(match_id);
			return st;
		}
		regex_destroy(regex_id);
			
		return undefined;
	},
	
	gsearch : function(regex_str, str) {
		var regex_id = regex_compile(regex_str);
		var match_id = regex_gsearch(regex_id, str);
		
		if regex_group_exists(match_id)
		{
			var st = new RegexMatch(match_id);
			
			regex_group_destroy(match_id);
			return st;
		}
		regex_destroy(regex_id);
			
		return undefined;
	}
}
/**/