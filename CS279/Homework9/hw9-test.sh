#CS 279 - Into to Linux
#Homework 9, Problem 5

#Rob Pacey
#January 18, 2026

#Make a script to test the functions from Problem 4

#!/bin/bash

source hw9-functions.sh 

echo "---Testing is_quant---"
echo

echo "Calling function is_quant with no arguments"
is_quant
printf "%-30s %s\n" "Testing is_quant with no arguments:" "$?"
echo 

echo "Calling function is_quant with more than one argument"
is_quant 1 2
printf "%-30s %s\n" "Testing is_quant with multiple arguments:" "$?"
echo

echo "Calling function is_quant with an unsigned integer"
is_quant 20
printf "%-30s %s\n" "Testing is_quant 20:" "$?"
echo

echo "Calling function is_quant with a non-integer (Banana)"
is_quant Banana
printf "%-30s %s\n" "Testing is_quant Banana:" "$?"
echo

echo "Calling function is_quant with a negative number"
is_quant -5
printf "%-30s %s\n" "Testing is_quant -5" "$?"
echo

echo "---Testing make_line---"
echo

echo "Calling function make_line with the wrong number of arguments"
make_line three 2 many
echo "Exit status of make_line with wrong number of arguments: $?"
echo

echo "Calling function make_line with a non-number as the second argument"
make_line Ying Yang
echo "Exit status of non-number second argument: $?"
echo

echo "Calling function make_line with two good arguments"
make_line Quack 5

backticks=`make_line Quack 5`	#Set variable using command substitution
echo "The captured result of make_line Quack 5 is: $backticks"
echo "Exit status for good call: $?"
echo

echo "Calling function make_line with a negative number as the second argument"
make_line Baa -2
echo "Exit status of a negative number: $?"
echo

echo "About to call make_line with 0 repetitions (Moo 0)..."
zero_test=$(make_line Moo 0)
echo "The result of make_line Moo 0 is: ["$zero_test"]"
echo

