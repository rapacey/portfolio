#!/usr/bin/perl
use strict;
use warnings;

#Chapter 5 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 26, 2026
#Written by Rob Pacey

#5-2

#Write a program that asks the user to enter a list of strings on separate lines
#Print each string in a right-justified 20-character column

print "Please enter several strings of text on separate lines. Press Ctrl + d when finished.\n";
chomp(my @lines = <STDIN>);

#Ruler line to column 75 to test/debug

print "1234567890" x 7, "12345\n";

foreach (@lines) {
	printf "%20s\n", $_;
}

