#CS 279 - Intro to Linux
#Homework 7
#Script Name: hw7-array1.sh

#Rob Pacey
#January 17, 2026

#---------------------------------------------------------

#!/bin/bash

#Complain and exit without a command line argument

if [ "$#" -lt 1 ]; then
	echo "Error: Must provide at least one command-line argument."
	exit 1
fi

#Contents of array "stuff" should now be the command line arguments

stuff=("$@")

#Add a single array element to "stuff" with index 13

stuff[13]="Rob Pacey"

#Only echo the value of the element of stuff [3] if its length is non-zero
#Otherwise set stuff [3] to a value of your choice

if ${stuff[3]} -ne 0; then
	echo "${stuff[3]}"
else
	stuff[3]="three"
fi

#Use the array to echo a message including the size of (number of elements in ) the array

echo "Number of elements in array: "
echo ${#stuff[*]}

#Use the array to echo a message including the indices of the array

echo "The array's current indices are: "
echo ${!stuff[*]}

#Write a loop that will display the elements in the array, one element per line

for index in "${stuff[@]}"; 
do
	echo "$index"
done
