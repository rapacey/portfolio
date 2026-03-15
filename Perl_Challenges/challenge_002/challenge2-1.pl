#!/usr/bin/perl
use strict;
use warnings;

#Write a script or one-liner to remove leading zeros from positive numbers

my @test_cases = ("000123", "0", "000", "10203", "7000", "0.05");

print "Input     | Result\n";
print "----------|----------\n";

foreach my $case (@test_cases) {
    chomp($case);
    my $original = $case;
    $case =~ s/^0+//; 
    printf "%-10s| '%s'\n", $original, $case;
}
