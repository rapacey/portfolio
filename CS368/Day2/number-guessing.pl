#!/usr/bin/perl
#CS 368 - Intro to Perl
#Homework Day 2
#January 21, 2026
#Rob Pacey

#Write a Perl script that guesses a number that the user has in mind

use strict;
use warnings;

print "Welcome to the number-guessing game!\n";
print "Think of a number between 1 and 100.\n";
print "\n";

my $low = 1;		#Lowest possible number
my $high = 100;		#Highest possible number
my $choice = "";	#Starts as blank string; user will choose h, l, or c	

until ($choice eq 'c') {
	#Calculate the midpoint between current low and high
	my $guess = int(($low + $high) / 2); 
	
	print "I guess $guess. Is this (c)orrect, (h)igh, or (l)ow? ";
	chomp($choice = <STDIN>);
	$choice = lc($choice);		#Convert to lowercase just in case

	if ($choice eq 'h') {		
		print "Too high, I'll guess lower.\n";
		$high = $guess - 1; 	#New maximum is one less than my guess
	}
	elsif ($choice eq 'l') {
		print "Too low, I'll guess higher.\n";
		$low = $guess +1; 	#New minimum is one more than my guess 
	}
	elsif ($choice eq 'c') {
		print "I got it! Thanks for playing.\n";
	}
	else {
		print "Please enter 'c', 'h', or 'l'.\n";
	}
}

