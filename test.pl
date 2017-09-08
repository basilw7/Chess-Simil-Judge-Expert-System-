#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered

#updateScoreBoard
open (InFile, "table1.meta");
@info = <InFile>;
close (InFile);
while ($line = shift (@info)){
	#print $line;
	if ($line =~ /White /){
		($dispose, $name) = split (/ /, $name);
		($dispose, $name) = split (/\"/, $name);
		}
	}
undef @info;
print $name;