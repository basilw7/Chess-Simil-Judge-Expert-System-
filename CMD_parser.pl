#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered

$ContinueRunning = 1;
while($ContinueRunning){

print "Enter command\nVaild commands are: move, new, complete, look, and quit.\nExample: move t2 e2e4\n\n> ";
$cmds = <STDIN>;
@input = split(/ /,$cmds);
$task = shift (@input);
$TableNum = substr (shift (@input), 1);


#NewTable 
if ($task =~ /new/){
	print "White: ";
	$whitePlayer = <STDIN>;
	chomp $whitePlayer;
	#print "Black: ";
	#$blackPlayer = <STDIN>;
	print "Table #: ";
	$TableNum = <STDIN>;
	chomp $TableNum;
	print ("Do you want write new metadata for table".$TableNum."? :");
	$response = <STDIN>;
	if ($response =~ /y/){
		open (OutFile, ">table".$TableNum.".meta");
		print ("Writing to table".$TableNum."meta\n");
		print OutFile ('[Event "Joshua Henson vs. Shaftesbury High"]'."\n");
		print OutFile ('[Site "Shaftesbury High School, Winnipeg, Manitoba"]'."\n");
		print OutFile ('[Date "2011.12.02"]'."\n");
		print OutFile ('[Round ""]'."\n");
		print OutFile ('[White "'.$whitePlayer.'"]'."\n");
		print OutFile ('[Black "Joshua Henson"]'."\n");
		print OutFile ('[Result "0-1"]'."\n"); #I already know they all are going to lose :p
		close (OutFile);
	}else {
		print ("\nCancelling changes\n");
	}
	
}elsif($task =~ /complete/){#game complete 
	print ("Enter table:");
	$response = <STDIN>;
	chomp $response;
	system ("completed.pl ".$response);
}elsif($task =~ /move/){#report move
	system("InputLan.pl $TableNum");
	chomp $TableNum;
	print ("Do you want write new pgn data for table".$TableNum."? :");
	$response = <STDIN>;
	if ($response =~ /y/){
		system("cp --reply=yes tmp.lan table".$TableNum.".lan");
		system("cp --reply=yes tmp.pgn table".$TableNum.".pgn");
	}else {
		print ("\nCancelling changes\n");
	}
	
}elsif($task =~ /help/){
	print("\nHelp?! It's your code!\n");

}elsif($task =~ /quit/){
	open (File1, ">tmp");
	print File1 "quit";
	close(File1);
	$ControlisOpen = 1;
	print "Terminating.";
	while ($ControlisOpen){
		print".";
		sleep(1);
		open (File1, "tmp");
		foreach $line (<File1>){
			if($line =~ /controlstopped/){
				$ControlisOpen = 0;
			}
		}
		close(File1);
	}
	print".\n";
	print"control script has closed\n";
	$ContinueRunning = 0;
}elsif($task =~ /look/){
	print ("View which table?\n:");
	$response = <STDIN>;
	chomp $response;
	system ("table".$response.".pgn");
}else{
	print("Syntax Error!\n");
undef @input;
}


}
#look at Syntax: Look t1 
#Return: pgn and position
#if ($input =~ /look/){
#	$tableNum = <STDIN>;
#	open (InFile, $tableNum."pgn");
#	@lines = <InFile>;
#	close(InFile);
#	open (OutFile, ">tmp_pgn.pgn");
#	foreach $line (@lines){
#		print OutFile ($line);
#	}
#	undef @lines
	#system ("")
	#Contiune Here	
#}
