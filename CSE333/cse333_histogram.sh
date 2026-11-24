#!/usr/bin/bash

# CSE 333 - Homework 1
# Takes a filename containing one number (0-9) per line and prints a histogram.

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>" >&2
    exit 1
fi

file="$1"

if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "Error: '$file' is not a readable file." >&2
    exit 1
fi

# Initialize digit buckets (0 through 9)
counts=(0 0 0 0 0 0 0 0 0 0)

# Stream and tally single-digit lines
while IFS= read -r line || [[ -n "$line" ]]; do
    # Strip trailing CR if file uses CRLF line endings
    line="${line%$'\r'}"

    if [[ "$line" =~ ^[0-9]$ ]]; then
        ((counts[line]++))
    fi
done <"$file"

# Print histogram rows (rows with count 0 print "<digit> ")
for d in {0..9}; do
    count="${counts[d]}"
    stars=""

    if [ "$count" -gt 0 ]; then
        for ((i=0; i<count; i++)); do
            stars+="*"
        done
    fi

    printf '%s %s\n' "$d" "$stars"
done