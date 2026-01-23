#!/bin/bash

#Script Name: backup-all.sh

#Author: Rob Pacey

#Last Modified: January 11, 2026

#Create a new directory named BACKUP in the current working directory

mkdir BACKUP

#Set BACKUP's permissions

chmod u+rwx,go-rwx BACKUP 

#Copy all non-directory files

find . -maxdepth 1 -type f -exec cp {} BACKUP/ \;

#Echo a message to user

echo 
echo "Listing current contents of BACKUP...please wait."
echo

#Output to the screen the current contents of BACKUP

ls BACKUP
