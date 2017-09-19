# Description
This project is incomplete. I will admit its current state is a mess, and much of the functionality is missing. However, in it's current state it can still perform its primary purpose, and did so in full agreement with a Nationaly ranked chess master who played each game.

This project's purpose is to analyze, and rank a collection of games played against an opponent of constant strength. Such as at a chess simil. It does this by evaluating and aggregating the players replies. Once all the players moves are aggregated, a score is produce and writing to an html file. This is the state of the project at the time of its use at a simil demonstration.

# Install

To use this project the following files need together is a folder. I will list them below:

Necessary Perl scripts:
 - `control2.pl`
 - `MakePOSscores.pl`
 - `MakePVscores.pl`
 - `pScore.pl`
 - `pvScores.pl`
 - `Scoreboard.pl`

Necessary Executables:
 - `crafty.exe`
You may have to rename the file to match the above. You can download  [here](http://www.craftychess.com/)

 - `pgn-extract.exe`
You can download [here](ftp://ftp.cs.kent.ac.uk/pub/djb/pgn-extract/help.html)

 - `pgn2fen.exe`
You can download [here](http://www.7sun.com/chess/index.php)


Finally:
 - `HTML_Template.html`
 - `chess.jpg`

# Usage
You will need to name your .pgn files like the example below. Presently, the project only supports 16 .pgn files. Also .meta files will need to created for each pgn file which includes the .pgn header.
```
table1.pgn and table1.meta
table2.pgn and table2.meta
.
.
.
table16.pgn and table16.meta
```
For example your .meta file should contain something similar to the following:
```
[Event "Joshua Henson vs. Shaftesbury High"]
[Site "Shaftesbury High School, Winnipeg, Manitoba"]
[Date "2011.12.02"]
[Round ""]
[White "David"]
[Black "Joshua Henson"]
[Result "0-1"]
```
Once you have all your .pgn and .meta files save for your games. Run the Perl script `control2.pl`. It will loop forever, looking for changes in .pgn files to update the scoreboard. You should kill the process once it passes through all the tables. The results will not be overwritten.

Open `position.html` in your browser of choice. This will display the scores and player name belonging to that table.

# Plans
I plan to translate this project in C#, create a proper write up, and add the remaining functionality in the future.  

# License
This project is free to use for non-commercial use. Please fork, if you plan to make changes.
