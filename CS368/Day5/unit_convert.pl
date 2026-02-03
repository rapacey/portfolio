#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(any);

#Main Program

my $from_unit = get_valid_unit("Convert from units: ");
my $to_unit = get_valid_unit("Convert to units: ");
my $number = get_valid_number("Mass in $from_unit to convert: ");

my $result = convert($number, $from_unit, $to_unit);

printf "%g %s = %.2f %s \n", $number, $from_unit, $result, $to_unit;

#Subroutines

sub get_valid_unit {
	
	#List of valid input

	my @units = qw(oz lb st ton mg g kg t);

	#First argument in @_ is the prompt, assigned to $text in parentheses (list context)

	my ($text) = @_;

	while(1) {
		
	print $text;

	#Get user input and normalize input to lowercase
	
	chomp(my $unit = <STDIN>);
	$unit =~ s/^\s+|\s+$//g;	#Remove leading and trailing whitespace
	$unit = lc($unit);		

	#Use the any function to check input against the list of valid input 
	
	if (any { $_ eq $unit } @units) {
		return $unit;
	} else {
		print "Sorry, I don't know anything about '$unit' units! \n"; 
	}
	}
}

sub get_valid_number {

	my ($text) = @_;

	while(1) {
	
	print $text;
	chomp (my $number = <STDIN>);
	$number =~ s/^\s+|\s+$//g;	

	#Test regex with the binding operator to see if $number is actually a number

	if ( ($number =~ /^[0-9]*\.?[0-9]+$/) && ($number > 0) ) {
		return $number;
	} else {
		print "Error: Please enter a valid number \n";
	}
}
}

sub convert {
	my ($amount, $from, $to) = @_;

	#Conversion rates relative to grams
	
	my %rates = (
		"g" => "1",
		"oz" => "28.3495",
		"lb" => "453.592",
		"st" => "6350.29",
		"ton" => "907185",
		"kg" => "1000",
		"mg" => "0.001",
	);

	#Convert input to grams
	
	my $grams = $amount * $rates{$from};

	#Convert those grams to the target unit
	
	my $result = $grams / $rates{$to};

	return $result;
}



#CS 368 - Intro to Perl
#Homework 5
#University of Wisconsin Madison
#Rob Pacey
#February 3, 2026
