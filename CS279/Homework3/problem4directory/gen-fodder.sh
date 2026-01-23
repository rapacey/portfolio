#!/bin/bash
#
#Script Name: gen-fodder.sh
#
#Author: Rob Pacey
#
#Last Modified: January 13, 2026
#
#Use a for loop in the current directory to create 20 files
#Each file should contain one line with the file's name
#Each file should also contain a second line with any line of text that also includes the file's number
#
for i in {1..20}					#Array of 20 files
do
	touch "test${i}.txt"				#Create file
	echo "test${i}.txt" > "test${i}.txt" 		#Output file name to Line 1
	echo "File Number: ${i}" >> "test${i}.txt"	#Append file number to Line 2
done

