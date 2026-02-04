#!/usr/bin/perl

use strict;
use warnings;

#Standard Perl

my @numbers = (1..20);

foreach my $number (@numbers) {
	if ( $number % 15 == 0 ) {print "fizz buzz"}
	elsif ( $number % 5 == 0 ) {print "buzz"}
	elsif ( $number % 3 == 0 )  {print "fizz"}
	else {print "$number"}
	print "\n";
}

#Perl Golf One-Liner

print(($_ % 15 == 0 ? 'fizz buzz' : $_ % 3 == 0 ? 'fizz' : $_ % 5 == 0 ? 'buzz' : $_), "\n") for 1..20;

