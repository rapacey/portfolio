#!/bin/bash

#CSE 20289 - Systems Programming
#University of Notre Dame
#Homework 2 - Scripting the Shell

#Script determines which command is necessary to extract or unpack the archive based on the file extension and executes the appropriate command

if [[ "$#" -eq 0 ]]; then
	echo "Usage: extract.sh argument1 argument2..."
	exit 1
fi

#For loop to process the command line arguments
#Case statement to determine which command to use

for arg in "$@"; do
	case $arg in
		*.tgz | *.tar.gz)
			tar xzvf "$arg"
			;;
		*.tbz | *.tar.bz2)
			tar xvjf "$arg"
			;;
		*.txz | *.tar.xz)
			tar xf "$arg"
			;;
		*.zip | *.jar)
			unzip "$arg"
			;;
		*)
			echo "Unknown archive format: $arg"
			exit 2
			;;
	esac
done

