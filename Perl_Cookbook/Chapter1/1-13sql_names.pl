#!/usr/bin/perl
use strict;
use warnings;

#Write a script to process a file with apostrophe and hyphenated first and last names

#Final output should be in the form of an SQL statement

my $filename = '1-13sql_names.txt';

open(my $fh, '<', $filename) or die "Could not open '$filename' $!";

#Loop through each line 
while (my $line = <$fh>) {
    chomp $line;
    my ($id, $first, $last) = cleanup($line);

#SQL Escaping AFTER name cleanup 
#Swap one ' for two ''
$first =~ s/'/''/g;
$last =~ s/'/''/g;

#Output in SQL Format
print qq{INSERT INTO Prospects (ID, FirstName, LastName) VALUES ('$id', '$first', '$last')\n};
}

#Function to cleanup names 

sub cleanup {

    my ($line) = @_;

    #Get the student ID number from beginning of line
    my $id = substr($line, 3, 4);

    #Locate the name markers
    my $name_start = index($line, "|Name:") +6;
    my $raw_name = substr($line, $name_start);

    #Split First and Last
    my $comma_position = index($raw_name, ',');
    my $raw_last = substr($raw_name, 0, $comma_position);
    my $raw_first = substr($raw_name, $comma_position +1);

    #Clean and Case
    my @cleaned;
    foreach my $name ($raw_first, $raw_last) {
        $name =~ tr/ //d;           #Remove spaces
        $name =~ s/(\w+)/\u\L$1/g;  #Hyphen-aware capitalization
        push @cleaned, $name;
    }

    return ($id, $cleaned[0], $cleaned[1]);
}