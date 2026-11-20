#!/usr/bin/perl

use strict;
use warnings;

#Program Specs

#Input to the program is a sequence of lines from the standard input stream, with 3 positive numbers per line

#For each line, decide if a, b and c are the sides of a triangle and if so, what type of triangle

print "Enter 3 positive numbers per each line of text. Press Ctrl + D or Ctrl + Z on an empty line to exit: \n";

#Read from STDIN line by line

while (my $line = <STDIN>) {

	#Remove trailing newline
	chomp($line);

	#Split the line into 3 variables using whitespace as delimiter
	my ($a, $b, $c) = split(' ', $line);

	#Check if we received all 3 variables
	if (defined $a && defined $b && defined $c) {
		process_triangle($a, $b, $c);
	}
}

sub process_triangle {
	
	#Receive arguments and keep original input order for final print statement
	my ($a_orig, $b_orig, $c_orig) = @_;

	#Create a sorted version for the triangle tests
	
	my @sorted_sides = sort { $a <=> $b } ($a_orig, $b_orig, $c_orig);

	#Assign new variables for clarity (side1, side2, side 3)
	
	my ($s1, $s2, $s3) = @sorted_sides;

	#In a triangle, any two sides must be GREATER than the third side
	if (($s1 + $s2 > $s3) && ($s1 + $s3 > $s2) && ($s2 + $s3 > $s1)) {
	
		#Classify by angle type
		my $angle_type = " ";
		if (($s1**2 + $s2**2 < $s3**2)) {
			$angle_type = "obtuse";
		} elsif (($s1**2 + $s2**2 == $s3**2)) {
			$angle_type = "right";
		} elsif (($s1**2 + $s2**2 > $s3**2)) {
			$angle_type = "acute";
		}

		#Classify by sides

		my $side_type = " ";
		if (($s1 == $s2) && ($s2 == $s3)) {
			$side_type = "equilateral";
		} elsif (($s1 == $s2 ) || ($s2 == $s3) || ($s1 == $s3)) {
			$side_type = "isoceles";
		} else {
			$side_type = "scalene";
		}

		#Calculate the area of the triangle with Heron's Formula

		my $s = (($s1 + $s2 + $s3) / 2);
		my $input = ($s * ($s - $s1) * ($s - $s2) * ($s - $s3));
		my $area = sqrt($input);

		#Print specific message and continue

		printf "%s, %s, and %s are the sides of a %s %s triangle with area %.1f\n", $a_orig, $b_orig, $c_orig, $angle_type, $side_type, $area;


	} else {
		print "$a_orig, $b_orig and $c_orig are NOT the sides of a triangle. \n";
	}
}

#CSCI 132 - Practical Unix
#Rob Pacey
#February 3, 2026


