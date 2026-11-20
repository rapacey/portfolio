#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $(basename "$0") <Letter Code> <Filename>"
	exit 1
fi

if [ ! -r "$2" ]; then
	echo "Error: Must be a readable PDB file."
	exit 2
fi

grep "^ATOM" "$2" | grep " $1 " | cut -c 7-11,18-20,31-54


