#CS 279 - Intro to Linux
#Lab 14, Problem 4

#Author: Rob Pacey
#Date Modified: January 20, 2026

#!/bin/bash

#Practice some recent commands

echo "Rob Pacey"
echo ""
echo "About to run the date command..."

#Format descriptors of choice

date +"Today is %A, %B %d, %Y"
echo ""

echo "About to run the cal command..."

#Month and year of choice

cal 2 2026
echo ""

echo "About to run the uname command..."
uname -a
echo ""

echo "About to run the du command..."
du -a ~/Homework/CS279
du -s ~/Homework/CS279
echo ""

echo "About to run the uptime command..."
uptime
echo ""

echo "About to run the time command..."
time lsof
echo ""
