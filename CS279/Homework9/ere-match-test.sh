#!/bin/bash

# ere-match-test
#
# demo that an ERE does indeed work with =~ in [[ ]]
#

filename=$1

while read next_line
do

    # if [[ "$next_line" =~ (dog|cat)(fish|fight) ]]
    
    # if [[ "$next_line" =~ ^([A-Z]|[0-9])+$ ]]

    # if [[ "$next_line" =~ ^([a-z]|[0-9]){4}$ ]]

    if [[ "$next_line" =~ ^(\+|-)?[0-9]+$ ]] 
    then
        echo "matched:     $next_line"
    else
        # echo -n "not matched: $next_line"
	echo -n ""
    fi
done < "$filename"
