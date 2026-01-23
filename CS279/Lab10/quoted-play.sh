#!/bin/bash

# adapted from: a Linux Journal article:
# "Bash Arrays" - Mitch Frazier - June 2008

stuff=("first item" "second item" "third" "item")

echo ""
echo "Number of items in original array: ${#stuff[*]}"

for i in ${!stuff[*]}
do
    printf "   %s\n" "${stuff[$i]}"
done

# trying UNQUOTED expansion

arr=(${stuff[*]})

echo 
echo "After unquoted expansion: ${#arr[*]}"
for i in ${!arr[*]}
do
    printf "   %s\n" "${arr[$i]}"
done

# trying QUOTED expansion with [*]

arr=("${stuff[*]}")

echo 
echo "After * quoted expansion: ${#arr[*]}"
for i in ${!arr[*]}
do
    printf "   %s\n" "${arr[$i]}"
done

# trying QUOTED expansion with [@]

arr=("${stuff[@]}")

echo 
echo "After @ quoted expansion: ${#arr[*]}"
for i in ${!arr[*]}
do
    printf "   %s\n" "${arr[$i]}"
done
