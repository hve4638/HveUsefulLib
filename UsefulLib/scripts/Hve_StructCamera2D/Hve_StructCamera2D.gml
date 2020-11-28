function Camera2D(cam_index) : Camera(cam_index) constructor {	
	apply = function() {
		var w = camera_get_view_width(cam) * self.origin.x;
		var h = camera_get_view_height(cam) * self.origin.y;
		var cam_x = x - w;
		var cam_y = y - h;
		var ss = shake.get()
		
		cam_x += ss.x;
		cam_y += ss.y;

		camera_set_view_pos(cam, cam_x, cam_y)
	}
	
	camera_size_update = function() {
		var w, h;
		w = round(view_width / zoom);
		h = round(view_height / zoom);
		
		camera_set_view_size(cam, w, h);
	}

	set_size = function(w, h) {
		view_width = w;
		view_height = h;
		
		camera_size_update();
	}

	border_limit = function() {
		var w, h;
		var ox, oy;
		w = camera_get_view_width(cam);
		h = camera_get_view_height(cam);
		ox = self.origin.x;
		oy = self.origin.y;
		
		to.x = clamp(to.x, border.left + w * ox, border.right - w * (1 - ox));
		to.y = clamp(to.y, border.top + h * oy, border.bottom - h * (1 - oy));
	}
}