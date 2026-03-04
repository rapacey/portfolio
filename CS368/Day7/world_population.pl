#!/usr/bin/perl
use strict;
use warnings;

#CS 368 - Intro to Perl
#University of Wisconsin, Madison
#Day 7 Homework

#Read two input data files containing data about the countries of the world and store that data into useful structures
#Then ask for user input and print a sample report based on the stored data

#Data Structures

my %country_data;
my %world_population;

#Open the country data file

open(my $fh, '<', 'input_country.txt') or die $!;

#Use a while loop to read the file line by line

while (my $line = <$fh>) {
    chomp($line);
    next if $line =~ /^\s*$/;	#Skip empty lines

    my ($code, $short, $long, $region) = split(' : ', $line);
    
    $country_data{$code} = {
    short   => $short,
    long    => $long,
    region  => $region
    };
} 

close $fh;

#Open the population data file

open(my $ph, '<', 'input_population.txt') or die $!;

while (my $line = <$ph>) {
    chomp($line);
    next if $line =~ /^\s*$/;	#Skip empty lines

    my($code, $year, $population) = split(' : ', $line);

    if (exists $country_data{$code}) {
	$world_population{$year}{$code} = $population;
	}	
}

close $ph;

#Main Menu

while (1) {
    print "\n--- Main Menu ---\n";
    print "1. World Population for a Year\n";
    print "2. Population Growth for a Country\n";
    print "3. Top Population Growth\n";
    print "q. Quit\n";

    my $choice = <STDIN>;
    chomp($choice);
    last if ($choice eq 'q' || $choice eq '');

    if      ($choice eq '1') { report_one(); }
    elsif   ($choice eq '2') { report_two(); }
    elsif   ($choice eq '3') { report_three(); }
    else    { print "Invalid choice.\n"; }
}

#Report 1 Function - World Population for a Year

sub report_one {
    print "Calculate the world population for what year? ";
    my $year_input = <STDIN>;
    chomp($year_input);

    # Check
    if (not exists $world_population{$year_input}) {
        print "No data for the year.\n";
    }
    else {
        my $country_count = 0;
        my $total_population = 0;

        #Look at every country code for the year
    foreach my $code (keys %{$world_population{$year_input}}) {
        
        # Add the population to the total
        $total_population += $world_population{$year_input}{$code};

        #Increment the count of countries
        $country_count++;
    }
#Print the calculation
        print "World population in $year_input was " . commify($total_population) . "($country_count countries). \n";
    }
}

#Report 2 Function - Population Growth for a Country

sub report_two {
    print "Calculate population for what country code? ";
    chomp(my $country_code = <STDIN>);
    print "Starting in what year? ";
    chomp(my $start_year = <STDIN>); 
    print "Ending in what year? ";
    chomp(my $end_year = <STDIN>);

    # Is the country code valid?
    if (not exists $country_data{$country_code}) {
        print "Invalid country code.\n";
        return;     # Go back to the menu
    }

    # Do we have data for both years?
    if (not exists $world_population{$start_year}{$country_code} or
        not exists $world_population{$end_year}{$country_code}) {
        print "Data not available for those years for $country_code.\n";
        return;
    }
    else {
        my $pop_start = $world_population{$start_year}{$country_code};
        my $pop_end = $world_population{$end_year}{$country_code};
        my $diff = $pop_end - $pop_start;  #Calculate difference
        my $percent = ($diff / $pop_start) * 100;  #Calculate percentage
        my $name = $country_data{$country_code}{short};    #Short country name
    
     printf("From %d-%d, %s grew by %s (%.1f%%). \n", 
            $start_year, $end_year, $name, commify($diff), $percent);
    }
}

# Report 3 Function - Top Population Growth

sub report_three {
    print "Starting in what year? ";
    chomp(my $start_year = <STDIN>);
    print "Ending in what year? ";
    chomp(my $end_year = <STDIN>);

    if (not exists $world_population{$start_year} or not exists $world_population{$end_year}) {
        print "Data not available for one or both of those years.\n";
        return;
    }
 
    # Declare ranking hash
    my %rankings;

    # Look at every country that exists in the Start Year

    foreach my $code (keys %{$world_population{$start_year}}) {
            #Check to see if the same country is also in the End Year
        if (exists $world_population{$end_year}{$code}) {
            my $diff = $world_population{$end_year}{$code} - $world_population{$start_year}{$code};
            #File the diff in our temporary ranking hash
            $rankings{$code} = $diff;
         }
    }

    # Reverse Sort - Sort b against a to get descending order
    # Array sorted_codes holds the Country Codes

    my @sorted_codes = sort { $rankings{$b} <=> $rankings{$a} } keys %rankings;
      
    print "From $start_year-$end_year, the following countries grew the most:\n";

    for (my $i = 0; $i < 10 && $i < @sorted_codes; $i++) {
        my $code = $sorted_codes[$i];
        my $growth = $rankings{$code};
        my $name = $country_data{$code}{long};

        printf(" %15s   %s\n", commify($growth), $name);
    }
}

#Helper function to add commas to large numbers
sub commify {
	my $text = reverse $_[0];
	#Regex: Look for a digit followed by groups of three digits
	$text =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
	return scalar reverse $text;
}

