#Identify if a background process has been running for too long

#!usr/bin/perl

use strict;
use warnings;
use Time::Local;
use autodie;

my $filename = 'process_log.txt';
my $delimiter = '|';

open (my $fh, '<', 'process_log.txt');

#Slurp the entire file into an array at once
my @all_lines = <$fh>;
close $fh;

#Use grep to filter out the header
my @filtered_lines = grep { !/^Process_ID/ } @all_lines;

foreach my $line (@filtered_lines) {
	chomp($line);

	#Split the line into an array based on the delimiter variable
	my ($pid, $start_string, $current_string) = split(/\Q$delimiter\E/, $line);

	#Use /r to isolate the time portion cleanly for potential future use without breaking the orginal string
	my $start_time_only = $start_string =~ s/^\d{4}-\d{2}-\d{2}\s+//r;

	#Extract integers using regex groups
	
	my ($s_yyyy, $s_mm, $s_dd, $s_hours, $s_minutes, $s_seconds) =
	($start_string =~ /(\d+)-(\d+)-(\d+)\s+(\d+):(\d+):(\d+)/);

	my ($c_yyyy, $c_mm, $c_dd, $c_hours, $c_minutes, $c_seconds) =
	($current_string =~ /(\d+)-(\d+)-(\d+)\s+(\d+):(\d+):(\d+)/);

	#Convert to Epoch Seconds
	my $start_epoch = timelocal($s_seconds, $s_minutes, $s_hours, $s_dd, $s_mm -1, $s_yyyy);
	my $current_epoch = timelocal($c_seconds, $c_minutes, $c_hours, $c_dd, $c_mm -1, $c_yyyy);

	#Calculate the Delta
	my $diff_seconds = $current_epoch - $start_epoch;
	my $diff_minutes = $diff_seconds / 60;

	#Check Threshold and Print Clean Output
	
	if ($diff_minutes > 30) {
		
		#Calculate clean hours and remaining minutes
		my $hours_running = int($diff_minutes / 60);
		my $minutes_running = $diff_minutes % 60;

		my $time_string = $hours_running > 0 ? "${hours_running}h ${minutes_running}m" : "${minutes_running}m";
		
		print "CRITICAL ALERT: Process $pid has been running for $time_string.\n";
	}
}
