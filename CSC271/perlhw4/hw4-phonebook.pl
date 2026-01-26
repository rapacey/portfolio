#!/usr/bin/perl
use strict;
use warnings;

#CSC 271 - Adelphi University
#Perl Homework 4
#Rob Pacey
#January 26, 2026

#Create a hash table that holds names of people and their phone numbers. Then display all the names on the screen.
#Ask the user to enter a name from the list. Display the name's phone number.

my %phonebook = (
	"Larry", "217-379-2567",
	"Erin", "815-232-4662",
	"James", "217-893-9083",
	"Tim", "217-394-2445",
	"Katy", "217-379-9289",);

#Print names on the screen

foreach my $key (sort keys %phonebook) {
	print "$key\n";
}

#Ask user to enter a name

print "Enter a name from the list: \n";
chomp(my $name = <STDIN>);

if (exists ($phonebook{$name})) {
	my $phonenumber = $phonebook{$name};
	print "$phonenumber\n";
}

