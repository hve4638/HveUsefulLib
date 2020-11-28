function Particle() constructor {
	part_system = -1;
	part_type = -1;
	part_emitter = -1;
	
	depth = -1;
	shape = pt_shape_sphere;
	size = {
		range : [1.0, 1.0],
		inc : 0,
		wiggle : 0
	}
	scale = {
		x : 1,
		y : 1
	}
	color = [c_red]
	alpha = [1.0]
	speed = {
		range : [1.0, 1.0],
		inc : 0,
		wiggle : 0
	}
	direction = {
		range : [1.0, 1.0],
		inc : 0,
		wiggle : 0
	}
	gravity = {
		amount : 0,
		direction : 270
	}
	orientation = {
		range : [0, 0],
		inc : 0,
		wiggle : 0,
		relative : true
	}
	blend = false
	life = [25, 50]
	
	shape = true
	distribution = true
	
	declare = function() {
		part_system = part_system_create();
		part_type = part_type_create();
		part_system_depth(part_system, depth);
		part_type_shape(part_type, shape);
		part_type_size(part_type, size.range[0], size.range[1], size.inc, size.wiggle);
		part_type_scale(part_type, scale.x, scale.y);
		
		switch(array_size(color))
		{
			case 1:
				part_type_color1(part_type, color[0]);
			break
			case 2:
				part_type_color2(part_type, color[0], color[1]);
			break
			case 3:
				part_type_color3(part_type, color[0], color[1], color[2]);
			break
		}
		
		switch(array_size(alpha))
		{
			case 1:
				part_type_color1(part_type, alpha[0]);
			break
			case 2:
				part_type_color2(part_type, alpha[0], alpha[1]);
			break
			case 3:
				part_type_color3(part_type, alpha[0], alpha[1], alpha[2]);
			break
		}
		
		part_type_speed(part_type, speed.range[0], speed.range[1], speed.inc, speed.wiggle);
		part_type_direction(part_type, direction.range[0], direction.range[1], direction.inc, direction.wiggle);
		part_type_gravity(part_type, gravity.amount, gravity.direction);
		part_type_orientation(part_type, orientation.range[0], orientation.range[1], orientation.inc, orientation.wiggle, orientation.relative);
		part_type_blend(part_type, blend);
		part_type_life(part_type, life[0], life[1]);
		
		part_emitter = part_emitter_create(part_system);
		shape = true
		distribution = true
	}
	
	free = function() {
		part_system_destroy(part_system);
	}
	
	emit = function(x1, x2, y1, y2, num) {
		part_emitter_region(part_system, part_emitter, x1, x2, y1, y2, shape, dis);
		part_emitter_burst(part_system, part_emitter, part_type, num);
	}
}