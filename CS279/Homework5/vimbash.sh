#Create a script that properly starts a Bash shell script with the CS 279 required parts i.e.
#
#1 #!/bin/bash
#2 blank line
#3 CS 279 - Intro to Linux
#4 Script Name:
#5 Author: Rob Pacey
#6 Date:
#
#Then call vim to open this script
#
#-----------------------Script Begins Below---------------------------------
#
#!/bin/bash
#
#This script expects one command-line argument, the name of the Bash shell script to be edited
#
#Future Update: Make sure this script works with multiple command line arguments, as vim can open multiple files at once in buffers, splits, or tabs
#
#If it is called with no command-line arguments, prompt the user to enter the name of a Bash shell script file to be edited

script=$1

if [ "$#" -ne 1 ]; then
	echo "Please enter the name of the Bash shell script file to be edited: "
	read script
fi

#If this file does not currently exsist, create it and write to it the CS 279 required parts listed above

if [ ! -f "$script" ]; then
	echo "File does not exist. Creating template..."

	#Get current date
	DATE=$(date)
	
	cat <<EOF > "$script"
#!/bin/bash
	
#Script Name: $script
#Author Name: Rob Pacey
#Date: $DATE
	
EOF

#Make script executable 

chmod +x "$script"
	
	echo "Template created and permissions set to executable."
else 
	echo "Opening existing file: $script"
fi 

#Open the file in vim

vim "$script"
