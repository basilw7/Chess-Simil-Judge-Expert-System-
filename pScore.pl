#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered


$table_num = shift(@ARGV);
$filename = "table".$table_num;
open(InFile, "pscores".$filename);
@file = <InFile>;
close(InFile);
$score = 0;
$Move_Num = 0;
while($P = shift @file){
	shift @file;
	$Move_Num++;
	chomp $P;
	print "$Move_Num -> ";
	$score += (($Move_Num/10)*($P + 10));
	print "$score ";
	
}
print "P Score: $score\n";