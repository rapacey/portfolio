#CS 279 - Intro to Linux
#Lab 10, Problem 3

#Script: grab-for-info.sh
#Author: Rob Pacey
#Date Modified: January 19, 2026

#!/bin/bash

#One command line argument

if [[ "$#" -ne 1 ]]; then
	echo "Usage: $0 <filename>"
	exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "Error: File is not a regular file or does not exist."
	exit 2
fi

filename=$1

#Lines match the pattern; echo BASH_REMATCH values

while IFS= read -r next_line
do
	if [[ $next_line =~ for\ (.+)\ in\ (.+)$ ]]; then
	echo "Found a for loop!"
	echo "Loop Variable: ${BASH_REMATCH[1]}"
	echo "Iterating Over: ${BASH_REMATCH[2]}"
	echo ""
fi
done < "$filename"
