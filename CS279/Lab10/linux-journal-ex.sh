#!/bin/bash

# adapted from: a Linux Journal article:
# "Bash Arrays" - Mitch Frazier - June 2008

array=("first item" "second item" "third" "item" [6]="sixth" [13]="thirteenth")

echo ""
echo "number of items in original array: ${#array[*]}"

for index in ${!array[*]}
do
    printf "   %s\n" "${array[$index]}"
done

echo ""
echo "Array indexes: "

for index in ${!array[*]}
do
    printf "   %d\n" $index
done

echo ""
echo "Array items and indexes:"

for index in ${!array[*]}
do
    printf "%4d: %s\n" "$index" "${array[$index]}"
done
