#!/usr/bin/perl
use strict;
use warnings;
use Text::Tabs;

$tabstop = 8;

my $filename = '1-7banner_finaid.txt';

open(my $fh, '<', $filename) or die "Could not open '$filename' $!";

#Process the header BEFORE the loop to find column positions

my $header = <$fh>;
$header = expand($header);

my $name_start = 8;
my $award_start = index($header, 'Award_Amount');   #Use exact header text
my $name_width = $award_start - $name_start;

print qq{"ID","Name","Amount"\n};    #CSV Header

#Loop through data lines

while (my $line = <$fh>) {
    $line = expand($line);
    chomp $line;

    #Find the dollar sign on each lien to avoid index drift
    my $award_start = index($line, '$');

    #Pass the anchors (Start and End)
    my ($id, $name, $amount) = cleantabs($line, $name_start, $award_start);

    print qq{'$id','$name','$amount'\n};
}

sub cleantabs {

    #Capture the line, the start position and the dynamic award position
    my($line, $start, $award_position) = @_;

    my $id = substr($line, 0, 5);

    my $width = $award_position - $start;

    #Extract name using the dynamic width for each student
    my $name = substr($line, $start, $width);
    
    #Remove trailing padding
    $name =~ s/\s+$//;          

    #Clean the name using hyphen-aware logic for capitalization
    $name =~ s/(\w+)/\u\L$1/g;

    #Extract amount from the award position to the end of the line 
    my $amount = substr($line, $award_position);

    #Clean up the currency symbols and any spaces
    $amount =~ tr/\$ //d;   

    return ($id, $name, $amount);
}
