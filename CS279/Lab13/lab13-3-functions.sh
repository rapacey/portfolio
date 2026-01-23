#Do NOT start with the usual - these functions will be used in other shell scripts using source

#CS 279 - Intro to Linux
#Lab 13, Problem 3

#Rob Pacey
#January 19, 2026

make_line()
{
	local string=$1
	local count=$2

	#A string to repeat and a number of reps printed to standard output on a single line

	for ((i=0; i<count; i++));
	do 
		printf "%s" "$string"
	done
}

#Example
#make_line Moo 4
#MooMooMooMoo

highlight()
{
	local highlight_string=$1
	local line_length=$(( ${#highlight_string} + 4 ))

	#A line of = characters equal to the length of highlight's string argument plus 4

	make_line "=" "$line_length"
	printf "\n = %s = \n" "$highlight_string"			# = space highlight's string space =
	make_line "=" "$line_length"
}

#For example:
#highlight "CS 279"
