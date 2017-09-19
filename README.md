# Description
This project is incomplete. Much of the functionality is missing. In it's current state it can still perform its primary purpose. This project's purpose is to analyze, and rank a collection of games played against an opponent of constant strength. Such as at a chess simil. It does this by evaluating and aggregating the players replies. Once all the players moves are aggregated, a score is produce and writing to an html file.

# Install

To use this project the following files need together is a folder. I will list them below:

Necessary Perl scripts:
-`control2.pl`
-`MakePOSscores.pl`
-`MakePVscores.pl`
-`pScore.pl`
-`pvScores.pl`
-`Scoreboard.pl`

Necessary Executables:
-`crafty.exe`
You may have to rename the file to match the above. You can download  [here](http://www.craftychess.com/)

`pgn-extract.exe`
You can download [here](ftp://ftp.cs.kent.ac.uk/pub/djb/pgn-extract/help.html)

`pgn2fen.exe`
You can download [here](http://www.7sun.com/chess/index.php)


Finally:
-`HTML_Template.html`
-`chess.jpg`

# Usage

```
table1.pgn and table1.meta
table2.pgn and table2.meta
.
.
.
table16.pgn and table16.meta
```

Run the Perl script `control2.pl` it will loop forever, looking for changes in .pgn files to update the scoreboard. You should kill the process once it passes through all the tables. The results will not be overwritten.

Open `position.html` in your browser of choice. This html  display the scores and player name belonging to that table.


# Plans
I plan to translate this project in C#, create a proper write up, and add the remaining functionality in the future.  

# License
This code is free to use for non-commercial use. Please fork, if you plan to make changes.
