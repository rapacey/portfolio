#!/usr/bin/perl

use strict;
use warnings;

#Perl by Example - 5th Edition, Chapter 5 Exercise 3

#Write a script called elective.pl that will contain a hash.
#The keys will be code numbers and the values will be course names.

my %courses = (
    "2CPR2B" => "C Language",
    "1UNX1B" => "Intro to Unix",
    "3SH414" => "Shell Scripting",
    "4PL400" => "Perl Programming",
);

#1. Print headers and current date/time

print "\nRegistration Information for Spring Semester:\n";
print "-------------------------------------------\n";

my $current_time = localtime();
print "Current Date and Time: $current_time\n\n";
print "Please enter the following information:\n";

#2. Collect and validated user information

my $full_name = '';
while (1) {
    print "Full Name: ";
    chomp($full_name = <STDIN>);
    if ($full_name =~ /^[a-zA-Z\s]+$/) {
        last;
    } else {
        print "Invalid input. Please enter a valid name (letters and spaces only).\n";
    }
};

#3. Collect and validate student ID

my $student_id = '';
while (1) {
    print "Student ID (9 digits): ";
    chomp($student_id = <STDIN>);
    if ($student_id =~ /^\d{9}$/) {
        last;
    } else {
        print "Invalid input. Please enter a valid 9-digit student ID.\n";
    }
};

#4. Collect and validate student address

my $city = '';
while (1) {
    print "City: ";
    chomp($city = <STDIN>);
    if ($city =~ /^[a-zA-Z\s]+$/) {
        last;
    } else {
        print "Invalid input. Please enter a valid city name (letters and spaces only).\n";
    };

my $state = '';
while (1) {
    print "State (2-letter abbreviation): ";
    chomp($state = <STDIN>);
    if ($state =~ /^[A-Z]{2}$/) {
        last;
    } else {
        print "Invalid input. Please enter a valid 2-letter state abbreviation (uppercase letters only).\n";
    }
};

my $zip_code = '';
while (1) {
    print "ZIP Code (5 or 9 digits): ";
    chomp($zip_code = <STDIN>);
    if ($zip_code =~ /^\d{5}(-\d{4})?$/) {
        last;
    } else {
        print "Invalid input. use '12345' or '12345-6789' format.\n";
    }
};

#5. Display the course electives menu

print "\nCourse Electives Menu:\n";
foreach my $code (sort keys %courses) {
    printf "%-10s : %s\n", $code, $courses{$code};
};

#6. Prompt the user to type the code number of the course they want to take

my $user_input = '';
while (1) {
    print "\nEnter the code number of the course you want to take: ";
    chomp($user_input = <STDIN>);
    my $upper_input = uc($user_input); # Convert input to uppercase for case-insensitive comparison
    
    if (exists $courses{$user_input}) {
        last;
    } else {
        print "Invalid course code. Please try again.\n";
    }
};

#7. Display the registration confirmation 

print "\nRegistration Confirmation:\n";
print "--------------------------\n";   

print "\nThe course you have selected is: $courses{$user_input}\n";

print "Registration confirmation has been sent to the following address:\n";
print "$full_name\n"; 
print "$city, $state $zip_code\n";

my $confirmation_time = localtime();
print "Confirmation Date and Time: $confirmation_time\n";

my $confirmation_number = int(rand(1000000)); # Generate a random confirmation number
print "Your registration confirmation number is: $confirmation_number\n";

my($first_name, $last_name) = split(/\s+/, $full_name);
print "Thank you, $first_name, for registering for the course!";