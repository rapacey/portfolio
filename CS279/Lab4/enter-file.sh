#CS 279 - Intro to Linux
#Script Name: enter-file.sh
#Author: Rob Pacey
#Last Modified: January 14, 2026
#
#!/bin/bash
#
#Prompt the user to enter a file name of their choice
#
echo "Please enter a file name:"
read name
echo "You entered the file name: $name"		#Confirm user input

#Test file existence

if [ -f $name ]; then
	wc $name
else
	touch $name
	echo "An an empty file has been created with this name: $name"
fi
