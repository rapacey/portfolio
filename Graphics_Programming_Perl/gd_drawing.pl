#!/usr/bin/perl

use strict;
use warnings;
use GD;

my $image = GD::Image->new(400, 300);

my $white = $image->colorAllocate(255, 255, 255);
my $black = $image->colorAllocate(0, 0, 0);
my $red = $image->colorAllocate(255, 0, 0);
my $green = $image->colorAllocate(0, 255, 0);
my $blue = $image->colorAllocate(0, 0, 255);
my $yellow = $image->colorAllocate(255, 255, 0);

# Draw a rectangle
$image->rectangle(0, 129, 199, 169, $blue);

#Create a polygon and fill it with red color, then draw the outline in green
my $poly = GD::Polygon->new();
$poly->addPt(199, 149);
$poly->addPt(399, 74);
$poly->addPt(324, 149);
$poly->addPt(399, 224);
$image->filledPolygon($poly, $yellow);
$image->polygon($poly, $black);

#Create a circle, cut out an ellipse, and fill
$image->arc(199, 149, 250, 250, 0, 360, $red);
$image->arc(199, 149, 100, 200, 0, 360, $red);
$image->fillToBorder(99, 149, $red, $green);

#Frame with a red border, and draw a red cross
$image->rectangle(0, 0, 399, 299, $red);
$image->line(199, 0, 199, 299, $red);
$image->line(0, 149, 399, 149, $red);

my $gd = GD::Image->newFromPng('example.png'); 

my $black = $image_two->colorResolve(0, 0, 0); 
my $green = $image_two->colorResolve(0, 196, 0); 

my $border = $image_two->colorAllocate(0, 0, 0); 

$gd->arc(199, 149, 300, 100, 0, 270, $border);
$gd->line(199, 149, 199, 99, $border); 
$gd->line(199, 149, 349, 149, $border);
$gd->fillToBorder(149, 149, $border, $green);

$gd->arc(199, 149, 300, 100, 0, 270, $black);
$gd->line(199, 149, 199, 99, $black);
$gd->line(199, 149, 349, 149, $black);

$gd->colorDeallocate($border);