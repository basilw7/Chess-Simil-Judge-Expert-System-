#!/usr/bin/env perl

use warnings;
select STDOUT; $| = 1; # make unbuffered



while ($table_num = shift(@ARGV)){
	$color = shift(@ARGV);
	$filename = "table".$table_num.".pgn.can";
	open(InFile, $filename);
	@TempStack = <InFile>;
	close (InFile);
	foreach $line (@TempStack){
		if ($line =~ /:/){
			($cp, $dispose) = split (/}/, $line);
			($dispose, $cp) = split (/:/, $cp);
			#print ("$cp\n");
			($dispose, $movenum) = split (/}/, $line);
			($movenum, $dispose) = split (/\./, $movenum);
			#print ("$movenum\n");
			push (@cpresults, ($movenum."::".$cp));
		}
	}	
	undef @TempStack;
	$sum = 0;
	$n = 1;
	$line = shift (@cpresults);
	($prev, $cp) = split (/\ /, $line);
	foreach $line (@cpresults){
		$sum += $cp; #cp prev
		($curr, $cp) = split (/::/, $line);
		if ($curr == $prev){
			$sum += $cp;
			$n++;
		}else{
			$cp = $sum / $n;
			push (@NewCP_Results, ($prev."::".$cp));
			$prev = $curr;
			$n = 1;
			$sum = 0	
		}
	}
	shift @NewCP_Results;
	open (OutFile, ">pv".$color."_scores".$filename);
	foreach $line (@NewCP_Results){
		print OutFile $line."\n";
	}
}