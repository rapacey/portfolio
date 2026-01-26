#!/usr/bin/perl
#Chapter 3 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
##January 24, 2026
#Written by Rob Pacey

#3-2

#Write a program that reads a list of strings (on separate lines) until end of input and then prints for each number the corresponding person's name 

use strict;
use warnings;

print "---Meet the Flintstones---\n";
my @names = qw(fred betty barney dino wilma pebbles bamm-bamm); 	#List of names
print "@names\n";

print "Please enter some numbers from 1 to 7 on separate lines. Then press Ctrl + D\n";
chomp(my @numbers = <STDIN>);

#For each number given by the user, print the flintstone name from the list for that index number

foreach (@numbers) {
	#Validate input to avoid "Use of uninitialized value" errors
	if ($_ >= 1 && $_ <= 7) {
		print "$names[ $_ - 1 ]\n";
	}else{
		print "Number $_ is out of range (1-7)\n";
	}
}

#Note: Use $_ - 1 so that user choice of 1 to 7 matches the array indexed 0 to 6

