#!/bin/bash
#
#Script Name: backup-to.sh
#
#Author: Rob Pacey
#
#Last Modified: January 13. 2026
#
#Find out where the non-directory regular files in the current working directory should be backed up to
#If no command line arguments are given, ask the user to enter name of directory to which to back up the files and read in what they enter
#Otherwise assume the first command-line argument is the name of the directory to which to backup the files

if [ "$#" -eq 0 ]; then
	echo "No arguments given."
	read -p "Please enter the name of the directory to back up the files to: " BACKUP_DIR
else 
	BACKUP_DIR=$1
fi

#If a file with the name requested for the backup directory currently exists and is not a directory file, complain & exit error status 1

if [ -e "$BACKUP_DIR" ] && [ ! -d "$BACKUP_DIR" ]; then 
	echo "Error: File currently exists and is not a directory file."
	exit 1
fi

#If a file with the name requested for the backup directory does NOT currently exist, create it
#Try to copy all non-directory files to the desired directory using a loop and an if statement

if [ ! -e "$BACKUP_DIR" ]; then
	mkdir "$BACKUP_DIR"
fi

for item in * 
do 
	if [ -f "$item" ]; then
		
	cp "$item" "$BACKUP_DIR/"
	
	fi
done

#Echo to the screen a descriptive message and output the contents of the backup directory

echo "Preparing list of contents in $BACKUP_DIR: "
ls "$BACKUP_DIR"




