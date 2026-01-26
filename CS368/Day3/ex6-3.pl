#!/usr/bin/perl
use strict;
use warnings;

#Chapter 6 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 25, 2026
#Written by: Rob Pacey

#Write a program to list all the keys and values in %ENV. Print the results in 2 columns in ASCIIbetical order.
#Arrange the output to vertically align both columns

my $longest = 0;

#Go through the keys and use length to get their lengths

foreach my $key (keys %ENV) {
	my $key_length = length ($key);
	$longest = $key_length if $key_length > $longest;
}

#Print the keys and values in two columns

foreach my $key (sort keys %ENV) {
	printf "%-${longest}s %s\n", $key, $ENV{$key};
}

