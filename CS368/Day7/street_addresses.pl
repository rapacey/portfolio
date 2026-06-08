#!/usr/bin/perl

use strict;
use warnings;

#Write a Perl script that matches street addresses
# CS 368 - Summer 2009 Day 7 Homework - University of Wisconsin, Madison

#Robert Pacey, June 8, 2026

#Main Execution

open(my $fh, '<', 'valid_addresses.txt') or die "Could not open file: $!\n";

validate_address($fh);

close($fh);

#Subroutine - Regular expressions to match address format details

sub validate_address { 
	
	my ($fh) = @_;

	while (my $line = <$fh>) {
		chomp($line);

	#Structure using the /x modifier to ignore whitespace in regex
		
		if ($line =~ 	/^ \d+ \s+		#Building number and spaces
				([NSEW]\s*)?		#Optional direction
				(\d+)?			#Optional street number
				[a-zA-Z\s.-]+,\s  	#Street name may contain letters, hyphens, spaces and periods
				[a-zA-Z\s.-]+,\s  	#City Name
				[A-Z]{2}\s+		#State abbreviation is exactly 2 uppercase letters, then space(s)
				\d{5}(-\d{4})?$		#5-Digit Zip Code and Optional trailing 4 digits of zip code
				/x) {

			print "$line\n";
		}
	}
}

