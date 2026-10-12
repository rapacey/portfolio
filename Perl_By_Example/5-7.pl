#!/usr/bin/perl

# Perl by Example - Fifth Edition
# Chapter 5 - Exercise 7

use strict;
use warnings;

# ==============================================================================
# OPTION 1: Hash Slice & Index Map (Core Perl / No Modules)
# ==============================================================================
print "--- Option 1: Hash Slice & Index Lookup Map ---\n";
{
    my @new_animals = qw(lion tiger bear lion wolf bear tiger panther wolf bear);

    my %seen;
    @seen{@new_animals} = ();
    my @unique = sort keys %seen;

    my %index_lookup = map { $unique[$_] => $_ } 0 .. $#unique;
    my $target       = 'tiger';

    print "Unique animals: @unique\n";
    print "Index of '$target': $index_lookup{$target}\n\n";
}

# ==============================================================================
# OPTION 2: Modern Core Perl (List::Util & grep Hash Increment)
# ==============================================================================
print "--- Option 2: Core List::Util + grep Hash Idiom ---\n";
{
    use List::Util qw(first);

    my @farm = qw(cow pig sheep goat cow duck sheep pig chicken goat);

    my %seen;
    my @unique = sort grep { !$seen{$_}++ } @farm;
    my $target = 'duck';
    my $index  = first { $unique[$_] eq $target } 0 .. $#unique;

    print "Unique animals: @unique\n";
    print "Index of '$target': $index\n\n";
}

# ==============================================================================
# OPTION 3: Perl Golf Inline Routine
# ==============================================================================
print "--- Option 3: Perl Golf Inline Code ---\n";
{
    my %h;
    my @a = qw(cat dog bird cat bird monkey elephant cat elephant pig horse cat);

    # 68-byte Golf Routine
    my@u=sort grep{!$h{$_}++}@a;my($i)=grep{$u[$_]eq'monkey'}0..$#u;print"Unique: @u\nIndex of 'monkey': $i\n";
}
