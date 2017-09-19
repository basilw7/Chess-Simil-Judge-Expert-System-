#!/usr/bin/env perl

use warnings;
select STDOUT; $| = 1; # make unbuffered



#loading files

$ContinueRunning = 1;
while($ContinueRunning){
#Reading Tasks
open (File1, ">tmp");
print File1 "controlisready\n";
close(File1);


#Do tasks

#Create/Update FEN files
# *.f file must be created. Then FEN must be feed into crafty.
#update *.f file with current FEN
$table_num = 0;
while ($table_num < 16){
	$table_num++;
	$filename = "table".$table_num;
	system("Scoreboard.pl");
	print ("Creating FEN strings\n");
	system ("pgn2fen ".$filename.".pgn  > ".$filename.".f");
	
	print ("Sending table $table_num FEN strings to chess engine\n");
	system ("MakePOSscores.pl ".$table_num);
	
	$TableMoveNumber = 1; #speed up code here!
	print ("Sending table $table_num pgn to chess engine\n");
	print ("Annotating white\n");
	
	#print ("crafty annotate ".$filename.".pgn w ".$TableMoveNumber."-999 -1 1 1 quit");
	system ('crafty "annotate '.$filename.'.pgn w '.$TableMoveNumber.'-999 -1 1 1" quit');
	system ("MakePVscores.pl ".$table_num." w");
	
	while(0){#Don't calulate black
	print ("Annotating black\n");
	#print ("crafty annotate ".$filename.".pgn b ".$TableMoveNumber."-999 -1 1 1 quit");
	system ('crafty "annotate '.$filename.'.pgn b '.$TableMoveNumber.'-999 -1 1 1" quit');
	system ("MakePVscores.pl ".$table_num." b");
	}

	{
		$filename = "table".$table_num;
		open(InFile, "pvw_scores".$filename.".pgn.can");
		$pvScore = 0;
		foreach $line (<InFile>){
			chomp $line;
			($MoveNum, $PV) = split (/::/, $line);
			print "$MoveNum -> ";
			$pvScore += (($MoveNum/40)*($PV + 40));
			print "$pvScore ";
	
		}
		close(InFile);
		print "$filename PV Score: $pvScore\n";
	
		open(InFile, "pscores".$filename);
		@file = <InFile>;
		close(InFile);
		$pScore = 0;
		$Move_Num = 0;
		while($P = shift @file){
			shift @file;
			$Move_Num++;
			chomp $P;
			print "$Move_Num -> ";
			$pScore += (($Move_Num/10)*($P + 10));
			print "$pScore ";
		}
		print "$filename P Score: $pScore\n";
		
		#find name and write score
		open (InFile, $filename.".meta");
		@info = <InFile>;
		close (InFile);
		while ($line = shift (@info)){
			print $line;
			if ($line =~ /White /){
				($dispose, $line) = split (/ /, $line);
				($dispose, $line) = split (/\"/, $line);
				$name = $line;
			}
		}
		undef @info;
		$totalScore = $pvScore + $pScore;
		open(OutFile, ">$filename".".score");
		print OutFile ("$totalScore $name");
		close(OutFile);
		
		system("Scoreboard.pl");
		
	}
}
open (File1, "tmp");
@CMDs = <File1>;
close(File1);
foreach $line (@CMDs){
	if($line =~ /quit/){
		$ContinueRunning = 0;
	}
}
system ("del log.*");
system ("del game.*");
undef @CMDs;

}



#cleanup
system ("del log.*");
system ("del game.*");
open (File1, ">tmp");
print File1 "controlstopped";
close(File1);	
exit;