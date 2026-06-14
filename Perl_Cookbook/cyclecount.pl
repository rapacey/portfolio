#Create a Perl script that will select 25 bin locations at random for an inventory check

#!/usr/bin/perl

use strict;
use warnings;

#Build the physical grid of the warehouse

my @all_locations;

#Loop through the aisles: 01 to 24

for (my $aisle = 1; $aisle <= 24; $aisle++) {

	#Pad the aisle with a leading zero if it's a single digit (i.e. 01, 02, 03)
	my $padded_aisle = sprintf("%02d", $aisle);

	#Loop through the shelves: A to D
	for my $shelf ('A' .. 'D') {

		#Loop through bins: 1 to 4
		for (my $bin = 1; $bin <= 4; $bin++) {

			#Stitch them together with standard prefix
			push (@all_locations, "Z1A${padded_aisle}${shelf}${bin}");
		}
	}
}

#Pick 25 unique random locations from our valid grid

my $count = 25;
my %seen;

#Pick 25 unique random items out of our location array

while (keys %seen < $count) {
	
	#Pick a random index based on the total number of items in the array
	my $random_index = int(rand(@all_locations));

	#Store the actual location string as the hash key
	my $chosen_location = $all_locations[$random_index];
	$seen{$chosen_location} = 1;
}

#Print the final checklist alphabetically

foreach my $location (sort keys %seen) {
	print "Location Bin: $location\n";
}
