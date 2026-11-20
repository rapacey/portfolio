#!/bin/bash

#CSE 374 - Programming Concepts and Tools
#University of Washington, Spring 2023

#Robert Pacey, Homework 2, June 14, 2026

#Create a script that will concatenate the contents of f2 ... fn and put them in f1

#If there are less than 2 arguments, print error message and exit

if [ "$#" -lt 2 ]; then
	echo "Usage: combine outputfilename [inputfilename ...]" >&2
	exit 1
fi

output_file=$1

#If the file already exists, print error message and exit

if [ -e "$output_file" ]; then
	echo "Error: Output file should not exist" >&2
	exit 1
fi

#Remove output_file from arguments list, leaving only the inputs

shift

while [ "$#" -gt 0 ]
do
	cat "$1"
	shift
done &>> "output_file"

exit 0
