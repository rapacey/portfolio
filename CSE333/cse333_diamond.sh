#!/usr/bin/bash

#ASCII Art
#Create a simple ASCII art diamond of variable size based on user input

getdigit(){
    local ch
    while IFS=  read -rn1 ch; do
    if [[ "$ch" =~ ^[0-9]$ ]]; then
        printf "%s\n, "$ch"
        return 0
    fi
done
return 1
}

printf "I will print a diamond for you, enter a size between 1-9: "

if ! size=$(getdigit); then
    exit 1
fi

if [ "$size" -eq 0 ]; then
    exit 0
fi

#Calculate Row Geometry

total_rows=$(( 2 * size - 1 ))
mid=$(( size - 1 ))

#Loop row index

for (( r=0; r<total_rows; r++ )); do
    if [ "$r" -ge "$mid" ]; then
        dist=$(( r - mid ))
    else
        dist=$((mid - r ))
    fi

    #Number of '*' characters on this row: 1 at the tips, growing by 2 per step towards the middle
    stars=$(( 2 * (size-dist) - 1 ))

    #Print leading spaces to center the row
    if [ "$dist" -gt 0 ]; then
        printf '%*s' "$dist" ''
    fi

    #Avoid trailing spaces
    printf -v star_pad '%*s' "$stars"''
    printf '%s\n' "${star_pad// /*}"
done