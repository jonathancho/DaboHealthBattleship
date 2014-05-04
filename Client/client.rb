#!/usr/bin/ruby
require 'socket'
require 'scanf'

# establish connection
## We need to tell the client where to connect
## Conveniently it is on localhost at port 2008!
clientSession = TCPSocket.new( "localhost", 2008 )
puts "log: starting connection"
#send a quick message
## Note that this has a carriage return. Remember our server
## uses the method gets() to get input back from the server.
puts "log: saying hello"
clientSession.puts "Client: Hello Server World!\n"
#wait for messages from the server
## You've sent your message, now we need to make sure
## the session isn't closed, spit out any messages the server
## has to say, and check to see if any of those messages
## contain 'Goodbye'. If they do we can close the connection
 while !(clientSession.closed?) &&
          (serverMessage = clientSession.gets)
  ## lets output our server messages
  puts serverMessage

  # if serverMessage.include?("Printing Board")
  # 	$printBoard = true
  # 	for i in 0..9 do
		# 	for j in 0..9 do
		# 		print @board[i][j]
		# 		print " "
		# 		STDOUT.flush
		# 	end
		# 	puts "\n"
		# end
  # end

  if serverMessage.include?("Select")
  	input = scanf("%s")

  	# will need to parse for bs moves later
  	clientSession.puts input
  end

  #if one of the messages contains 'Goodbye' we'll disconnect
  ## we disconnect by 'closing' the session.
  if serverMessage.include?("Goodbye")
   puts "log: closing connection"
   clientSession.close
  end
 end #end loop