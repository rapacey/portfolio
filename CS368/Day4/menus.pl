#!/usr/bin/perl

use strict;
use warnings;
use IO::Prompter;
use feature 'say';

#A script to review different ways of prompting for user input

#Read standard input from the keyboard

print "Your name please: ";
my $name = <STDIN>;			
chomp $name;

print "Your name is '$name' \n\n";

#Prompt - Print the string, read from stdin, chomp it, and test against constraints

my $user = prompt ("Username: ");	
my $passwd = prompt ("Password: ", -secret);	#Mask so people don't see what we type

print "Password accepted and stored in memory.\n\n";

#Selector - Ask the user to select from a list of items

my $selection = prompt 'What is your favorite flavor of ice cream? ', -menu => [qw(vanilla chocolate strawberry other)], '>';
say $selection;
print "\n";

#-req argument - test for a specific type of input

my $hex_num = prompt( "Enter a hex number> ",
		-must => { "A *hex* number please!> " => qr/^[0-9A-F]+$/i }
		);

print "That's ", hex($hex_num), " in base 10 \n\n";

#Prompt with a default value

my $city = prompt("Where are you from?", -default => "Champaign, IL");

print "You are from $city \n\n";

#Yes or No (Single Key)

my $changes = uc prompt( "Do you want to save your changes?: ",
		-single,
		-must => { "Please select Y or N: " => qr/[YN]/i } );

if ($changes eq "Y") {
	print "Saving changes...\n\n";
} else {
	print "Exiting without saving...\n\n";
}

#Button Press - Press a single key

my $drive = uc prompt ("Select a drive: ",
		-single,
		-must => { "Please select A-F: " => qr/[A-F]/i } );

print "You selected drive: $drive \n\n";

#Menu Options

my $entree = prompt 'What would you like to have for dinner?',
		-menu =>
		[
			'Three Cheese Lasagna',
			'Chicken Tikka Masala',
			'Vegetarian Chili',
			'Cottage Pie',
			'Spicy Beef Stir Fry',
			'Pork Roast with Potatoes',
		];

print "Your order of $entree is coming right up...\n\n";

#Menu Options with Hash References

my %inventions = (
		Edison => 'Light Bulb',
		Ford => 'Model T',
		Whitney => 'Cotton Gin',
		Tesla => 'Alternating Current',
		Morse => 'Telegraph',
);

my $invention = prompt ('Which inventor will you choose?: ', -menu => \%inventions);

if ($invention) {
	print "Your inventor is famous for: $invention \n\n";
}

#Nest Hashes and Arrays within a Menu to create hierarchical menus

my $distro = prompt 'Select your distribution:',
		-menu =>
		{
			Debian => [ 'Ubuntu', 'Linux Mint', 'Kali Linux' ],
			RedHat => [ 'RHEL', 'Fedora', 'Rocky Linux', 'AlmaLinux' ],
			SUSE => [ 'SLES', 'openSUSE' ],
		};

print "Compiling for $distro...\n";
