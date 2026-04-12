#!/usr/bin/perl
use strict; 
use warnings;

#Data Transformation Requirements
#ID - extract the 5 digits only
#Last Name and First Name - capitalize and trim spaces
#Email - Strip all spaces and force the string to lowercase

my $filename = 'applicants.txt';

open(my $fh, '<', $filename) or die "Could not open '$filename' $!";

#Loop through each line

while (my $line = <$fh>) {
    chomp $line;
    #Assign the list returned by subroutine cleanup to 4 named variables
    my ($id, $first, $last, $email) = cleanup($line);

    #Validation Step - Check for missing fields and skip to next line if necessary
    if ($id eq "" || $id =~ /\|/ || $last eq "") {
	    warn "WARNING: Skipping malformed record on line $.\n";
	    next; 	#Skip to the next line in applicants.txt
    }

    #Output in CSV format
    print qq{"$id","$first","$last","$email"\n}; 
}

#Function to clean each line of data
sub cleanup {
    
    my ($line) = @_;        #Pass arguments to subroutine using @_

    #Get just the 5-digit ID number from the beginning of each line
    my $id = substr($line, 3, 5);   
    
    #Locate the name markers using index
    my $name_start = index($line, "|Name:") + 6;
    my $name_end = index($line, "|Email:");
    my $raw_name = substr($line, $name_start, $name_end - $name_start);

    #Comma position to split first and last name
    my $comma_position = index($raw_name, ',');
    
    #Cleaned first name
    my $raw_first = substr($raw_name, $comma_position +1);  #AFTER the comma is the first name
    my $first = lc($raw_first); #Convert to all lowercase
    $first =~ tr/ //d;          #Remove spaces
    substr($first, 0, 1) = uc(substr($first, 0, 1)); #Capitalize first name

    #Cleaned last name
    my $raw_last = substr($raw_name, 0, $comma_position);   #BEFORE the comma is the last name
    my $last = lc($raw_last); 	#Convert to all lowercase
    $last =~ tr/ //d;           #Remove spaces
    substr($last, 0, 1) = uc(substr($last, 0, 1)); #Capitalize last name

    #Cleaned email address
    my $raw_email = substr($line, $name_end +7);    #Get just the email address
    my $email = lc($raw_email); #Convert to all lowercase
    $email =~ tr/ //d;          #Remove spaces 

    return ($id, $first, $last, $email);    #Send the data back
}
