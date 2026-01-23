#CS 279 - Intro to Linux
#Homework 10, Problem 1
#get-details.sh

#Rob Pacey
#January 21, 2026

#!/bin/bash

shopt -s globstar

#Get detailed information about files in a directory, using a case statement in a for loop

for file in **/*; do					#**/* finds everything at every level (recursive search of this directory)
	if [[ ! -e $file ]]; then			#If it is NOT a file, skip it (for example . and .. directories)
		continue
	fi

	if [[ $file == "get-details.sh" ]]; then	#Skip get-details.sh script so it doesn't grep its own code
		continue
	fi

#Use file globbing above...do NOT be tempted to declare an array($(ls-R)) as this will mess up for any files with spaces in the name

	printf "\n"
	printf "$file"				#Output file name on its own line
	printf "\n"

case $file in
	*.txt)
	wc $file				#Output word count for any .txt file
	;;

	*.sh)	
	grep -E '\$[0-9]|\$@|\$\*]' "$file"	#ERE for any command line arguments i.e. $1, $@, $*	
	;;

	*.gz)
	gzip -l "$file"				#Output results of gzip -l
	;;

	*.tar)
	tar tf "$file"				#Output results of tar tf
	;;

	*)
	if [[ -d $file ]]; then				#Directory check	
		
		count=$(ls -1A "$file" | wc -l)				#Count files in the directory		
		printf "%s\n" "Directory: Contains $count items."
	else
		ls -l $file						#Long listing for everything else
	fi
	;;
	esac 

	printf "\n"				#Add extra space for visual clarity after each iteration of the for loop
done
