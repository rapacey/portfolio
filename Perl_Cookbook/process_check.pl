#Identify if a background process has been running for too long

#!usr/bin/perl

use strict;
use warnings;
use Time::Local;

my $filename = 'process_log.txt';
my $delimiter = '|';

open (my $fh, '<', 'process_log.txt') or die "Can't open '$filename': $!";

while (my $line = <$fh>) {
	chomp($line);
	next if $line =~ /^Process_ID/;		#Skip header line

	#Split the line into an array based on the delimiter
	
	my ($pid, $start_string, $current_string) = split(/\|/, $line);

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
	my $diff_minutes = $diff_seconds/60;

	#Check Threshold
	
	if ($diff_minutes > 30) {
		print "CRITICAL ALERT: Process $pid has been running for $diff_minutes minutes.\n";
	}
}

close $fh;
