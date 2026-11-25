#!/usr/bin/bash

# Write a script that takes in a number and a string as command line arguments.
# If the number is odd, print out the string 5 times with a different multiple appended each time.
# If the number is even, print out the string 5 times with a random number (0 to 99) appended each time.

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <number> <string>" >&2
  exit 1
fi

number="$1"
string="$2"

# Check valid integer (allows optional leading '-')
if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
  echo "Error: First argument must be an integer." >&2
  exit 2
fi

if [ -z "$string" ]; then
  echo "Error: The second argument is required." >&2
  exit 3
fi

for i in {1..5}; do
  if (( number % 2 != 0 )); then
    # Odd: append a different multiple each time
    printf '%s%d\n' "$string" "$(( number * i ))"
  else
    # Even: append a random number (0 to 99) each time
    printf '%s%d\n' "$string" "$(( RANDOM % 100 ))"
  fi
done
