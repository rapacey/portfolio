#CS 279 - Intro to Linux
#Script Name: pair-lines.sh
#Author: Rob Pacey
#Last Modified: January 16, 2026
#
#----------------------------------------------------------------

#!/bin/bash

#Script expects exactly two command-line arguments

if [ "$#" -ne 2 ]; then 
	echo "Usage: $0 <filename> <string of interest>"
	exit 1
fi

file=$1
string=$2

#First argument should be a regular, readable file

if [ ! -f "$file" ] || [ ! -r "$file" ]; then
	echo "Error: File is not a regular file or is not readable."
	exit 2
fi

#Find lines with at least two instances of the string

match=$(grep -iE "$string.*$string" "$file")

#Print the lines if any exist

if [ -n "$match" ]; then
	echo "$match"
	line_count=$(echo "$match" | wc -l)
	echo "-----"
	echo "Found $line_count line(s) containing at least two instances of '$string'"
else
	echo "No lines found with two or more instances of '$string'"
fi
