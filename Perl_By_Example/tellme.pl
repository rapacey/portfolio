#!/usr/bin/perl

# Perl by Example - Fifth Edition
# Chapter 5 - Exercise 6: Hash Mapping & Record Output

use strict;
use warnings;

# Check that a filename argument was provided
unless (@ARGV) {
    die "Usage: $0 <filename>\n";
}

my %datebook_hash;

# Read lines sequentially from file(s) in @ARGV
while (my $line = <>) {
    chomp($line);
    next if $line =~ /^\s*$/; # Skip blank lines

    # Delimited fields: Name : Phone : Address : DOB : Salary
    my ($name, $phone, $address, $dob, $salary) = split(/:/, $line);

    # Store a reference to an anonymous hash for clean field access
    $datebook_hash{$name} = {
        phone  => $phone,
        salary => $salary,
    };
}

# Output each person's details on separate lines
foreach my $name (sort keys %datebook_hash) {
    print "Salary: $datebook_hash{$name}{salary}\n";
    print "Name: $name\n";
    print "Phone: $datebook_hash{$name}{phone}\n\n";
}