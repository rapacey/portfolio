#!/bin/bash

# rematch-play
# trying out the BASH_REMATCH array
#
# by: Sharon Tuttle
# last modified: 2022-10-26

line="moo cow annabeth bailey calculus dodge"

echo
echo "\$line is: <$line>"
echo "using RE: a(.*)b(.*)c(.*)d"
echo

if [[ "$line" =~ a(.*)b(.*)c(.*)d ]]
then
    i=0
    for match in "${BASH_REMATCH[@]}"
    do
        echo "\${BASH_REMATCH[$i]} is <${BASH_REMATCH[$i]}>"
	let i=i+1
    done
fi
