#!/usr/bin/env ruby

require 'socket'

#socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)
#socket.connect(Socket.pack_sockaddr_in(9999, "localhost"))
server = TCPServer.new(4444)
 
while true
	s = server.accept
	puts "Connection"
	
	while true
		input = STDIN.gets
		
		if input == "exit"
			break
		end

		s.puts STDIN.gets
		s.recv(1024)
	end

	s.close
end

server.close

