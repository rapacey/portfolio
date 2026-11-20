#!/bin/bash

#CSCI 132 - Practical Unix
#CUNY - Hunter College
#Professor Weiss, Fall 2018

#Assignment 3, Task 3-2
#Rob Pacey
#January 27, 2026

#Sample Output
#realname.sh sweiss r2d2 tbw
#sweiss: Stewart Weiss
#tbw: Tom Walter

#For each command line argument, if the word is the username of a user on the network, display this user name and the full name of the user
#If the user does not have an account, the script should return nothing

#Check for at least one argument

if [[ $# -eq 0 ]]; then
	echo "Usage: realname username1 [username2..]"
	exit 1
fi

#Valid username regex

valid_regex='^[a-zA-Z0-9._-]+$'

for arg in "$@"; do

#Check the input for disallowed username characters

if ! [[ $arg =~ $valid_regex ]]; then
	echo "Error: '$arg' is not a valid Linux username format."
	exit 2
fi
done

#Process passwd file to output requested data

for arg in "$@"; do
	cat /etc/passwd | grep "^$arg:" | awk -F: '{print $1 ": " $5}'
done
