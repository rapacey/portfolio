#CS 279 - Intro to Linux
#Lab 9, Problem 4

#Rob Pacey
#January 18, 2026

#Script Name: grab-comments.sh

#!/bin/bash

#One command line argument

if [ "$#" -ne 1 ]; then
	printf "%s\n" "Usage: grab-comments.sh <file>"
	exit 1
fi

#Verify the argument is a regular file

file=$1

if [ ! -f "$file" ]; then
	printf "%s\n" "Error: Not a regular file"
	exit 2
fi

#If argument is a regular file, append #CommentLines to file

if [ -f "$file" ]; then
	echo "file: $file" >> saved-comments.txt
	grep '^\#' "$file" >> saved-comments.txt
	printf "%s\n" "Bash shell script comments captured: "
	cat -n saved-comments.txt
fi
