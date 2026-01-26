#!/usr/bin/perl

#Chapter 3 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 24, 2026
#Written by Rob Pacey

#3-1

#Write a program that reads a list of strings on separate lines until end of input and then prints out the list in reverse order

use strict;
use warnings;

print "---String Reverse---\n";
print "Please enter a list of words on separate lines, then press Ctrl + D\n";
print reverse <STDIN>;		#Read and print in same step
print "\n";

