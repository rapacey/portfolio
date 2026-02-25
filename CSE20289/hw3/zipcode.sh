#!/bin/bash

#Scrape the zipcodes from website Zip Codes to Go and list all 
#the zipcodes in a specific state or even a particular city.

#Globals

STATE="Indiana"
CITY=""

#Functions

zipcode() {
    echo "$DATA" |
    sed 's/<tr>/\n<tr>/g' |			# Force each table row onto its own line
    grep -i 'td align="center"' | 		# Isolate the zip code data rows
    sed 's/<^>]*>/|/g' |      			# Replace every tag with a pipe
    awk -F'|' -v city="$CITY" '
	BEGIN { IGNORECASE = 1 } 
        {
            #If no city is specified, find the zip anywhere in the row

	    if (city == "") {
		    for(i=1; i<NF; i++) if($i ~ /^[0-9]{5}$/) print $i
		}
		#If a city is specified, check if the row contains the city name
	else if ($0 ~ city) {
		    for(i=1; i<NF; i++) if($i ~ /^[0-9]{5}$/) print $i
		}
	}' | sort -u
}

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -s STATE  	Specify the state to scrape zip codes from (default: IN)"
    echo "  -c CITY    	Specify the city to filter zip codes (optional)"
    echo "  -h	    	Display this help message"
}

#Parse command line arguments

while [[ "$#" -gt 0 ]]; do
    case $1 in
        #Advance the positional parameters to get the value of the state and city
        -s) STATE="$2"; shift ;;
        -c) CITY="$2"; shift ;;
        -h) useage; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; usage; exit 1 ;;
    esac
    shift
done

#Fetch the data after the loop

URL="https://www.zipcodestogo.com/${STATE}/"
DATA=$(curl -sL -A "Mozilla/5.0" "$URL")
echo "DEBUG: Data length is ${DATA}"

#Call the function to get the zip codes

zipcode
