#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

#A Solution

$_ = 'Perl Weekly Challenge';
my $count1 = tr/e/E/;
say "A: $_";
say "$count1 changes";

#B Solution

my $string = $ARGV[0] // 'Perl Weekly Challenge'; 	#Defined OR evaluates value on left, if undefined, use value on right
my $count2 = $string =~ tr/e/E/;			#When assigned to scalar variable, tr returns number of replacements performed
say "B: $string (with $count2 replacements).";		#Print new string and a count

#C Solution

my $input = 'Perl Weekly Challenge';
my $count3 = ($input =~ s/e/E/g);
say "C: $input (Count: $count3)";

#D Solution

$_ = shift // 'Perl Weekly Challenge';
my $c = y/e/E/;
say "D: $_ ($c changes)";

