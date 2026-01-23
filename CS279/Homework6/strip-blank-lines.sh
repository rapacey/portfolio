#CS 279 - Intro to Linux
#Author: Rob Pacey
#Date: January 16, 2026
#
#What is a regular expression that will match a blank line in a file?
#
#--------------------------------------------------------------------

#!/bin/bash

#One command line argument, a regular readable file
#Complain and exit if this is not the case

file=$1

if [ "$#" -ne 1 ]; then
	echo "Error: Please enter one valid file name."
	exit 1
fi

#Test to see if file is readable

if [ ! -r "$file" ]; then
	echo "Please check the file's permissions and make sure the file is readable, then run the script again."
	exit 2
fi

#Create a new "stripped" file and output non-blank lines from the original file to it

if [ -r "$file" ]; then 
	touch stripped-$file
	grep . "$file" > stripped-$file		#grep . should match any line containing at least one character
	
	#Use line count function to check the difference between file with blank lines and stripped file without blank lines
	echo "Checking Line Count"
	echo "Line Count with blank lines: $(wc -l "$file")"
	echo "Line Count with blanks removed: $(wc -l stripped-$file)"
fi

