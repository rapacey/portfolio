#CS 279 - Intro to Linux
#Lab 13, Problem 3

#Rob Pacey
#January 19, 2026
#A script to use the make_line and highlight functions from lab13-3-functions.sh

source lab13-3-functions.sh

#!/bin/bash

#Call make_line at least 3 times, each time with a different but reasonable pair of arguments

make_line Row 3
echo ""
make_line Boat 1
echo ""
make_line Merrily 4
echo ""
make_line Dream 2

echo ""

highlight Stream

echo ""

echo "Please enter a desired string to highlight (like the example above): "
read input

echo ""

highlight "$input"
echo ""
