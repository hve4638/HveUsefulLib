function Timer() constructor
{
	run = function() {
		timer_run = true;
		timer_start = current_time;
	}

	stop = function() {
		timer_run = false;
		timer_end = current_time;
		
		return (timer_end - timer_start);
	}
	
	reset = function() {
		timer_start = current_time;
		timer_end = current_time;
	}
	
	isrun = function() { return timer_run; }
	
	get = function() {
		if timer_run
			return (current_time - timer_start);
		else
			return (timer_end - timer_start);
	}
	
	delta = function() {
		var dt = current_time - delta_previous;
		
		delta_previous = current_time;
		return dt;
	}

	timer_run = false;
	timer_start = current_time;
	timer_end = current_time;
	delta_previous = current_time;
}