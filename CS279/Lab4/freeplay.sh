#CS 279 - Intro to Linux
#Lab 4, Problem 3
#
#Script Name: freeplay.sh
#Author: Rob Pacey
#Last Modified: January 14, 2026

#!/bin/bash

#Set a local shell variable to the result of calling a command of your choice in backquotes

shell='test'

#Screen messsage with the value of the shell variable

echo "The value of the local shell variable is: $shell"
echo

#Create a loop that noticeably repeats an action

for i in {1..3}
do
	echo "Are we going forwards or backwards ?"
	echo
	echo "Are we going forwards or backwards ?" | tr ' ' '\n' | tac | tr '\n' ' '
	echo -e "\n"
done
