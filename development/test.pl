#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered

open(InFile, "tmp.lan"); #this will be changed to table1.lan
@LANs = <InFile>;
close(InFile);
$last_element = @LANs;
print ($last_element."\n");
pop @LANs; #removes result
$last_element = @LANs[($last_element - 1)];
print $last_element;
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
