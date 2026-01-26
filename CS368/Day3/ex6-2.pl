#!/usr/bin/perl
use strict;
use warnings;

#Chapter 6 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 25, 2026
#Written by: Rob Pacey

#Write a program that reads a series of words (one per line) until end of input, then prints a summary of how many times each word was seen.

print "Please enter a list of words, one per line. Press Ctrl + d when finished.\n";

my %list;

#Reading all lines from STDIN into an array

while (my $line = <STDIN>) {
	chomp($line);
	$list{$line}++;
}

print "\nSummary of word counts:\n";

#Loop through keys (words) stored in %list to print the final totals

foreach my $word (sort keys %list) {
	print "$word was seen $list{$word} times.\n";
}

