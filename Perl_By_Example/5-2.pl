#!usr/bin/perl 

use strict;
use warnings;

#Perl by Example - 5th Edition, Chapter 5 Exercise 2

my @names = qw(Nick Susan Chet Dolly Bill);

print "The names in the array are:\n";

#Replace Susan and Chet with Ellie, Beatrice, and Charles

my @names = splice(@names, 1, 2, qw(Ellie Beatrice Charles));
print "The names in the array are:\n";

#Remove Bill from the array

my $removed_name = pop @names;
print "Removed name: $removed_name\n";

#On the end of the array, add Lewis and Izzy

push @names, qw(Lewis Izzy);
print "The names in the array are:\n";

#Remove Nick from the beginning of the array

my $removed_name2 = shift @names;
print "Removed name: $removed_name2\n";

#Reverse the array

my @reversed_names = reverse @names;
print "The names in reverse order are: @reversed_names\n";

#On the beginning of the array, add Archie

unshift @names, "Archie";
print "The names in the array are:\n";

#Sort the array

my @sorted_names = sort @names;
print "The names in sorted order are: @sorted_names\n";

#Remove Chet and Dolly and replace them with Christian and Daniel

my @names = splice(@names, 2, 2, qw(Christian Daniel));
print "The names in the array are:\n";