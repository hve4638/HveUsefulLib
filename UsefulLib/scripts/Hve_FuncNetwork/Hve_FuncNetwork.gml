function NetworkHost() constructor {
	port = 55555;
	maxclient = 8;
	socket_type = network_socket_tcp;
	socket = -1;
	
	client = map();
	
	open = function() {
		socket = network_create_server(socket_type, port, maxclient);
		
		if socket >= 0
			return true
		else
			return false
	}
	
	close = function() {
		if socket >= 0
			network_destroy(socket);
	}
	
	test = function() {
		switch(async_load[? "type"])
		{
		case network_type_connect:
			client.add(client, async_load[? "socket"])
		break
		
		case network_type_disconnect:
			client.remove(client, async_load[? "socket"])
		break
		}
	}
}


function NetworkClient() constructor {
	ip = "127.0.0.1"
	port = 55555;
	socket_type = network_socket_tcp;
	socket = -1;
	
	connect = function() {
		socket = network_create_socket(network_socket_tcp);
		
		if socket >= 0
		{
			if network_connect(socket, ip, port)
				return true	
			else
				return false
		}
		else
			return false
	}
	
	disconnect = function() {
		if socket >= 0
			network_destroy(socket);
	}
}

function PacketBuffer()
{
	buf = buffer_create(1, buffer_grow, 1);	
	
	reset = function() { buffer_seek(buf, buffer_seek_start, 0); }
	
	write = function(type, value) { buffer_write(buf, type, value); }
	
	send = function(socket) { return network_send_packet(socket, buf, buffer_tell(buf)); }
	
	free = function() { buffer_delete(buf); }
}