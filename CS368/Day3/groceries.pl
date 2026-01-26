#!/usr/bin/perl
use strict;
use warnings;

#CS 368 - Intro to Perl
#Homework Day 3
#Rob Pacey
#January 25, 2026

#Write a Perl script that maintains a simple grocery list with prices

#Initial List

print "Grocery List\n";
print "Total Cost = \$0\n";

#Declare Variables

my %groceries;
my $total = 0;
my $average = 0;
my $item = "start";
my $price = 0;

while ($item ne "") {
	print "Item? ";
	chomp($item = <STDIN>);

	if ($item ne "") {
		print "Price? ";
		chomp($price = <STDIN>);
	
	#Find items in groceries hash and assign price
	$groceries{$item} = $price;
	
	#Update total and average item cost
	$total = $total + $price;
	$average = $total / (keys %groceries);

	#Print the current state of the grocery list
	print "\n";
	print "Grocery List \n";
	foreach my $name (sort keys %groceries) {
		printf("%s (\$%.2f)\n", $name, $groceries{$name});
	}

	printf("Total Cost: \$%.2f\n\n", $total);
	printf("Average Item Cost: \$%.2f\n\n", $average);
	}	
}
