#!/bin/bash
#
#Script Name: file-type.sh
#
#Author: Rob Pacey
#
#Last Modified: January 13, 2026
#
#This script expects exactly one command-line argument
#If not given exactly one argument, complain and exit with an exit status of 1
#
if [ "$#" -ne 1 ]; then
	echo "Error: Exactly one command-line argument is required."
	echo "Usage: $0 <filename_or_directory>"
	exit 1
fi

#Store the argument in a variable for readability

VALUE=$1

#Check to see if the argument is a regular file

if [ -f "$VALUE" ]; then
	echo "'$VALUE' is a regular file."

#Otherwise check to see if the argument is a directory

elif [ -d "$VALUE" ]; then
	echo "'$VALUE' is a directory."

#If neither, assume the argrument is not a file in the current directory

else
	echo "'$VALUE' does not exist in the current directory."
fi
