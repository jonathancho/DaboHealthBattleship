DaboHealthBattleship
====================

This is a battleship game I implemented using ruby. This was my first time using ruby so I'm sure there were many things I could've done better. Overall, I spent about 1 and a half - 2 days on this project including time spent researching ruby. I would've liked to spent more time to refactor / add features but I have to leave on a trip.

How to Play
====================
To start the server, open a command prompt in the server directory and type "ruby server.rb"
To start the client, open a command prompt in the client directory and type "ruby client.rb"

Two clients are needed to start a match


Known Issues
====================
There is no input validation so the code assumes you always type the right thing
Valid spaces start with captital letters (A, B, C, ..Z) and numbers from 1 through 10
Valid directions are up, down, left, right (no capitals or anything else)

Also there are no checks to make sure ships are being placed in valid spots (not outside the grid, not overlapping other ships)
There are also no checks to make sure a player does not shoot at the same place twice

I have not tested with more than two clients so I have no idea if more than 2 people playing at a time is possible. (Probably not)

Also I have only done limited testing on my own computer. I tried testing using a friend's machine but it didn't seem to work because of blocked ports? (not sure)
