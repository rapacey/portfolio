#!/usr/bin/perl

#Chapter 2 Exercises
#Learning Perl 8th Edition - 2021
#CS 368 - Intro to Perl
#January 22, 2026
#Written by Rob Pacey

#2-1

#Write a program that computes the circumference of a circle with a radius of 12.5

use warnings;
$pi = 3.141592654;
$circ = 2 * $pi * 12.5;
print "The circumference of a circle of radius 12.5 is $circ.\n";

#2-2

#Modify the program to prompt for and accept a radius

print "What is the radius?";
chomp($radius = <STDIN>);
$circ = 2 * $pi * $radius;
print "The circumference of a circle of radius $radius is $circ.\n";

#2-3

#If the user enters a number less than zero, the circumference reported will be zero rather than negative

print "What is the radius?";
chomp($radius = <STDIN>);

if ($radius < 0){
	print "Circumference is 0.\n";
}	else{
	$circ = $radius * 2 * $pi;
	print "Circumference is $circ.\n";
}

#2-4

#Write a program that prompts for and reads two numbers (on separate lines of input)
#Print out the product of the two numbers multiplied together

print "----The Multiplier Program----\n";
print "Enter the first number: \n";
chomp($one = <STDIN>);
print "Enter the second number: \n";
chomp($two = <STDIN>);
$product = $one * $two;
print "The product is: $product\n";

#2-5

#Write a program that prompts for and reads a string and a number (on separate lines of input)
#Print out the string the number of times indicated by the number on separate lines

print "----The String Repeater----\n";
print "Enter a string of text\n";
$string = <STDIN>;
print "Enter a number of times to repeat\n";
chomp($repeat = <STDIN>);

$result = $string x $repeat;
print "The result is:\n$result";
