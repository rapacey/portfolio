#!/bin/bash
#
#Script Name: use-fodder.sh
#
#Author: Rob Pacey
#
#Last Modified: January 13, 2026
#
#Create a script with a "List Style" for loop that uses command subsitution
#Employ file globbing using the wildcard character to list ONLY:
#
#File names that start with test and end with .txt in the current directory
#
#For each of these files, append the line "TAG gotcha" to the end of these files

for file in test*.txt				#Find files meeting above requirements
do 
	echo "TAG gotcha" >> "$file" 		#Append to each file found
done

