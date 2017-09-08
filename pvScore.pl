#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered

$table_num = shift(@ARGV);
$filename = "table".$table_num;
open(InFile, "pvw_scores".$filename.".pgn.can");
$score = 0;
foreach $line (<InFile>){
	chomp $line;
	($MoveNum, $PV) = split (/::/, $line);
	print "$MoveNum -> ";
	$score += (($MoveNum/40)*($PV + 40));
	print "$score ";
	
}
close(InFile);
print "PV Score: $score\n";