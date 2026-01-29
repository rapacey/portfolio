#!/usr/bin/perl
use strict;
use warnings;

#CS 368 - Intro to Perl
#Day 4 Homework
#Rob Pacey
#January 26, 2026

#Write a Perl script that processes an input file and counts the frequency of the lines (one word per line) it contains

my $filename = 'homework-04.txt';
my $threshold = 1000;

#Create I/O connection with file via filehandle ($fh)

open(my $fh, '<', $filename) or die "Unable to open file: $!";

#Store word => frequency in a hash

my %counts;

while (my $line = <$fh>) {
	chomp($line);		#Remove newline
	$line = lc($line); 	#Make it case insensitive

	#Increment the hash key
	$counts{$line}++;
}

close ($fh);

foreach my $word(keys %counts) {
	if ($counts{$word} >= $threshold){
		print "$word: $counts{$word}\n";
	}
}
