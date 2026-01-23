#CS 279 - Intro to Linux
#Script Name: bkp-txt.sh
#Author: Rob Pacey
#Last Modified: January 16, 2026

#----------------------------------------------------------

#!/bin/bash

#Set a shell variable to the value of /text-backups

backup_dir="./text-backups"

#Copy all files in the current working directory with the suffix .txt to /text-backups

cp *.txt "$backup_dir"

#Change permissions of all files with the suffix .txt in /text-backups to -rw-------

chmod 600 "$backup_dir"/*.txt

#Append the result of calling the date command to a file named backup-dates.txt within /text-backups

date >> "$backup_dir/backup-dates.txt"

#Output a message saying that all .txt files in the current working directory have been backed up

echo "All .txt files have been backed up in $backup_dir"
