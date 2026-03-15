#!usr/bin/perl
use strict;
use warnings;

#Write a script that can convert integers to and from a base 35 representation

#Define character set globally for both subroutines to use

my @characters = (0..9, 'A'..'Y');
my $characterset_string = join('', @characters);

#User Menu

print "Base-35 Converter\n";
print "1. Convert Decimal to Base-35\n";
print "2. Convert Base-35 to Decimal\n";
print "Selection: ";

chomp(my $choice = <STDIN>);

if ($choice == 1) {
	print "Enter a positive integer: ";
	chomp(my $num = <STDIN>);

	my $result = frombase10_tobase35($num);
	print "Base-35 Result: $result\n";
}
elsif ($choice == 2) {
	print "Enter Base35 string: ";
	chomp(my $string = <STDIN>);

	# Use uc() to make sure 'f' becomes 'F' so index() finds it
	my $result = frombase35_tobase10(uc($string));
	print "Decimal Result: $result\n";
}
else {
	print "Invalid choice. Please run again and pick 1 or 2. \n";
}

#From base10 to base35 subroutine

sub frombase10_tobase35 {
	my ($num) = @_;			#Get the number passed to the subroutine
	return "0" if $num == 0;

	my $base35_string = "";
	
	while ($num > 0) {
		# Remainder first to find the "ones" place character
		my $remainder = $num % 35;

		# Map the remainder to get the character from @characters
		my $character = $characters[$remainder];

		# String = Character . String (Prepend)
		$base35_string = $character . $base35_string;
	
		#Integer division to the next power of 35
		$num = int($num / 35);	
	}
	return $base35_string;
}

#From base35 to base10 subroutine

sub frombase35_tobase10 {
	my ($base35_string) = @_;
	my $total = 0;
	
	#Split the input string into individual characters with no delimiter
	my @characters = split('', $base35_string);

	foreach my $character (@characters) {
		#Find the numerical value of the character
		my $value = index($characterset_string, $character);
		
		#Check: Did index() fail to find the character?
		if ($value < 0) {
			die "Error: Character '$character' is outside the Base-35 range.\n";
		}
		#Accumulater: Push existing value left (x35) and add new digit
		$total = ($total * 35) + $value;
	}
	return $total;
}
