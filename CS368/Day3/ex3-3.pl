#!/usr/bin/perl

#Chapter 3 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 24, 2026
#Written by Rob Pacey

#3-3 

#Write a program that reads a list of strings (on separate lines) until end of input. Then it should print the strings in code point order

use strict;
use warnings;

print "---Code Point Order Strings---\n";	#Description
print "Please enter your list of words on separate lines, then press Ctrl + D\n";	#Prompt
print sort <STDIN>;		#Output on separate lines

