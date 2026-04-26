#!/usr/bin/perl
use strict;
use warnings;

#Create a script that will properly capitalize shipping labels

#Hash for a list of words that should stay lowercase

my %nocap = map { $_ => 1 } qw(
	and the a an but or for in of on to
	with from by up off out
);

my $file = '1-14shipping_labels.txt';

open (my $fh, '<', $file) or die "Could not open $file $!";

while (my $line = <$fh>) {
	chomp $line;

	#Use split to turn the line into an array of words
	my @words = split(' ', $line);

	#Use a foreach loop for each word
	foreach my $word (@words) {
		
		#Lowercase the word before checking the hash
		if ($nocap{lc($word)}) {
			$word = lc($word);		#Save the lowercase result
		} else {
			$word = ucfirst(lc($word));	#Save the capitalized result
		}
	}

	#After the foreach loop, Capitalize the first and last word no matter what
	if (@words) {
		$words[0] = 	ucfirst(lc($words[0]));		
		$words[-1] = 	ucfirst(lc($words[-1]));
	}

	#Put it back together and print the finished label
	print join(" ", @words) . "\n";
}

close $fh;

