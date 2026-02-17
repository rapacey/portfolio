#!/bin/usr/perl
use strict;
use warnings;
use Cwd;
use File::Find;
use POSIX qw(strftime);

#Create an array to store the results of the File::Find

my @directories;

#Get the current working directory as the start path

my $start_dir = getcwd();

#Find - Reference to wanted subroutine, List directory to search

find(\&collect_dirs, $start_dir);

#Subroutine - Push find results to @directories array

sub collect_dirs {
	#File::Find sets $_ to name of current item and File::Find::name to the full path
	if (-d $_) {
		push @directories, $File::Find::name;
	}
}

my @sorted_directories = sort @directories;

#For loop for each directory in the sorted array - gather files, sort, then print

foreach my $element(@sorted_directories) {
	chdir $element;			#Change to directory to get full file path
	
	opendir(my $dh, ".");		#Open directory we just moved to
	
	my @filenames = grep { -f $_ } readdir($dh);	#File check on next directory entry
	
	my @sorted_files = sort {-s $b <=> -s $a } @filenames;	#Sort the directory by size

	#Each section should start with the directory name
	print "Directory <$element>\n";	

#Nested for loop for each file

foreach my $file(@sorted_files) {
		
	#Get file size from stat
	my $size = (stat($file))[7];	

	#Get modified time from stat, then convert into human format
	my $mtime = (stat($file))[9];	#modified time is 9th field in stat
	my $formatted_date = strftime("%Y-%m-%d %H:%M:%S", localtime($mtime));

	#Print size, formatted date and file name
	printf("%10d %25s %25s\n", $size, $formatted_date, $file);
}

closedir($dh);		#Close the directory handle
chdir $start_dir;	#Move back to starting location to reset position for next loop

}

#CS 368 - Intro to Perl
#University of Wisconsin Madison
#Day 6 Homework
#Rob Pacey, February 12, 2026
