#!/usr/bin/perl
use strict;
use warnings;

#Create a script to generate 5-smooth numbers (Hamming numbers)

# We want the first 100 Hamming numbers

my @hamming = (1);

#Indices for our 2, 3 and 5 multipliers (Hamming starts with 1 then 2H, 3H, 5H)

my ($i2, $i3, $i5) = (0, 0, 0);

while (@hamming < 100) {

	# Calculate the next Hamming number candidates
	
	my $next2 = $hamming[$i2] * 2;
	my $next3 = $hamming[$i3] * 3;
	my $next5 = $hamming[$i5] * 5;

	# Find the smallest of the three
	
	my $min = $next2;
	$min = $next3 if $next3 < $min;
	$min = $next5 if $next5 < $min;

	# Add that smallest number to our list
	
	push @hamming, $min;

	# Move to the next number in @hamming
	
	$i2++ if $min == $next2;
	$i3++ if $min == $next3;
	$i5++ if $min == $next5;
}

# Print the result

foreach my $value (@hamming) {
	print "$value\n";
}
