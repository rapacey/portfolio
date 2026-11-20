#!/bin/bash

#CS 132 - Practical Unix - CUNY

#Prints all and only the lines in the standard input stream that contain exactly 20 periods

#Arbitrary number of non-periods, possibly none, between each one

grep -xE '([^.]*\.){20}[^.]*'
