function Camera(cam_index) constructor {
#region private
	camera_index = !is_undefined(cam_index) ? cam_index : 0;

	//camera_enable(camera_index)
	cam = view_camera[camera_index]
	
	view_size = { w : 0, h : 0, zoom : 1.0 }
	view_width = 0;
	view_height = 0;
	
	to = { x : 0, y : 0, zoom : 1.0 }
	x = 0; y = 0;
	zoom = 1.0;
	pzoom = 1.0;

	border = {
		enable : false,
		left : 0, right : 0, top : 0, bottom : 0
	}
	
	origin = { x : 0.5, y : 0.5 }
	
	time_index = {
		add : function() { index++ },
		get : function() { return index },
		index : 0
	}
	
	time_idx = time_index;
	
	shake = {
		struct : new PriorityQueue(),
		pow : 0,
		pow_dec : 1,
		time_idx : time_idx,
		x : 0, y : 0,
		
		previous : { x : 0, y : 0 },
		get : function(time) {
			pow = max(pow - pow_dec, 0)
			while(!struct.empty())
			{
				var s = struct.top()
				if s.time > time_idx.get()
				{
					pow = s.pow
					break
				}
				else
					struct.pop_top()
			}
			
			var xx = 0, yy = 0;
			if pow > 0
			{
				var dir = irandom(360)
				xx = xdir(dir) * pow
				yy = xdir(dir) * pow
			}

			return { x : xx, y : yy }
		},

		set : function(_pow, _time) {
			var st = {
				pow : _pow,
				time: _time
			}
			return st
		},
		free : function() { struct.free(); }
	}

	follow = {
		ls : new List(),
		divide : 9,
		divide_zoom : 5,
		add_position : function(xx, yy) {
			var st = {
				type : "position",
				x : xx,
				y : yy
			}
			ls.push(st)
		},
		add_object : function(obj) {
			var st = {
				type : "object",
				id : obj
			}
			ls.push(st)
		},
		reset : function() { ls.clear(); },
		free : function() { ls.free(); }
	}
	
	camera_size_update = nope;
	
	update_pos = function() {
		sumx = 0;
		sumy = 0; 
		sumcnt = 0;
		
		foreach(follow.ls, function(this) {
			switch(this.type)
			{
				case "position":
					sumx += this.x;
					sumy += this.y;
					sumcnt += 1;
				break
				case "object":
					var _x, _y, _cnt;
					_x = 0; _y = 0; _cnt = 0;
					with(this.id)
					{
						_x += x;
						_y += y;
						_cnt ++;
					}
					sumx += _x;
					sumy += _y;
					sumcnt += _cnt;
				break
			}
		});

		if sumcnt > 0
		{
			to.x = sumx div sumcnt;
			to.y = sumy div sumcnt;
		}
		
		if border.enable
			self.border_limit();
	}
	
	update_zoom = function() {
		if zoom != pzoom
		{
			camera_size_update();
			pzoom = zoom;
		}
	}
	
	update = function() {
		update_pos();
		
		var dv = follow.divide;
		var addx, addy;
		addx = round((to.x - x) / dv);
		addy = round((to.y - y) / dv);
		
		x += round((to.x - x) / dv);
		y += round((to.y - y) / dv);
		
		zoom += (to.zoom - zoom) / follow.divide_zoom;
		
		update_zoom();
	}
	
#endregion

#region need overriding
	apply = nope;
	set_size = nope;
	set_width = nope;
	set_height = nope;
	camera_size_update = nope;
	border_limit = nope;
#endregion

#region public
	enable = function() { view_visible[camera_index] = true; }
	
	disable = function() { view_visible[camera_index] = false; }
	
	screenshake = function(_pow, _time) {
		var st = {
			pow : _pow,
			time : _time + time_idx.get()
		}
		
		shake.struct.push(st, st.pow)
	}
	
	instant_update = function() {
		update_pos();
		update_zoom();
		
		x = to.x;
		y = to.y;
	}
	
	follow_object = function(obj) { follow.add_object(obj); }
	
	follow_position = function(x, y) { follow.add_position(x, y); }
	
	follow_zoom = function(val) { to.zoom = val; }
	
	follow_reset = function() { follow.reset(); }
	
	set_zoom = function(val) {
		zoom = val;
		camera_size_update();
	}
	
	set_zoom_force = function(val) {
		to.zoom = val;
		zoom = val;
		camera_size_update();
	}
	
	set_origin = function(_x, _y) {
		self.origin.x = _x;
		self.origin.y = _y;
	}
	
	set_border_room = function() {
		self.border.left	= 0;
		self.border.right	= room_width;
		self.border.top		= 0;
		self.border.bottom	= room_height;
	}
		
	set_port_pos = function(x, y) {
		view_set_xport(camera_index, x);
		view_set_yport(camera_index, y);
	}
	
	set_port_size = function(w, h) {
		view_set_wport(camera_index, w);
		view_set_hport(camera_index, h);
	}
	
	set_border_room = function() {
		self.border.left	= 0;
		self.border.right	= room_width;
		self.border.top		= 0;
		self.border.bottom	= room_height;
	}
	
	step = function() {
		update();
		time_index.add();
		apply();
	}
		
	destroy = function() {	
		free();	
	}
	
	free = function() {
		follow.free();
		shake.free();
		
		delete follow;
		delete shake;
	}
#endregion
}




