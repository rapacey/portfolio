#CS 279 - Intro to Linux
#Homework 9, Problem 4
#Script Name: hw9-functions.sh

#Rob Pacey
#January 18, 2026
#
#Because it will be included in other shell scripts using source, do NOT start it with the usual #!/bin/bash

#------------------------------------------------------------------------------------------------------------

#Function Goal:

#Use a regular expression in an if statement to return an exit status of 0 (success) if the input is an unsigned integer greater than or equal to zero
#Return a non-zero exit status if the input is not an unsigned integer greater than or equal to zero

#Notes:

#return 0 or return 1 rather than exit 0 or exit 1

#"Silently" work with nothin to standard output, simply return with an appropriate exit status

#If exactly one command line argument isn't given, return a non-zero exit status of your choice

is_quant()
{
	#Check if exactly one argument is provided
	
	if [ "$#" -ne 1 ]; then
		return 1
	fi

	#Check if the argument is an unsigned integer (0 or greater)

	if
		[[ "$1" =~ ^[0-9]+$ ]]; then
		return 0
	else
		return 2
	fi 
}

make_line()
{
	#Check for exactly two arguments
	
	if [ "$#" -ne 2 ]; then
		return 1
	fi

	#Use is_quant function to validate the second argument
	
	if ! is_quant "$2"; then
		return 2
	fi

	local string="$1"
	local count="$2"
	
	#Iterate over a list of items (print string every time from 1 to X, where X is the count number

	for i in $(seq 1 "$count"); do
		echo -n "$string"
	done

	echo ""		#Add a new line at the very end
}

