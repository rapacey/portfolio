#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(sum);

#CS 368 - Intro to Perl
#University of Wisconsin, Madison
#Day 3 Homework
#Rob Pacey
#January 26, 2026

#Write a Perl script that maintains a simple movie review aggregator like Metacritic

#Create hash table of reviewers and scores

my %reviews = (
	'Keith Phipps' => '58',
	'Roger Ebert' => '88',
	'Manohla Dargis' => '90',
);

#Set variables to keep track of review scores as they aggregate

#User Input Actions

while (1) {
	
	#Calculate initial stats
	my $total = sum values %reviews;
	my $count = keys %reviews;
	my $average = $count > 0 ? ($total / $count) : 0;	#Avoid divide by zero error
	
	#Display current state
	print "\n---Current Reviews---\n";
	foreach my $critic (sort keys %reviews) {
		my $score = $reviews{$critic};
		printf("%s : %s\n", $critic, $score);
	}
	print "Average: $average\n";

	#Ask for input
	print "(a)dd review, (d)elete review, (q)uit \n";
	chomp(my $choice = <STDIN>);

	last if ($choice eq 'q');

	if ($choice eq "a") {
		print "Reviewer name: \n";
		chomp(my $critic = <STDIN>);
		print "Review score: \n";
		chomp(my $score = <STDIN>);
			#Check to see if a previous review score exists
			if (exists($reviews{$critic})) {
				print "Replacing old review score of $reviews{$critic}\n";
			}		
		
		$reviews{$critic} = $score;		#Assign value score to key critic

	}elsif ($choice eq "d") {
		print "Reviewer name: \n";
		chomp(my $critic = <STDIN>);
		#Check to see if the reviewer exists
		if (exists($reviews{$critic})){
			delete $reviews{$critic};
			print "Deleted $critic\n";
		} else {
			print "Reviewer not found.\n";
		}
	}else {
		print "Error: Please enter a, d, or q.\n";
	}
}

print "Thanks for using the Movie Aggregator!\n";
