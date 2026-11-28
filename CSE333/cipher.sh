#!/usr/bin/bash

# CSE 333 - Homework 1
# Takes two arguments:
#   $1 - string containing only letters and spaces (at least one letter)
#   $2 - integer with 1 digit or the same number of digits as $1 (excluding '-')

if [[ $# -ne 2 ]]; then
    echo "Error: Usage: $0 <string> <number>" >&2
    exit 1
fi

string="$1"
number="$2"

# Validate string: only letters and spaces, and at least one letter
if ! [[ "$string" =~ ^[a-zA-Z\ ]+$ ]] || ! [[ "$string" =~ [a-zA-Z] ]]; then
    echo "Error: First argument must contain only letters and spaces." >&2
    exit 1
fi

# Validate number: optional '-' followed by digits
if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Second argument must be an integer." >&2
    exit 1
fi

sign=1
digits="$number"

if [[ "$number" == -* ]]; then
    sign=-1
    digits="${number:1}"
fi

if [[ ${#digits} -ne 1 && ${#digits} -ne ${#string} ]]; then
    echo "Error: Number must have 1 digit or ${#string} digits (excluding '-')." >&2
    exit 1
fi

cipher=""
key_idx=0

# Process one character at a time from index 0 up to length of $string - 1
for ((i=0; i<${#string}; i++)); do
    # Extract 1 character at position i
    char="${string:$i:1}"

    # Spaces stay as spaces; skip shifting and don't advance key_idx
    if [[ "$char" == " " ]]; then
        cipher+=" "
        continue
    fi

    # Single-digit key applies the same shift to every letter;
    # multi-digit key pulls the next digit from $digits and advances key_idx
    if [[ ${#digits} -eq 1 ]]; then
        shift=$(( sign * digits ))
    else
        shift=$(( sign * ${digits:$key_idx:1} ))
        ((key_idx++))
    fi

    # Get ASCII decimal code of $char (e.g., 'A' -> 65, 'a' -> 97)
    printf -v ascii '%d' "'$char"

    # Set alphabet start (65 for uppercase A-Z, 97 for lowercase a-z)
    if [[ "$char" =~ [A-Z] ]]; then
        base=65
    else
        base=97
    fi

    # Convert to 0-25 alphabet offset, add signed shift, and wrap around mod 26
    # (Adding 26 before % 26 avoids negative remainders when shift is negative)
    offset=$(( ascii - base + shift ))
    wrapped=$(( ((offset % 26) + 26) % 26 + base ))

    # Convert the wrapped ASCII number back into a character and append to result
    printf -v new_char '\\$(printf '%03o' "$wrapped")'
    cipher+="$new_char"
done

printf '%s\n' "$cipher"
