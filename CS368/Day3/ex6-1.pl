#!/usr/bin/perl
use strict;
use warnings;

#Chapter 6 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 25, 2026
#Written by Rob Pacey

#Write a program that will ask the user for a given name and report the corresponding family name.

my %hogwarts;

$hogwarts{"harry"} = 'potter';
$hogwarts{"ron"} = 'weasley';
$hogwarts{"hermoine"} = 'granger';
$hogwarts{"draco"} = 'malfoy';
$hogwarts{"albus"} = 'dumbledore';
$hogwarts{"severus"} = 'snape';
$hogwarts{"ginny"} = 'weasley';

print "Please enter a first name: \n";
chomp(my $name = <STDIN>);

if (exists $hogwarts{$name}){
	print "That's $name $hogwarts{$name}.\n";
}else{
	print "Error: Name not found. \n";
}

