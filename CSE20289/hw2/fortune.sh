#!/bin/bash

#CSE 20289 - Systems Programming
#University of Notre Dame
#Homework 2 - Scripting the Shell

#Rob Pacey
#January 28, 2026

#Initial Message -> Prompt for Question -> Display a Prediction -> Blank Question Reprompt -> Quit after one non-blank question

#Handle Signals

cleanup() {
	echo ""
	echo "Leaving so soon?" | cowsay
	exit 1
}

#Trap (Link signals to the cleanup function)

trap cleanup HUP INT TERM

#Ask a question

echo "Hello, what question do you have for me today?" | cowsay

#Loop until question is not blank

while [ -z "$question" ]; do
	echo -n "Question?"
	read question
done

PREDICTION=$(shuf -n 1 << 'EOF'
It is certain
It is decidedly so
Without a doubt
Yes, definitely
You may rely on it
As I see it, yes
Most likely
Outlook good
Yes
Signs point to yes
Reply hazy try again
Ask again later
Better not tell you now
Cannot predict now
Concentrate and ask again
Don't count on it
My reply is no
My sources say no
Outlook not so good
Very doubtful
EOF
)

echo "$PREDICTION" | cowsay
