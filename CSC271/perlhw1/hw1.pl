#!/usr/bin/perl

use strict; 
use warnings;
use List::Util qw(sum);

#1 Ask the user to enter a conversion rate to English currency and a dollar amount. Print the converted amount.

sub conversion {
	
	print "---Conversion Calculator---\n";
	print "Please enter a conversion rate:\n";
	chomp( my $rate = <STDIN> );
	print "Enter a dollar amount:\n";
	chomp( my $amount = <STDIN>);
	my $conversion = $rate * $amount;
	print "At a conversion rate of $rate, $amount US dollars are worth $conversion British pounds sterling.\n";
	print "\n";
}
conversion();

#2 Ask the user to enter a number. Print all the numbers up to that number. Then print the total of all printed numbers.

sub numbers {
	
	print "---Number Sequence and Sum---\n";
	print "Please enter a number:\n";
	chomp( my $number = <STDIN>);
	my @sequence = (1..$number);
	print "@sequence\n";
	my $total = sum(@sequence);
	print "The sum of the numbers is: $total\n";
	print "\n";
}
numbers();

