function Camera25D(camera_index) : Camera(camera_index) constructor
{
	fov = 90;
	asp = 16 / 9;
	dist = {
		width	: 0,
		height	: -100,
		zoom	: 1.0,
		asp		: asp,	// = 16/9 = 1.78
		set_width : function() {
			if argument_count > 0
				self.width = argument[0];
			
			self.height = floor(self.width / asp);
		},
		set_height : function() {
			if argument_count > 0
				self.height = argument[0];
			
			self.width = floor(self.height * asp);
		},
		set_zoom : function(val) {
			zoom = val;
		},
		get : function() { return - round(self.height / zoom) div 2; }
	}
	
	apply = function() {
		var w = camera_get_view_width(cam) div 2 * (self.origin.x - 0.5);
		var h = camera_get_view_height(cam) div 2 * (self.origin.y - 0.5);
		var ss = shake.get()
		var cam_x = x - w + ss.x
		var cam_y = y - h + ss.y
		
		
		var _viewMat = matrix_build_lookat(cam_x, cam_y, dist.get(), cam_x, cam_y, 0, 0, 1, 0);
		var _projMat = matrix_build_projection_perspective_fov(fov, asp, 3, 30000);

		camera_set_view_mat(cam, _viewMat);
		camera_set_proj_mat(cam, _projMat);

		camera_apply(cam)
	}
	
	camera_size_update = function() {
		//var w, h;
		//w = dist.width * dist.zoom;
		//h = dist.height * dist.zoom;

		//camera_set_view_size(cam, w, h);
		dist.set_zoom(zoom);
		//camera_size_update();
	}

	set_width = function(val) {
		dist.set_width(val);
		
		camera_size_update();
	}
	
	set_height = function(val) {
		dist.set_height(val);
		
		camera_size_update();
	}
	
	set_zoom = function(val) {
	}
	
	border_limit = function() {
		var w, h;
		var ox, oy;
		w = dist.width / dist.zoom;
		h = dist.height / dist.zoom;
		ox = self.origin.x;
		oy = self.origin.y;
		
		to.x = clamp(to.x, border.left + w * ox, border.right - w * (1 - ox));
		to.y = clamp(to.y, border.top + h * oy, border.bottom - h * (1 - oy));
	}
}



