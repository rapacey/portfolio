#!/usr/bin/bash

#Write a shell script that takes a filename as an argument.
#Your program will change the numbers to text for each
#number in between 0-9, inclusive.

file=$1

#Check that a filename argument was provided

if [[ -z "$file" ]]; then
    echo "Error: No filename provided. Usage: $0 <filename>" >&2
    exit 1
fi

#Check that it is a regular file, readable and writable

if [[ ! -f "$file" ] || [ ! -r "$file" ] || [ ! -w "$file" ]]; then
    echo "Error: $file must exist and be both readable and writable." >&2
    exit 1
fi

words=(zero one two three four five six seven eight nine)

for i in {0..9}; do
    sed -i "s/$i/${words[$i]}/g" "$file"
done
