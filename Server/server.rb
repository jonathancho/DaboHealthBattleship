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
		@board1 = SparseArray.new()
		@board2 = SparseArray.new()
		@numboats1 = 5
		@numboats2 = 5

		@carrier1 = 5
		@battleship1 = 4
		@submarine1 = 3
		@destroyer1 = 3
		@patrolboat1 = 2
		@carrier2 = 5
		@battleship2 = 4
		@submarine2 = 3
		@destroyer2 = 3
		@patrolboat2 = 2

		for i in 0..9 do
			for j in 0..9 do
				@board1[i][j] = '-'
				@board2[i][j] = '-'
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
		$letter = 'A'
		while $i < 11 do
			while $j < 11 do
				if $i == 0 && 
					@player1.print $letter
					@player1.print " "
					@player2.print $letter
					@player2.print " "
					@player1.flush
					@player2.flush
				else
					@player1.print @board1[$i][$j]
					@player1.print " "
					@player2.print @board2[$i][$j]
					@player2.print " "
					@player1.flush
					@player2.flush
					$j +=1
				end
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

	def player1turn()
		@player1.puts "Select a Spot to Fire (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Player 1 is taking a shot, Please wait..."
		input1 = @player1.gets

		number = input1[1]
		letter = input1[0]
		row = number.to_i - 1
		column = letter.ord - 65

		#hits nothing
		if @board2[row][column] == '-'
			@player1.puts "Shot Missed!"
			@player2.puts "Player 1 shot at #{input1} and missed!"
		elsif @board2[row][column] == 'c'
			@player1.puts "Shot Hit!"
			@player2.puts "Player 1 shot at #{input1} and hit!"
			@carrier2 -= 1

			if @carrier2 == 0
				@player1.puts "Player 2's Carrier has been sunk!"
				@player2.puts "Your Carrier has been destroyed!"
				@numboats2
			end
		elsif @board2[row][column] == 'b'
			@player1.puts "Shot Hit!"
			@player2.puts "Player 1 shot at #{input1} and hit!"

			@battleship2 -= 1

			if @battleship2 == 0
				@player1.puts "Player 2's Battleship has been sunk!"
				@player2.puts "Your Battleship has been destroyed!"
				@numboats2 -= 1
			end
		elsif @board2[row][column] == 's'
			@player1.puts "Shot Hit!"
			@player2.puts "Player 1 shot at #{input1} and hit!"

			@submarine2 -= 1

			if @submarine2 == 0
				@player1.puts "Player 2's Submarine has been sunk!"
				@player2.puts "Your Submarine has been destroyed!"
				@numboats2 -= 1
			end
		elsif @board2[row][column] == 'd'
			@player1.puts "Shot Hit!"
			@player2.puts "Player 1 shot at #{input1} and hit!"

			@destroyer2 -= 1

			if @destroyer2 == 0
				@player1.puts "Player 2's Destroyer has been sunk!"
				@player2.puts "Your Destroyer has been destroyed!"
				@numboats2 -= 1
			end
		elsif @board2[row][column] == 'p'
			@player1.puts "Shot Hit!"
			@player2.puts "Player 1 shot at #{input1} and hit!"

			@patrolboat2 -= 1

			if @patrolboat2 == 0
				@player1.puts "Player 2's Patrol Boat has been sunk!"
				@player2.puts "Your Patrol Boat has been destroyed!"
				@numboats2 -= 1
			end
		end
		@board2[row][column] = 'x'

		if @numboats2 == 0
			@player1.puts "You WIN!!!!!"
			@player2.puts "You LOSE!!!!!"
			@player1.puts "Goodbye"
			@player2.puts "Goodbye"
		end
	end

	def player2turn()
		@player2.puts "Select a Spot to Fire (Ranges are A - L and 1 - 10 Example: B5)"
		@player1.puts "Player 2 is taking a shot, Please wait..."
		input1 = @player2.gets

		number = input1[1]
		letter = input1[0]
		row = number.to_i - 1
		column = letter.ord - 65

		#hits nothing
		if @board1[row][column] == '-'
			@player2.puts "Shot Missed!"
			@player1.puts "Player 2 shot at #{input1} and missed!"
		elsif @board1[row][column] == 'c'
			@player2.puts "Shot Hit!"
			@player1.puts "Player 2 shot at #{input1} and hit!"
			@carrier1 -= 1

			if @carrier1 == 0
				@player2.puts "Player 1's Carrier has been sunk!"
				@player1.puts "Your Carrier has been destroyed!"
				@numboats1 -= 1
			end
		elsif @board1[row][column] == 'b'
			@player2.puts "Shot Hit!"
			@player1.puts "Player 2 shot at #{input1} and hit!"

			@battleship1 -= 1

			if @battleship1 == 0
				@player2.puts "Player 1's Battleship has been sunk!"
				@player1.puts "Your Battleship has been destroyed!"
				@numboats1 -= 1
			end
		elsif @board1[row][column] == 's'
			@player2.puts "Shot Hit!"
			@player1.puts "Player 2 shot at #{input1} and hit!"

			@submarine1 -= 1

			if @submarine1 == 0
				@player2.puts "Player 1's Submarine has been sunk!"
				@player1.puts "Your Submarine has been destroyed!"
				@numboats1 -= 1
			end
		elsif @board1[row][column] == 'd'
			@player2.puts "Shot Hit!"
			@player1.puts "Player 2 shot at #{input1} and hit!"

			@destroyer1 -= 1

			if @destroyer1 == 0
				@player2.puts "Player 1's Destroyer has been sunk!"
				@player1.puts "Your Destroyer has been destroyed!"
				@numboats1 -= 1
			end
		elsif @board1[row][column] == 'p'
			@player2.puts "Shot Hit!"
			@player1.puts "Player 2 shot at #{input1} and hit!"

			@patrolboat1 -= 1

			if @patrolboat1 == 0
				@player2.puts "Player 1's Patrol Boat has been sunk!"
				@player1.puts "Your Patrol Boat has been destroyed!"
				@numboats1 -= 1
			end
		end
		@board1[row][column] = 'x'

		if @numboats1 == 0
			@player2.puts "You WIN!!!!!"
			@player1.puts "You LOSE!!!!!"
			@player2.puts "Goodbye"
			@player1.puts "Goodbye"
		end
	end

	def placeboat(location, orientation, size, board, type)
		lastIndex = size - 1

		number = location[1]
		letter = location[0]
		row = number.to_i - 1
		column = letter.ord - 65

		if orientation == "up"
			for i in 0..lastIndex do
				board[row - i][column] = type
			end
		end

		if orientation == "down"
			for i in 0..lastIndex do
				board[row + i][column] = type
			end
		end

		if orientation == "left"
			for i in 0..lastIndex do
				board[row][column - i] = type
			end
		end

		if orientation == "right"
			for i in 0..lastIndex do
				board[row][column + i] = type
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

		@player1.puts "Select Orientation for Carrier (Size 5) (up, down, left, right)"
		@player2.puts "Select Orientation for Carrier (Size 5) (up, down, left, right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2
        
		

        placeboat(input1, orientation1.chomp, 5, @board1, 'c')
        placeboat(input2, orientation2.chomp, 5, @board2, 'c')
		#carrier is now placed print the board to represent the new state
		printboard

		@player1.puts "Select Start Position for Battleship (Size 4) (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Select Start Position for Battleship (Size 4) (Ranges are A - L and 1 - 10 Example: B5)"

		input1 = @player1.gets
		input2 = @player2.gets
		puts input1
		puts input2

		@player1.puts "Select Orientation for Battleship (Size 4) (up, down, left, right)"
		@player2.puts "Select Orientation for Battleship (Size 4) (up, down, left, right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2

		placeboat(input1, orientation1.chomp, 4, @board1, 'b')
        placeboat(input2, orientation2.chomp, 4, @board2, 'b')
		#carrier is now placed print the board to represent the new state
		printboard

		@player1.puts "Select Start Position for Submarine (Size 3) (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Select Start Position for Submarine (Size 3) (Ranges are A - L and 1 - 10 Example: B5)"

		input1 = @player1.gets
		input2 = @player2.gets
		puts input1
		puts input2

		@player1.puts "Select Orientation for Submarine (Size 3) (up, down, left, right)"
		@player2.puts "Select Orientation for Submarine (Size 3) (up, down, left, right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2

		placeboat(input1, orientation1.chomp, 3, @board1, 's')
        placeboat(input2, orientation2.chomp, 3, @board2, 's')
		#carrier is now placed print the board to represent the new state
		printboard

		@player1.puts "Select Start Position for Destroyer (Size 3) (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Select Start Position for Destroyer (Size 3) (Ranges are A - L and 1 - 10 Example: B5)"

		input1 = @player1.gets
		input2 = @player2.gets
		puts input1
		puts input2

		@player1.puts "Select Orientation for Destroyer (Size 3) (up, down, left, right)"
		@player2.puts "Select Orientation for Destroyer (Size 3) (up, down, left, right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2

		placeboat(input1, orientation1.chomp, 3, @board1, 'd')
        placeboat(input2, orientation2.chomp, 3, @board2, 'd')
		#carrier is now placed print the board to represent the new state
		printboard

		@player1.puts "Select Start Position for Patrol Boat (Size 2) (Ranges are A - L and 1 - 10 Example: B5)"
		@player2.puts "Select Start Position for Patrol Boat (Size 2) (Ranges are A - L and 1 - 10 Example: B5)"

		input1 = @player1.gets
		input2 = @player2.gets
		puts input1
		puts input2

		@player1.puts "Select Orientation for Patrol Boat (Size 2) (up, down, left, right)"
		@player2.puts "Select Orientation for Patrol Boat (Size 2) (up, down, left, right)"

		orientation1 = @player1.gets
		orientation2 = @player2.gets
		puts orientation1
		puts orientation2

		placeboat(input1, orientation1.chomp, 2, @board1, 'p')
        placeboat(input2, orientation2.chomp, 2, @board2, 'p')
		#carrier is now placed print the board to represent the new state
		printboard

		while @numboats1 > 0 && @numboats2 > 0 do
			puts "next phase!!!"
			player1turn()
			player2turn()
			printboard()
		end
	end

	@player1
	@player2
	@board1
	@board2
	@numboats1
	@numboats2
	@carrier1
	@battleship1
	@submarine1
	@destroyer1
	@patrolboat1
	@carrier2
	@battleship2
	@submarine2
	@destroyer2
	@patrolboat2

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