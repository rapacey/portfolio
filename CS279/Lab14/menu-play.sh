#CS 279 - Intro to Linux
#Lab 14, Problem 2

#Script Name: menu-play.sh
#Author: Rob Pacey
#Last Modified: January 20, 2026

#!/bin/bash

#Output a menu of at least 5 options
#Ask the user to enter an option and handle the option
#Repeat until the user enters "quit" option from the menu

#Menu list as a function

menu()
{
	printf "%s\n" "----------------------------"
	printf "%s\n" "Linux Command Options"
	printf "%s\n" "----------------------------"
	printf "%s\n" "1) See CPU Info"
	printf "%s\n" "2) See current time"
	printf "%s\n" "3) See current search path"
	printf "%s\n" "4) See available locales"
	printf "%s\n" "5) See the user database"
	printf "%s\n" "6) See available shells"
	printf "%s\n" "7) See mounted filesystems"
	printf "%s\n" "8) See disk usage"
	printf "%s\n" "9) Quit"
	printf "\n"
	printf "%s\n" "Please enter an option number:"
	read choice
}

#While loop with the case statement for each selected menu option

while true
do
	menu

	case $choice in 
		1) 
		echo "CPU info:"
		lscpu
		;;
	
		2)
		echo "Current time: $(date)"
		;;
	
		3)
		echo "Current search path is: $PATH"
		;;

		4)
		echo "Available locales:"
		locale -a
		;;

		5)
		echo "User database:"
		cat /etc/passwd
		;;

		6)
		echo "Available shells:"
		cat /etc/shells
		;;

		7)
		echo "Filesystems mounted at startup:"
		cat /etc/fstab
		;;

		8)
		df -hT
		;;

		9) 
		echo "Quitting program..."
		break 2
		;;

		*)
		echo "Invalid choice '$choice'. Please try again."
		;;
	esac
done
