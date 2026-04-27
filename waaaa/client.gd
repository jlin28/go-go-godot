extends Node
@export var remote_player_scene: PackedScene # stores remote_player.tscn

#
#void clientLogic(int server_socket){
  #char buff[BUFFER_SIZE];
#
  #while (fgets(buff, BUFFER_SIZE, stdin)) {
	#write(server_socket, buff, strlen(buff));
	#int bytes = read(server_socket, buff, sizeof(buff));
#
	#if (bytes <= 0) {
	  #exit(0);
	#}
	#buff[bytes] = '\0';
	#printf("recieved: %s", buff);
  #}
#
  #close(server_socket);
#}
#
#int main(int argc, char *argv[] ) {
  #char* IP = "127.0.0.1";
  #if(argc>1){
	#IP=argv[1];
  #}
  #int server_socket = client_tcp_handshake(IP);
  #printf("client connected.\n");
  #clientLogic(server_socket);
#}

# test
var server_url := "wss://demo-167-71-189-221.nip.io/ws"

var socket := WebSocketPeer.new()
var connected = false

var my_id = null
var remote_players = {}

#/*Connect to the server
 #*return the to_server socket descriptor
 #*blocks until connection is made.*/
#int client_tcp_handshake(char * server_address) {
#
  #//setup structs for getaddrinfo
  #struct addrinfo * hints, * results;
  #hints = calloc(1,sizeof(struct addrinfo));
  #hints->ai_family = AF_INET;
  #hints->ai_socktype = SOCK_STREAM;
#
  #err(getaddrinfo(server_address, PORT, hints, &results), "getaddrinfo error");
#
  #//create the socket
  #int serverd = socket(results->ai_family, results->ai_socktype, results->ai_protocol);
  #err(serverd, "socket error");
#
  #//connect() to the server
  #err(connect(serverd, results->ai_addr, results->ai_addrlen), "connect error");
#
  #free(hints);
  #freeaddrinfo(results);
#
  #return serverd;
#}
#
#void err(int i, char*message){
  #if(i < 0){
	  #printf("Error: %s - %s\n",message, strerror(errno));
  	#exit(1);
  #}
#}

# Run 1x when entering scene, start server connection!
func _ready():
	var error = socket.connect_to_url(server_url)
	
	if error != OK:
		print("Could not connect to WebSocket server")
	else:
		print("Trying to connect to WebSocket server...")

		
# Run every frame, update connection
func _process(delta):
	socket.poll() # Godot requires this for the socket to update
	
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN: 
		if not connected:
			connected = true
			print("Connected!")
			socket.send_text("GODOT IS HERE")
			
		while socket.get_available_packet_count() > 0: # other waiting messages
			var packet = socket.get_packet().get_string_from_utf8() # converts packet bytes for the one read packet to readable text
			print("From server: ", packet)
			
			var msg = JSON.parse_string(packet) # convert json from node into godot dict
			if msg == null:
				print("json parse couldn't")
				continue
			
			handle_server_msg(msg)
	
	elif state == WebSocketPeer.STATE_CLOSED:
		if connected:
			print("Disconnected!")
			connected = false
			
func handle_server_msg(msg):
	var msg_type = msg.get("type")
	
	if msg_type == "assign_id":
		my_id = msg.get("id")
		print("my id is: ", my_id)
	elif msg_type == "player_joined":
		var player_id = msg.get("id")
		spawn_remote_player(player_id)
	elif msg_type == "player_left":
		var player_id = msg.get("id")
		remove_remote_player(player_id)
		
func spawn_remote_player(player_id):
	if player_id == my_id:
		return
	if remote_players.has(player_id):
		return
	
	var remote_copy = remote_player_scene.instantiate()
	remote_copy.position = Vector3(2 * player_id, 1, 0)
	
	remote_players[player_id] = remote_copy
	
	# I have no idea what this means but I couldn't get it to spawn and searched it up and now my brain is too fried!
	get_tree().current_scene.call_deferred("add_child", remote_copy)
	
func remove_remote_player(player_id):
	if remote_players.has(player_id):
		var remote_player = remote_players[player_id]
		remote_player.queue_free()
		remote_players.erase(player_id)
		print("Removed remote player ", player_id)
	
