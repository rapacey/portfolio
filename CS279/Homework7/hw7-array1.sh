#CS 279 - Intro to Linux
#Homework 7
#Script Name: hw7-array1.sh

#Rob Pacey
#January 16, 2026

#---------------------------------------------------------

#!/bin/bash

#Create an array "stuff" containing at least 7 but no more than 10 elements of your choice

stuff=("University of Illinois" "Indiana University" "University of Iowa" "University of Michigan" "Michigan State University" "University of Minnesota" "Northwestern University" "Ohio State University" "Purdue University" "University of Wisconsin")

#Add a single array element to "stuff" with index 13

stuff[13]="Rob Pacey"

#Use the array to echo a message including the element with index 3

echo "The third element in the array is: "
echo ${stuff[3]}

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
