#!/usr/bin/perl
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

#Prompt the user to enter a desired number of rows

print "----Pascal's Triangle ----\n";
print "How many rows?: ";

chomp(my $num_rows = <STDIN>);

#Check to make sure the number of rows is an integer

if (looks_like_number($num_rows) && $num_rows == int($num_rows)) {
	pascal($num_rows); 
} else {
	print "$num_rows is not an integer.\n"; 
}

sub pascal {
	# Capture the user input
	my ($num_rows) = @_;

	# First row in Pascal's Triangle
	my @row = (1);

	foreach my $iteration (1..$num_rows) {
		
		# Print the current row
		print join(" ", @row) . "\n";
	
		# Build the next row in a temporary array
		my @next_row = (1);

		# Use the index of the current row to find pairs
		for (my $j = 0; $j < $#row; $j++) {
			my $sum = $row[$j] + $row[$j+1];
			push @next_row, $sum;
		}

		# End the new row with a 1
		push @next_row, 1 if $iteration < $num_rows;

		# Overwrite @row so the next loop has the new data
		@row = @next_row;
	}
}
		
