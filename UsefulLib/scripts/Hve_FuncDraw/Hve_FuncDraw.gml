function draw_rectangle_ext(x1, y1, x2, y2, col, alpha, outline) {
	var palpha = draw_get_alpha()
	var pcol = draw_get_color()
			
	draw_set_color(col)
	draw_set_alpha(alpha)
	draw_rectangle(x1, y1, x2, y2, outline)
			
	draw_set_color(pcol)
	draw_set_alpha(palpha)
}

///@arg x
///@arg y
function draw_self_pos(xx, yy) { draw_sprite_ext(sprite_index, image_index, xx, yy, image_xscale, image_yscale, image_angle, image_blend, image_alpha); }

function draw_set_reset() {
	draw_set_font(-1)
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_alpha(1.0)
}

function DrawSprite() constructor {
	sprite  = -1;
	subimg  = 0;
	x		= 0;
	y		= 0;
	xscale  = 1.0;
	yscale  = 1.0;
	rot		= 0.0;
	blend	= c_white;
	alpha	= 1.0;
	
	draw	= function() {
		if sprite_exists(sprite) draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, blend, alpha);
	}
	
	update  = function(ast) {
		if is_numeric(ast)
		{
			if ast == self
				ast = other
			
			if instance_exists(ast)
			{
				self.sprite = ast.sprite_index;
				self.subimg = ast.image_index;
				self.x      = ast.x;
				self.y      = ast.y;
				self.xscale = ast.image_xscale;
				self.yscale = ast.image_yscale;
				self.rot	= ast.image_angle;
				self.blend  = ast.image_blend;
				self.alpha  = ast.image_alpha;
			}
		}
		else if instanceof(ast) == "DrawSprite"
		{
			self.sprite = ast.sprite
			self.subimg = ast.subimg
			self.x      = ast.x     
			self.y      = ast.y     
			self.xscale = ast.xscale
			self.yscale = ast.yscale
			self.blend  = ast.blend
			self.alpha  = ast.alpha
		}
	}
	
	reset = function(spr, subimg, xx, yy, xs, ys, rot, blend, alpha)
	{
		self.sprite = spr
		self.subimg = subimg
		self.x      = xx
		self.y      = yy
		self.xscale = xs
		self.yscale = ys
		self.rot	= rot
		self.blend  = blend
		self.alpha  = alpha
	}
		
	if argument_count > 0
		self.update(argument[0])
}

function DrawSet() constructor {
	font   = draw_get_font()
	alpha  = draw_get_alpha()
	color  = draw_get_color()
	halign = draw_get_halign()
	valign = draw_get_valign()
	
	set	   = function() {
		draw_set_font(self.font);
		draw_set_color(self.color);
		draw_set_halign(self.halign);
		draw_set_valign(self.valign);
		draw_set_alpha(self.alpha);
	}
}
