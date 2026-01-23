#!/bin/bash

# array-play
# playing around with Bash arrays during W10-1 class
#
# last modified: January 19, 2026

arr=(Hello World [10]="why not?" [13]=27)

arr[0]=Bonjour

arr[8]=Linux

echo "arr's contents:"

echo ${arr[*]}

echo ""
echo "arr's current indices:"

echo ${!arr[*]}

echo ""
echo "number of elements in arr:"

echo ${#arr[*]}

echo ""
echo "what a list-style for loop does with array arr:"

for element in ${arr[*]}
do
    echo "$element"
done

echo ""
echo "see the difference with \"\${arr[@]}\":"

for element in "${arr[@]}"
do
    echo "$element"
done

echo ""
echo "what if you try to access the other array indices?:"

for ((i=0; i < 14; i++))
do
    echo "LOOKY! <${arr[$i]}>"
done

echo ""
echo "show the length of each array element"

for index in ${!arr[*]}
do
    echo ${#arr[$index]} 
done

for ((i=0; i<14; i++))
do
    echo "LOOKY! <${#arr[$i]}>"
done
