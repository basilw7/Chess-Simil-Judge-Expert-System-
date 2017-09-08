#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered

$ContinueRunning = 1;
while($ContinueRunning){

print "Enter command\nVaild commands are: move, new, complete, quit.\nExample: move t2 e2e4\n\n\n";
$cmds = <STDIN>;
@input = split(/ /,$cmds);
$task = shift (@input);
$TableNum = substr (shift (@input), 1);


#NewTable 
if ($task =~ /new/){
	print "White: ";
	$whitePlayer = <STDIN>;
	#print "Black: ";
	#$blackPlayer = <STDIN>;
	print "Table #: ";
	$TableNum = <STDIN>;
	chomp $TableNum;
	print ("Do you want write new metadata for table".$TableNum."? :");
	$response = <STDIN>;
	if ($response =~ /y/){
		open (OutFile, ">table".$TableNum."meta");
		print "Writing to table".$TableNum."meta\n");
		print OutFile ('[Event "Joshua Henson vs. Shaftesbury High"]'."\n");
		print OutFile ('[Site "Shaftesbury High School, Winnipeg, Manitoba"]'."\n");
		print OutFile ('[Date "2011.12.02"]'."\n");
		print OutFile ('[Round ""]'."\n");
		print OutFile ('[White "'.$whitePlayer.'"]'."\n");
		print OutFile ('[Black "Joshua Henson"]'."\n");
		print OutFile ('[Result "0-1"]'."\n"); 
		close (OutFile);
	}else {
		print ("\nCancelling changes\n");
	}
	
}elsif($task =~ /complete/){#game complete 
	print ("Not Done!");
}elsif($task =~ /move/){#report move
	open(InFile, "table".$TableNum.".lan");
	@LANs = <InFile>;
	close (InFile);
	open(OutFile, ">tmp.lan");
	foreach $line (@input){
		if(!($line =~ /0\-1/)){
			print OutFile $line;
		}
	}
	foreach $line (@input){
		print OutFile $line;
	}
	print (" 0-1");
	print ("Do you want write new pgn data for table".$TableNum."? :");
	$response = <STDIN>;
	if ($response eq ("y")){
		system("cp --reply=yes tmp.lan table".$TableNum.".pgn");
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
		sleep(2);
		open (File1, "tmp") or "Hold on...\n";
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
