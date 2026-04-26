#!/usr/bin/perl
use strict;
use warnings;

#Write a script to standardize SKUs as 10-character strings

#Create an array to collect as the loop runs
my @skus;

#Input file
my $file = '1-12product_skus.txt';

open (my $fh, '<', $file) or die "Could not open $file $!";

while (my $line = <$fh>) {
	chomp $line;
	next unless $line;	#Skip the line if it's empty

	#Pad each Sku as a 10-character string
	my $padded_value = sprintf ("%010d", $line);

	#Store the value
	push (@skus, $padded_value);
}

#Join the array into one long string
my $sku_list = join("', '", @skus);

my $sql = "('$sku_list')";

print "SELECT * FROM inventory WHERE sku_id IN $sql;";

close $fh;
