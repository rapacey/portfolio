#!/usr/bin/perl

use strict;
use warnings;

#Perl by Example - 5th Edition, Chapter 5 Exercise 3

#Write a script called elective.pl that will contain a hash.
#The keys will be code numbers and the values will be course names.

my %courses = (
    "2CPR2B" => "C Language",
    "1UNX1B" => "Intro to Unix",
    "3SH414" => "Shell Scripting",
    "4PL400" => "Perl Programming",
);

print "\n Course List:\n\n";

#Print the course list in a formatted manner

foreach my $code (sort keys %courses) {
    printf "%-10s : %s\n", $code, $courses{$code};
};

#Prompt the user to type the code number of the course they want to take

print "\nEnter the code number of the course you want to take: ";
chomp(my $user_input = <STDIN>);

#Check if the entered code exists in the hash
if (exists $courses{$user_input}) {
    print "\nYou have selected the course: $courses{$user_input}\n";
} else {
    print "\nInvalid course code. Please try again.\n";
};