#!/usr/bin/env perl

#use warnings;
select STDOUT; $| = 1; # make unbuffered
open (File1, "HTML_Template.html") or die "HTML_Template.html not found! :O\n";
@HTML = <File1>;
close(File1);

open(InFile, "finished.score") or "There are no completed games!";
foreach $line (<InFile>){
	push (@scores, $line); 
}
close(InFile);

$TableNum = 1;
while ($TableNum < 12){
	open(InFile, "table".$TableNum.".score");
	 foreach $line (<InFile>){
		push (@scores, $line); 
	 }
	 close(InFile);
	$TableNum++;
}


@scores = sort { $a <=> $b } @scores;
#remove zero scores
if(0){
#while(@scores[0] == 0){
	shift @scores;
	print "umm"
}
print "\n\n";
foreach $line (@scores){
	print "$line ";
}

#update scoreboard
open (HTMLFile, ">position.html");
foreach $line (@HTML){
	if ($line =~ /::insertscores::/){
		#1st
		$scorepos = pop(@scores);
		($score, $name) = split (/ /, $scorepos);
		$score = sprintf("%.0f", $score);
		print HTMLFile "<tr>\n";
		print HTMLFile "<td>1st</td>";
		print HTMLFile "<td>   ".$name."</td>";
		print HTMLFile "<td>   ".$score."</td>";
		print HTMLFile "</tr>\n";
		$name1 = $name;
		#2nd
		$scorepos = pop(@scores);
		($score, $name) = split (/ /, $scorepos);
		$score = sprintf("%.0f", $score);
		print HTMLFile "<tr>\n";
		print HTMLFile "<td>2nd</td>";
		print HTMLFile "<td>   ".$name."</td>";
		print HTMLFile "<td>   ".$score."</td>";
		print HTMLFile "</tr>\n";
		$name2 = $name; 
		#3rd
		$scorepos = pop(@scores);
		($score, $name) = split (/ /, $scorepos);
		$score = sprintf("%.0f", $score);
		print HTMLFile "<tr>\n";
		print HTMLFile "<td>3rd</td>";
		print HTMLFile "<td>   ".$name."</td>";
		print HTMLFile "<td>   ".$score."</td>";
		print HTMLFile "</tr>\n";
		$name3 = $name; 
		#4th
		$scorepos = pop(@scores);
		($score, $name) = split (/ /, $scorepos);
		$score = sprintf("%.0f", $score);
		print HTMLFile "<tr>\n";
		print HTMLFile "<td>4th</td>";
		print HTMLFile "<td>   ".$name."</td>";
		print HTMLFile "<td>   ".$score."</td>";
		print HTMLFile "</tr>\n";
		$name4 = $name; 
		
		#5th
		$scorepos = pop(@scores);
		($score, $name) = split (/ /, $scorepos);
		$score = sprintf("%.0f", $score);
		print HTMLFile "<tr>\n";
		print HTMLFile "<td>5th</td>";
		print HTMLFile "<td>   ".$name."</td>";
		print HTMLFile "<td>   ".$score."</td>";
		print HTMLFile "</tr>\n";
		$name5 = $name; 
		
		#6th
		$scorepos = pop(@scores);
		($score, $name) = split (/ /, $scorepos);
		$score = sprintf("%.0f", $score);
		print HTMLFile "<tr>\n";
		print HTMLFile "<td>6th</td>";
		print HTMLFile "<td>   ".$name."</td>";
		print HTMLFile "<td>   ".$score."</td>";
		print HTMLFile "</tr>\n";

	}else{
		print HTMLFile $line;
	}
}
close(HTMLFile);