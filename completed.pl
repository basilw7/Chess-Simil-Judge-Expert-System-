select STDOUT; $| = 1; # make unbuffered


$TableNum = shift(@ARGV);
chomp $TableNum;
#Writescore to finished.score

if ($Table_Num < 13){
open(InFile, "table".$TableNum.".score");
open(OutFile, ">>finished.score");
foreach $line (<InFile>){
	print OutFile $line."\n";
}
close(InFile);
close(OutFile);
}
		#remember to update scoreboard.pl***
		
#load table#.meta 
open(InFile, "table".$TableNum.".meta");
@meta = <InFile>;
close(InFile);

#load table#.pgn
open(InFile, "table".$TableNum.".pgn");
@pgn = <InFile>;
close(InFile);



#make game#.pgn in completed folder (increase number in seq.)
$path  = "completed";
opendir (folder,$path) or die ("Could not open directory!\n");
@files = readdir(folder);
closedir(folder);
$index = @files;
print $index;
$index--;
open(OutFile, ">completed/game".$index.".pgn");
foreach $line (@meta){
	print OutFile $line;
	print $line;
	shift @pgn; #removes unwanted lines from the pgn extractor
}
undef @meta;
foreach $line (@pgn){
	print OutFile $line;
	print $line;
}
close(OutFile);


#blank table#.meta
open(Blank,">table".$TableNum.".meta");
print Blank ('[White "-"]');
close(Blank);
#blank table#.pgn
open(Blank,">table".$TableNum.".pgn");
print OutFile " ";
close(Blank);
#blank table#.pgn.can
open(Blank,">table".$TableNum.".pgn.can");
print OutFile " ";
close(Blank);
#blank table#.f
open(Blank,">table".$TableNum.".f");
print OutFile " ";
close(Blank);
#blank pscorestable#
open(Blank,">pscorestable".$TableNum);
print OutFile " ";
close(Blank);
#blank table#score
open(Blank,">table".$TableNum."score");
print OutFile " ";
close(Blank);



#blank table#.score
open(Blank,">table".$TableNum.".score");
print OutFile " ";
close(Blank);
#blank table#.lan
open(Blank,">table".$TableNum.".lan");
print OutFile " ";
close(Blank);
exit;