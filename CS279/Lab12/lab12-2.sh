#CS 279 - Intro to Linux
#Lab 12, Problem 2

#Script Name: lab12-2.sh

#Author: Rob Pacey
#Date: January 19, 2026

#!/bin/bash

echo "Starting state:"
pwd 					#Note where script starts
echo ""

echo "Initial state of lab12-1.txt"
ls -l lab12-1.txt 			#Initial state of the file

echo "Initial state of directory tartest12"
ls -ld tartest12			#Initial state of a different directory
ls -l tartest12

echo "------------------------"
echo "Using gzip and gunzip..."
echo ""

gzip lab12-1.txt			#Compress file
echo "File after gzip:"
ls -l lab12-1.txt.gz			#Show zipped result

gunzip lab12-1.txt.gz			#Uncompress file
echo "File after gunzip:"
ls -l lab12-1.txt			#Show unzipped result

echo "------------------------"
echo "Creating tar file..."
echo ""

touch tartest12/sample_file.txt
tar -cvf Lab12.tar tartest12		#Create tar file of directory tartest12
echo "Resulting tar file:"
ls -l Lab12.tar				#Show tarred file result

echo ""
echo "------------------------"
echo "Changing to a new directory: "
mkdir -p ../Lab12_Copy
cd ../Lab12_Copy

cp ../Lab12/Lab12.tar .			#Copy file into current directory

echo ""
echo "-------------------------"
echo "Unpacking tar in the new location:"
tar -xvf Lab12.tar			#Unpack tar file copy

echo ""
echo "-------------------------"
echo "Showing copy is now in a different directory"
pwd
ls -ld tartest12				#Show what was unpacked
ls -l tartest12

