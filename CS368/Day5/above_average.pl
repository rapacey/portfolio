#!/usr/bin/perl

use strict;
use warnings;

#Take a list of numbers and return the ones that are above the average (mean)

#Subroutines

sub total {
	my $sum = 0;		#Sum is undefined
	foreach (@_) {
		$sum+=$_;	#$_ is default variable for the foreach loop
	}
	$sum;
}

sub average {
	if (@_ == 0) { return }
	my $count = @_;			#@_ is the parameter list			
	my $sum = total(@_);		#From subroutine above
	$sum/$count;
}

sub above_average {
	my $average = average(@_);
	my @list;
	foreach my $element(@_) {
		if ($element > $average) {
			push @list, $element;
		} 
	}
	@list;
}

#Main Test

my @fred = above_average(1..10);
print "\@fred is @fred\n";
print "(Should be 6 7 8 9 10)\n";

my @barney = above_average(100, 1..10);
print "\@barney is @barney\n";
print "(Should be just 100)\n";
