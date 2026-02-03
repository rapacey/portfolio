#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

#Write a subroutine named greet to tell each new person the names of all the people it has previously greeted

sub greet {
	
	state @names;		#Keep values between calls
	my $name = shift;

	print "Hi $name! ";

	if (@names ) {
		print "I've seen: @names\n";
	} 
	else {
		print "You are the first one here!\n"; 
	}
}

greet ("Fred");
greet ("Barney");
greet ("Wilma");
greet ("Betty");
