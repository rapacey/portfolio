#!/bin/bash

#CSCI 132 - Practical Unix Progamming

#Single argument which is the name of a file containing multiple DNA strings

if [ "$#" -ne 1 ]; then 
	echo "Usage: $(basename "$0") filename."
	exit 1
fi

#Check if a given filename can be read

if [ ! -r "$1" ]; then
	echo "Error: Filename cannot be read."
	exit 2
fi

#awk skips the header and grabs the first column

awk 'NR > 1 {print $1}' "$1" | while read -r raw_line; do

	#Clean - Keep ONLY letters
	line=$(echo "$raw_line" | tr -cd 'a-zA-Z')

	#Extract the 4th triplet - characters 10, 11, 12 in each line

	target=${line:9:3}
	count=0		

	#Search for repeats twice later at multiples of three
	for (( i=12; i <= ${#line}-3; i+=3 )); do
		#Extract the current triplet to compare
		current=${line:i:3}
		if [[ "$current" == "$target" ]]; then
			((count++))
		fi
done				#End the FOR loop (the scanning)

	#Print those lines repeated TWICE later in a readable format
	if [ "$count" -ge 2 ]; then
		sed -E 's/.{3}/& /g' <<< "$line"
	fi

done				#End the WHILE loop 

