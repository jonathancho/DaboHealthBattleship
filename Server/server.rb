#!/usr/bin/ruby
require 'socket'

class SparseArray
  attr_reader :hash

  def initialize
    @hash = {}
  end

  def [](key)
    hash[key] ||= {}
  end

  def rows
    hash.length   
  end

  alias_method :length, :rows
end

class Match
	def initialize(player1, player2)
		puts "match initialize called\n"
		@player1 = player1
		@player2 = player2
		@board = SparseArray.new()

		for i in 0..9 do
			for j in 0..9 do
				@board[i][j] = 0
			end
		end
		#@board[3][7] = 7
		# @board[0][1] = 2
		# @board[0][2] = 3
		# @board[0][3] = 4
		# @board[0][4] = 5
		# @board[0][5] = 6
		# @board[0][6] = 7
		# @board[0][7] = 8
		# @board[0][8] = 9
		# @board[0][9] = 10
		#@board = [[1, 2, 3] [4, 5, 6], [7, 8, 9]]
		#@board[0][0]= 10;
		#@board[[0, 1]] = 2;
		#@board[[0, 2]] = 3;
		puts "match initialize done\n"
	end

	def printboard()
		$i = 0
		$j = 0
		while $i < 10 do
			while $j < 10 do
				@player1.print @board[$i][$j]
				@player1.print " "
				@player2.print @board[$i][$j]
				@player2.print " "
				@player1.flush
				@player2.flush
				$j +=1
			end
			@player1.puts "\n"
			@player2.puts "\n"
			$j = 0
			$i +=1
		end
		#@player1.puts @board
		#@player1.puts "Printing Board\n"
		#@player2.puts "Printing Board\n"
	end

# 	def atoi(str)
# return str if !str.is_a? String
 
# fixed_str = fix(str)
 
# result = 0
# fixed_str.each_char do |c|
# result = result*10 + c.to_i
# end
# fixed_str[0]=='-' ? -result : result
# end

	def placeboat(location, orientation, size)
		lastIndex = size - 1

		number = location[1]
		letter = location[0]
		row = number.to_i - 1
		column = letter.ord - 65

		if orientation == "Up"
			for i in 0..lastIndex do
				@board[row - i][column] = lastIndex
			end
		end

		if orientation == "Down"
			for i in 0..lastIndex do
				@board[row + i][column] = lastIndex
			end
		end

		if orientation == "Left"
			for i in 0..lastIndex do
				@board[row][column - i] = lastIndex
			end
		end

		if orientation == "Right"
			for i in 0..lastIndex do
				@board[row][column + i] = lastIndex
			end
		end

		puts letter
		puts number
		puts column
		puts row
	end

	def startgame()
		@player1.puts "Select Start Position for Carrier (Size 5) (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Select Start Position for Carrier (Size 5) (Ranges are A - L and 1 - 10 Example: B5)"

		input1 = @player1.gets
		input2 = @player2.gets
		puts input1
		puts input2

		@player1.puts "Select Orientation for Carrier (Size 5) (Up, Down, Left, Right)"
		@player2.puts "Select Orientation for Carrier (Size 5) (Up, Down, Left, Right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2
        
		

        placeboat(input1, orientation1.chomp, 5)
        placeboat(input2, orientation2.chomp, 5)
		#carrier is now placed print the board to represent the new state
		printboard

		@player1.puts "Select Start Position for Battleship (Size 4) (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Select Start Position for Battleship (Size 4) (Ranges are A - L and 1 - 10 Example: B5)"

		input1 = @player1.gets
		input2 = @player2.gets
		puts input1
		puts input2

		@player1.puts "Select Orientation for Battleship (Size 4) (Up, Down, Left, Right)"
		@player2.puts "Select Orientation for Battleship (Size 4) (Up, Down, Left, Right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2

		@player1.puts "Select Start Position for Submarine (Size 3) (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Select Start Position for Submarine (Size 3) (Ranges are A - L and 1 - 10 Example: B5)"

		input1 = @player1.gets
		input2 = @player2.gets
		puts input1
		puts input2

		@player1.puts "Select Orientation for Submarine (Size 3) (Up, Down, Left, Right)"
		@player2.puts "Select Orientation for Submarine (Size 3) (Up, Down, Left, Right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2
	end

	@player1
	@player2
	@board
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
   	match.startgame
   end

   # reply with goodbye
   ## now lets end the session since all we wanted to do is
   ## acknowledge the client
   #puts "log: sending goodbye"
   #session.puts "Server: Goodbye\n"
 end  #end thread conversation
end   #end loop