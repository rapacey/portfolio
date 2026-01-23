#
#CS 279 - Intro to Linux
#
#Script Name: stubborn.sh
#
#Author: Rob Pacey
#
#Last Modified: January 14, 2026

#!/bin/bash

#Set the variable given_file to the first command line argument

given_file=$1

#If the resulting variable does NOT contain the name of a file that exists in current working directory

if [ ! -f $given_file ]; then 
	echo "$given_file is NOT a file in the current directory"	#Complain
	echo "Here are the options to choose from: "			#Help user make a valid file choice
	ls								#List files in current directory
fi

while [ ! -f $given_file ]
do
	echo "Please enter the name of a file in the current directory: "
	read given_file
done

ls -ld $given_file

if [ -d $given_file ]; then 
	echo "$given_file is a directory file."
else
	echo "Here is the word count for the given file: "
	wc $given_file
fi

