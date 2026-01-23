#!/bin/bash

#CS 45 - Stanford University
#Homework 2, Winter 2023
#Rob Pacey
#January 22, 2026

#Write a shell script that analyzes an input file containing information about Stanford CS Faculty

#Make the script print out each command as it runs it

#set -x 

#1 Make a new subdirectory called analysis

mkdir -p analysis/

#2 Delete any files inside analysis

rm -f analysis/*

#3 For each of the research groups, create a file in analysis with the information of every professor who researches that topic

#Faculty info file

csv=cs_faculty.csv					

#Parallel array of search terms to look for in csv and files to send output to

files=("ai" "bio" "graphics" "security" "systems" "hci" "theory")

terms=("Artificial Intelligence" "Computational Biology" "Computer Graphics" "Computer Security" "Computer Systems" "Human-Computer Interaction (HCI)" "Theory")

#Loop through indices

for i in ${!files[@]}; do
	
	#Use the index to grab one from each list
	grep "${terms[i]}" "$csv" > "analysis/${files[$i]}.csv"
	
	#Count variable counts the number of lines in each .csv that is made
	count=$(wc -l < "analysis/${files[$i]}.csv")

	#4 Create a file big-groups.txt with the names of every research group with more than 10 members
	if [ $count -gt 10 ]; then
		echo "${terms[$i]}" >> analysis/big-groups.txt
	fi
done

#5 Create a file analysis/systems-ai-join.csv with info of every professor who researches both "Artificial Inteliigence" and "Computer Systems"

#Unique command requires its input to be sorted, send sort results in pipe to uniq -d to print only one of each duplicate, then output to the new file

sort analysis/ai.csv analysis/systems.csv | uniq -d > analysis/systems-ai-join.csv

#6 Create a file analysis/names.txt with the names of every faculty member sorted alphabetically
#Make sure the file contains only their names (field 1 in the csv)
#Cut first, then sort

cut -d ',' -f 1 cs_faculty.csv | sort > analysis/names.txt

