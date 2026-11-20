#!/bin/bash

#CSCI 132 - Practical Unix
#CUNY - Hunter College
#Professor Weiss, Fall 2018

#Assignment 3, Task 3-1
#Rob Pacey
#January 27, 2026

#Command line arguments should be 3 positive whole numbers in increasing order
#If the user has entered valid numbers, the script determines if the numbers are the sides of a triangle, and if so, what type

#Variables set to value of the 3 command line arguments

a=$1
b=$2
c=$3

#Regular expression for integer test

regex='^[0-9]+$'

#Test Arguments

if [ "$#" -ne 3 ]; then
	echo "Error - Usage: triangletype <Arg1> <Arg2> <Arg3>"
	exit 1
fi

if ! [[ $a =~ $regex || $b =~ $regex || $c =~ $regex ]]; then
	echo "Error: Three numbers must all be positive INTEGERS."
	exit 2
fi

if ! [[ "$a" -gt 0 && "$b" -gt 0 && "$c" -gt 0 ]]; then
	echo "Error: All three numbers must be positive."
	exit 3
fi

if ! [[ "$a" -le "$b" && "$b" -le "$c" ]]; then
	echo "Error: Three numbers must be listed in INCREASING order."
	exit 4
fi

#Test Triangle Types
#Use (( )) for arithmetic

#Triangle
if ((a + b <= c));  then
	echo "$a, $b, and $c are NOT the sides of a triangle."
#Obtuse
elif ((a*a + b*b < c*c)); then
	echo "$a, $b and $c are the sides of an obtuse triangle."
#Right
elif ((a*a + b*b == c*c)); then
	echo "$a, $b and $c are the sides of a right triangle."
else
	echo "$a, $b, and $c are the sides of an acute triangle."
fi

