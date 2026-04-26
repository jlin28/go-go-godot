// Node Websocket ver of old systems lab:

// #include "networking.h"
// #include <stdio.h>
// #include <stdlib.h>
// #include <unistd.h>
// #include <fcntl.h>
// #include <sys/types.h>
// #include <sys/stat.h>
// #include <string.h>
// #include <errno.h>
// #include <signal.h>
// #include <sys/wait.h>
// #include <sys/socket.h>
// #include <netdb.h>
//
//
// #ifndef NETWORKING_H
// #define NETWORKING_H
// #define PORT "19230"
// #define BUFFER_SIZE 1024
// void err(int i, char*message);
// int server_setup();
// int client_tcp_handshake(char*server_address);
// int server_tcp_handshake(int listen_socket);

const WebSocket = require("ws");
const PORT = 8080;

// /*Create and bind a socket.
// * Place the socket in a listening state.
// * returns the socket descriptor
// */
// int server_setup() {
//   //setup structs for getaddrinfo
//   struct addrinfo * hints, * results;
//   hints = calloc(1,sizeof(struct addrinfo));
//   hints->ai_family = AF_INET;
//   hints->ai_socktype = SOCK_STREAM;
//   hints->ai_flags = AI_PASSIVE;
//
//   err(getaddrinfo(NULL, PORT, hints, &results), "getaddrinfo error");
//
//   //create the socket
//   int clientd = socket(results->ai_family, results->ai_socktype, results->ai_protocol);
//
//   //this code should get around the address in use error
//   int yes = 1;
//   int sockOpt = setsockopt(clientd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes));
//   err(sockOpt,"sockopt  error");
//
//   //bind the socket to address and PORT
//   err(bind(clientd, results->ai_addr, results->ai_addrlen), "bind error");
//
//   //set socket to listen state
//   err(listen(clientd, 10), "listen error");
//
//   //free the structs used by getaddrinfo
//   free(hints);
//   freeaddrinfo(results);
//
//   return clientd;
// }

const wss = new WebSocket.Server({ port: PORT });
let nextPlayerId = 1;

// void subserver_logic(int client_socket){
//   while (1) {
//     char buff[BUFFER_SIZE];
//     int bytes = read(client_socket, buff, sizeof(buff));
//
//     if (bytes <= 0) {
//       exit(0);
//     }
//     buff[bytes] = '\0';
//     write(client_socket, buff, bytes);
//   }
//
//   close(client_socket);
//   exit(0);
// }

// int main(int argc, char *argv[] ) {
//   int listen_soc = server_setup();
//   while (1) {
//
//     int client_soc = server_tcp_handshake(listen_soc);
//
//     int f = fork();
//     if (f == 0) { // child
//       close(listen_soc);
//       subserver_logic(client_soc);
//     } else {
//       close(client_soc);
//     }
//   }
// }

wss.on("connection", (socket) => {
  const playerId = nextPlayerId++;
  console.log(`Player ${playerId} connected`);

  // writing to client socket
  socket.send(JSON.stringify({
    test: "HELP!!!",
    id: playerId
  }));

  // reading/listening for msg
  socket.on("message", (data) => {
    const test = data.toString();
    console.log(`Received from Player ${playerId}: ${test}`);

    // server response
    socket.send(JSON.stringify({
    message: `Server received: ${test}`
    }));
  });

  // disconnection
  socket.on("close", () => {
    console.log(`Player ${playerId} disconnected`);
  });
});

console.log(`Work!??? ws://127.0.0.1:${PORT}`);
