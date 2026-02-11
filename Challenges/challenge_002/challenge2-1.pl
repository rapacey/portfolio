#!/usr/bin/perl

use strict;
use warnings;

#Write a script or one-liner to remove leading zeros from positive numbers

my $input = 000234560;
$input =~ 's/^0+//'; 
print "Result: $input\n";

