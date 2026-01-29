#!/bin/bash

#Function Definitions

usage() {
	cat 1>&2 <<EOF
Usage: $(basename "$0") [zipcode] 
-c	Use Celsius degrees instead of Fahrenheit for temperature
-f	Display forecast text

If zipcode is not provided, then it defaults to $ZIPCODE.
EOF
	exit 0
}

weather_information() {

	#Fetch weather information from URL based on ZIPCODE
	WEATHER=$(curl -sL -A "Mozilla/5.0" "https://forecast.weather.gov/zipcity.php?inputstring=$ZIPCODE")
}

celsius() {
	#grep the class with Celsius temp
	#use a double cut then xargs to clean up whitespaces

	echo "$WEATHER" | grep "myforecast-current-sm" | cut -d ">" -f 2 | cut -d "&" -f 1 | xargs
}

fahrenheit() {
	#grep the class with Fahrenheit temp
	#use a double cut then xargs to clean up whitespaces
	echo "$WEATHER" | grep "myforecast-current-lrg" | cut -d ">" -f 2 | cut -d "&" -f 1 | xargs
}

forecast() {
	#grep the 'current-conditions' class
    	#use a double cut then xargs to remove the empty spaces
   	echo "$WEATHER" | grep "myforecast-current\"" | cut -d ">" -f 2 | cut -d "<" -f 1 | xargs
}

#Default Values

CELSIUS=0
FAHRENHEIT=0
ZIPCODE="46556"

#Argument Parsing

while [ $# -gt 0 ]; do
	case "$1" in
		-c) CELSIUS=1 ;;
		-f) FORECAST=1 ;;
		-h) usage ;;
		[0-9]*)	ZIPCODE="$1" ;;		#Replace default if option used
		*) usage ;;			#Anything else is an error
	esac
	shift			
	#Shift is used inside a loop that encloses a case statement to process command-line arguments one by one
done

#Call the function here to fetch the data
weather_information

#Determine the temperature value

if [ $CELSIUS -eq 1 ]; then
	TEMP=$(celsius)
else
	TEMP=$(fahrenheit)
fi

#Print forecast if -f was passed

if [ "$FORECAST" -eq 1 ]; then
	F_OUT=$(forecast | xargs)

	#If it's still empty, use "NA"
	if [ -z "$F_OUT" ]; then F_OUT="NA"; fi
	echo "Forecast:    $F_OUT"
fi

#Print Temperature

CLEAN_TEMP=$(echo "$TEMP" | xargs)
echo "Temperature: $CLEAN_TEMP degrees"
