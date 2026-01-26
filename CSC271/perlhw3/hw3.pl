#!/usr/bin/perl
#CSC 271 - Adelphi University
#Perl Homework 3
#Rob Pacey
#January 25, 2026

#One main program with a separate function for each menu option

#Option 1 - Phone Number Request

sub phone_number {
	print "Enter a phone number in this format: 123-456-7890\n"; 
	chomp(my $number = <STDIN>);

	#If statement to check if number (regex pattern) is in the correct format
	
	if ($number =~ /^\d{3}-\d{3}-\d{4}$/){
		print "Good job! Valid phone number.\n";
	} else {
		print "Bad job! Invalid number.\n";
		exit (1);
	}
}

#Option 2 - First Name Last Name Reverse

sub name_reverse {
	#Get user's first name
	print "Enter first name: ";
	my $first = <STDIN>;

	#Get user's last name
	print "Enter last name: ";
	my $last = <STDIN>;

	#Create an array
	my @name = ($first, $last);
	chomp(@name);

	#Print in reverse order
	@name = reverse @name;
	print "Reversed: @name\n";
}

#Option 3 - Find Words in a File, Print Rows NOT starting with those words

sub find_words {
	
	my $filename = "mytable.txt";
	print "Please enter two search words (one per line): \n";
	chomp(my $word1 = <STDIN>);
	chomp(my $word2 = <STDIN>);
	
	#Open the file for reading
	open(my $fh, '<', $filename) or die "Can't open $filename: $!";

	#Check for lines that do NOT start with word1 or word2
	print "\n--- Rows not starting with '$word1' or '$word2'\n";
	while(my $line = <$fh>){
		if($line !~ /^$word1/ && $line !~ /^$word2/){
			print $line;
		}
	}
	close($fh);
}

#Main Program Logic

my $choice = "";

while ($choice ne "quit"){
	print "\n--- Main Menu ---\n";
	print "Option 1 - Phone Number Request \n";
	print "Option 2 - First and Last Name? \n";
	print "Option 3 - Search Words in mytable \n";
	print "Type 'quit' to exit\n";
	print "Selection: ";

	chomp($choice = <STDIN>);

	if ($choice eq "1"){
		phone_number();
	}elsif ($choice eq "2"){
		name_reverse();
	}elsif ($choice eq "3"){
		find_words();
	}elsif ($choice ne "quit"){
		print "Invalid entry. Please choose 1, 2, 3, or type 'quit'. \n";
	}
}

print "Goodbye!\n";
