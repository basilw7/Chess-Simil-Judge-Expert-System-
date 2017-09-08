#!/usr/bin/env perl

use warnings;
select STDOUT; $| = 1; # make unbuffered

while ($table_num = shift(@ARGV)){
	print ("Making table".$table_num." scores\n");
	$filename = "table".$table_num;
	open(InFile, $filename.".f");
	@FENs = <InFile>;
	close(InFile);
	foreach $line (@FENs){
		($fen, $dispose) = split (/\-/, $line);
		system ("crafty ".$fen." score quit > result");
		open(InFileFEN, "result");
		@results = <InFileFEN>;
		close(InFileFEN);
		foreach $line (@results){
			if ($line =~ /total/){
				#print $line; #debugging
				($dispose, $score) = split (/\.  /, $line);
				push (@PositonalScores, $score);
			}
		}
		undef @results;
		#write out scores positional scores
		open (OutFile, ">pscores".$filename);
		foreach $line (@PositonalScores){
			print OutFile $line;
		}
	}
	undef @FENs;
}
exit;