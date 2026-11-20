#!/bin/bash

#The script will output a single number, which is the number of occurrences of a given DNA codon in a given file

#Check for two command line arguments

if [ "$#" -ne 2 ]; then
	echo "Usage: $(basename "$0") <codon> <filename>"
	exit 1
fi

#Check to see if file is readable

if [ ! -r "$2" ]; then
	echo "Error: Cannot read file $2"
	exit 1
fi

#Validate file content (Only a, c, g, t and newline)

if grep -q "[^acgt]" "$2"; then
	echo "Error: File contains invalid characters."
	exit 1
fi

#Define variables

codon=$1
file=$2

#Process: Fold into 3-character lines and count matches

fold -w 3 "$file" | grep -xc "$codon"
