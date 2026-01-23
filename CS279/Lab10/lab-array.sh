#CS 279 - Intro to Linux
#Lab 10, Problem 2

#Script: lab-array.sh
#Rob Pacey
#January 19, 2026

#!/bin/bash

#Create an array with at least 6 items
#At least one item includes at least one blank

array=("Alice" "Queen of Hearts" "Mad Hatter" "The Cheshire Cat" "The Duchess" "White Rabbit" "The Duck")

#At least one item has an index that is 3 greater than the actual number of elements in your array

array[10]="The Dodo"

#Echo a single expression whose value is the number of elements in the array

echo "Number of array elements: ${#array[@]}"
echo ""

#Echo a single expression whose value is all of the array's contents

echo "Array contents: ${array[*]}"
echo ""

#Echo a single expression whose value is all of your array's indices

echo "Array indices: ${!array[@]}"
echo ""

#For loop to echo each element in the array on its own line

for index in "${array[@]}" 
do
	printf "%s\n" "$index"
done

#Add an element

array+=("Lewis Carroll")

#Relist contents of array

echo ""
echo "Added a new element: ${array[*]}"
echo ""

#Slice an array

slice3=(${array[@]:0:3})
echo "First 3 elements: ${slice3[@]}"
