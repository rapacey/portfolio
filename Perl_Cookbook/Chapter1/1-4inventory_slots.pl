#!/usr/bin/perl
use strict;
use warnings;

#A script to make slot location codes human-readable for a picker's spreadsheet

my $file = '1-4inventory_slots.txt';

open(my $fh, '<', $file) or die "Could not open $file $!";

while (my $line = <$fh>) {
	chomp $line;

	#Split by characters - Aisle 1-3, Zone 4, Level 5-6, Bin 7-8
	
	my ($aisle, $zone, $level, $bin) = unpack("A3 A1 A2 A2", $line);

	#Print the output as a CSV row
	print qq{"$aisle","$zone","$level","$bin"\n};
}

close $fh; 
