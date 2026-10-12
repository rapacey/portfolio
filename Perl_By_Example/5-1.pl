#!usr/bin/perl

use strict;
use warnings;

#Perl by Example - 5th Edition, Chapter 5 Exercise 1

#Write a script that will ask the user for his five favorite foods (STDIN)
#The foods will be stored as a string in a scalar, each food separated by a comma.

my @foods;

print "Please enter your five favorite foods, separated by commas: ";
my $input = <STDIN>;
chomp($input);

#Split the input string into an array of foods

@foods = split(/,\s*/, $input);

print "Your favorite foods are:\n";
foreach my $food (@foods) {
    print "$food\n";
}

#Print the first and last elements of the array

print "The first food is: $foods[0]\n";
print "The last food is: $foods[-1]\n";

#Print the number of elements in the array

my $count = scalar @foods;
print "You entered $count favorite foods.\n";

#Use an array slice of 3 elements in the food array and assign them to a new array.
#Print the new array with spaces between the elements.

my @food_slice = @foods[0..2];
print "A slice of your favorite foods: @food_slice\n";
