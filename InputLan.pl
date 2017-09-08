#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered

$Table_Num = shift(@ARGV);
chomp $Table_Num;
open(InFile, "table".$Table_Num.".lan");
@LANs = <InFile>;
close(InFile);
$last_element = @LANs;
#print ($last_element."\n");
pop @LANs; #removes result
#$last_element = @LANs[($last_element - 1)];
$move_num = sprintf("%.0f", ($last_element / 2));
$move_num++;
print ("Current move: ");
if (($last_element % 2) == 1){
	print("White\n$move_num ");
}else{
	print("Black\n...$move_num ");
}
open(OutFile, ">tmp.lan");
foreach $line (@LANs){
	print OutFile $line;
}
while (!($input =~ /q/)){
	$input = <STDIN>;
	if (!($input =~ /q/)){
		print OutFile $input." ";
	}
	
}
print OutFile "0-1";
close(OutFile);
system("pgn-extract-16-7.exe tmp.lan > tmp.pgn");
