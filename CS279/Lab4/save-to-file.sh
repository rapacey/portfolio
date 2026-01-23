#CS 279 - Intro to Linux
#Script Name: save-to-file.sh
#Author: Rob Pacey
#Last Modified: January 14, 2026

#!/bin/bash

#Print to the screen a message that includes how many command line arguments the script was called with

echo "This script was called with $# command line arguments."

#If no arguments, exit with error code 1

if [ $# -eq 0 ]; then 
	echo "Error: No command-line arguments were given."
	exit 1
else
	echo -n "Please input the name of a file to be written to: "
	read file_name	

#Echo each command line argument such that it is appended on its own line to a file with the specified name

for i in "$@"
do
	echo "$i" >> "$file_name"
done

echo "The command line arguments have been appended to: $file_name"

fi
