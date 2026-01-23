#!/bin/bash
	
#Script Name: rm-empties.sh
#Author Name: Rob Pacey
#Date: Thu Jan 15 02:20:21 PM CST 2026

#Write a script that removes regular files that are empty in the current directory
#Empty files have a size of 0

#Find files that are empty and remove them interactively

find . -maxdepth 1 -type f -empty -exec rm -i {} \;

echo "Finished with file removal."


