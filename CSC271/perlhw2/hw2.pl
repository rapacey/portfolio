#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

#A) Roll a die using a random number using int(rand(6)) for a number between 0 and 6,
#and then converts it to an integer, so 0 to 5 results. Add 1 to the result to get 1-6.
#Keep rolling until you get two 5's in a row

sub doublefive {

	print "Rolling a die until we get two 5's in a row:\n";

	my $last_roll;
	my $current_roll;

	do {
		$last_roll = $current_roll;
		$current_roll = int(rand(6)) + 1;
		print "Rolled: $current_roll\n";
	} until ($current_roll == 5 && $last_roll == 5);

	print "Got two 5s in a row!\n";
	print "\n";
}
doublefive();

#B) Roll a die 10 times to fill an array of 10 dice
#Print the contents of the array and print the total of the array

sub tendice {

	my @array = ();				#Declare array
	foreach my $number(1..10){		#Roll 10 times
		my $roll = int(rand(6)) + 1;
		push @array,$roll;
	}

	print "These 10 dice were rolled: @array\n";		#Print array

	my $total = sum(@array);

	print "The sum of the 10 dice rolls is: $total\n";
}
tendice();

