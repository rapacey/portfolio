#!/usr/bin/perl

#Perl by Example - Fifth Edition
#Chapter 5 - Example 5

use strict;
use warnings;

my $filename = "datebook.txt";

#Assign the contents of the datebook file to an array (slurping the file)

open(my $datebook, "<", $filename ) or die "Can't open $filename: $!";
my @datebook = <$datebook>;
close($datebook);

#Prompt the user to search for a person in the datebook

my $search;
while (1) {
    print "Enter a name to search for (or type 'quit' to exit): ";
    chomp($search = <STDIN>);

    last if $search =~ /quit/i;

#Search for matching lines

my @results = grep { /\Q$search\E/i } @datebook;

    if (@results) {
        print "Found " . scalar(@results) . " matching entry/entries for '$search':\n";
        print @results;
   
        if (@results > 1) {
            print "Multiple entries found. Please refine your search.\n";
            next;
        }

        last;   #Found exactly 1 match, proceed to update
} else {
    print "No entries found for '$search'. Please try again.\n";
}
}

exit if $search =~ /^quit/i;

#Locate the record and extract the current phone number
my $matched_index;
my $current_number;

for my $i (0 .. $#datebook) {
    if ($datebook[$i] =~ /\Q$search\E/i) {
        $matched_index = $i;
        my @fields = split(/:/, $datebook[$i]);
        $current_number = $fields[1];
        last;
    }
}

print "Current phone number for '$search': $current_number\n";

#Collect and validate the new phone number from the user

my $new_number = "";
while ($new_number !~ /^\d{3}-\d{3}-\d{4}$/) {
    print "What is the new phone number for $search? (format: 123-456-7890): ";
    chomp($new_number = <STDIN>);
    if ($new_number !~ /^\d{3}-\d{3}-\d{4}$/) {
        print "Invalid format. Please try again.\n";
    }
}

print "$search\'s phone number is currently $current_number\n";

#Update the record field
$datebook[$matched_index] =~ s/\Q$current_number\E/$new_number/;

#Save the changes back to the file

open(my $out_fh, ">", $filename) or die "Can't write to $filename: $!";
print $out_fh @datebook;
close($out_fh);

print $datebook[$matched_index];
