#!/usr/bin/perl
use strict;
use warnings;

#Chapter 5 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 26, 2026
#Written by Rob Pacey

#Modify the previous program to let the user choose the column width
#30, hello, goodbye (on separate lines) would put the strings at the 30th column

print "What column width would you like? \n";
chomp(my $width = <STDIN>);

print "Please enter several strings of text on separate lines. Press Ctrl + d when finished.\n";
chomp(my @lines = <STDIN>);

#Ruler line as needed
print "1234567890" x (($width + 9)/10), "\n"; 

foreach (@lines) {
	printf "%${width}s\n", $_;
}
