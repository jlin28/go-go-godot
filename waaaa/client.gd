extends Node

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
var server_url := "ws://127.0.0.1:8080"

var socket := WebSocketPeer.new()
var connected = false

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
	
	elif state == WebSocketPeer.STATE_CLOSED:
		if connected:
			print("Disconnected!")
			connected = false
