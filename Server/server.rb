#!/usr/bin/ruby
require 'socket'

class Match
	def initialize(player1, player2)
		puts "match initialize called\n"
		@player1 = player1
		@player2 = player2
		@board[0][0] = 10;
		#@board[[0, 1]] = 2;
		#@board[[0, 2]] = 3;
		puts "match initialize done\n"
	end

	def printboard()
		@player1.puts "testing Player 1\n"
		@player2.puts "testing Player 2\n"
	end

	@player1
	@player2
	@board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
end

puts "Starting up server..."

queueArray = Array.new()
matchArray = Array.new()

# establish the server
## Server established to listen for connections on port 2008
server = TCPServer.new(2008)
# setup to listen and accept connections
while (session = server.accept)
 #start new thread conversation
 ## Here we will establish a new thread for a connection client
 Thread.start do
   ## I want to be sure to output something on the server side
   ## to show that there has been a connection
   puts "log: Connection from #{session.peeraddr[2]} at
          #{session.peeraddr[3]}"
   puts "log: got input from client"
   ## lets see what the client has to say by grabbing the input
   ## then display it. Please note that the session.gets will look
   ## for an end of line character "\n" before moving forward.
   input = session.gets
   puts input
   ## Lets respond with a nice warm welcome message
   session.puts "Server: Welcome #{session.peeraddr[2]} Waiting for Additional Players\n"

   queueArray.push(session)

   if queueArray.size  >= 2
   	puts "we have multiple people!\n"
   	match = Match.new(queueArray[0], queueArray[1])
   	puts "adding to array\n"
   	matchArray.push(match)
   	puts "clearing queue array\n"
   	queueArray.clear
   	match.printboard
   	puts "stupid crap\n"
   end

   # reply with goodbye
   ## now lets end the session since all we wanted to do is
   ## acknowledge the client
   #puts "log: sending goodbye"
   #session.puts "Server: Goodbye\n"
 end  #end thread conversation
end   #end loop