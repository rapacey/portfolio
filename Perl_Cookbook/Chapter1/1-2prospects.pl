#!/usr/bin/perl
use strict;
use warnings;

#Take a file with holes in the data and produce a database import without NULL errors
#Final output in CSV format ID,First,Last,Term,Residency,Status

my $filename = '1-2prospects.txt';

open(my $fh, '<', $filename) or die "Could not open '$filename' $!";

#CSV Header
print qq{"ID", "First", "Last", "Term", "Residency", "Status"\n};

while (my $line = <$fh>) {
	chomp $line;
	
	#Raw values from the subroutine
	my ($id, $first, $last, $term, $residency) = cleanup($line);

	#Set the Audit Flag before assigning default values
	#If either field is an empty string, mark for remediation
	my $status = ($term eq "" || $residency eq "") ? "DATA_REMEDIATED" : "CLEAN";
	
	#Assign default values as needed
	$term ||= "Fall 2026";
	$residency ||= "O";		# O = Out of State
	
	#Output the cleaned row
	print qq{"$id","$first","$last","$term","$residency","$status"\n};
}

#Function to clean each line of data
sub cleanup {
    
    #Pass arguments to subroutine using @_
    my ($line) = @_;        					
    
    #Get the student ID number
    my $id = substr($line, 3, 4);   
    
    #Locate the name markers
    my $name_start = index($line, "|Name:") + 6;
    my $name_end = index($line, "|Term:");
    my $raw_name = substr($line, $name_start, $name_end - $name_start);

    #Comma position to split first and last name
    my $comma_position = index($raw_name, ',');
    
    my $raw_first = substr($raw_name, $comma_position +1);  	#AFTER the comma is the first name
    my $first = lc($raw_first); 				#Convert to all lowercase
    $first =~ tr/ //d;          				#Remove spaces
    substr($first, 0, 1) = uc(substr($first, 0, 1)); 		#Capitalize first name

    #Cleaned last name
    my $raw_last = substr($raw_name, 0, $comma_position);   	#BEFORE the comma is the last name
    my $last = lc($raw_last); 					#Convert to all lowercase
    $last =~ tr/ //d;           				#Remove spaces
    substr($last, 0, 1) = uc(substr($last, 0, 1)); 		#Capitalize last name
    
    my $term_start = index($line, "|Term:") + 6;
    my $term_end = index($line, "|Res:");
    my $term = substr($line, $term_start, $term_end - $term_start);
    
    my $residency_start = index($line, "|Res:") + 5;
    my $residency = substr($line, $residency_start);
    $residency =~ tr/ \t\n\r//d;

    return ($id, $first, $last, $term, $residency);    #Send the data back
}

close $fh;
