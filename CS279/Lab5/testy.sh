#CS 279 - Intro to Linux
#Lab5
#Script Name: testy.sh

#Author: Rob Pacey
#Date: January 16, 2026

#-------------------------------------

#!/bin/bash

#Exactly one command line argument

if [ "$#" -ne 1 ]; then 
	echo "Script expects exactly ONE command-line argument."
	echo "Usage: $0 <file_of_interest>"
	exit 1
fi

#Set variable to value of the 1st command line argument

if [ "$#" -eq 1 ]; then
	file_of_interest=$1
fi 

#If the file doesn't exist, then create it

if test ! -e "$file_of_interest"; then
	touch "$file_of_interest"
fi

#Test file size

if test -s "$file_of_interest"; then
	echo "File is not empty."
else
	echo "File is empty."
fi

#Directory test

if test -d "$file_of_interest"; then
	echo "$file_of_interest is a directory. The contents of $file_of_interest are: "
	ls -l "$file_of_interest"
else
	echo "$file_of_interest is a file. The contents of the $file_of_interest are: "
	less $file_of_interest
fi

#Test execute permissions

if test -x "$file_of_interest"; then 
	echo "$file_of_interest IS executable by this user."
else
	echo "$file_of_interest is NOT executable by this user."
fi

echo "Please enter the name of another file: "
read comp_file

#Make sure the comp_file exists

if [ ! -e "$comp_file" ]; then
	touch $comp_file
fi

#Test if file is newer in terms of modified date and time

if [ "$file_of_interest" -nt "$comp_file" ]; then
	echo "$file_of_interest is newer than $comp_file"
else
	echo "$file_of_interest is NOT newer than $comp_file"
fi












