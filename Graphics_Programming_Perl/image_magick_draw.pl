#!/usr/bin/perl

use strict;
use warnings;
use Image::Magick;

#Create an empty image object with a white background
my $image = Image::Magick->new(size => '400x300');

#Create a white image, and set the default color
$image->Read('xc:white');
$image->Set(stroke => 'red'); 

$image->Draw(primitive  => 'square', 
             points     =>  '0, 129, 199, 0',
             fill       =>  'blue', 
             stroke     =>  'blue');

$image->Draw(primitive  =>  'polygon', 
             points     =>  '159,119 259,24 224,139 299,124',
             fill       =>  'yellow', 
             stroke     =>  'black');

$image->Set(antialias =>, 0, fuzz => 15);

#Draw a circle and cut out an ellipse
$image->Draw(primitive => 'circle',
             strokewidth => 3,
             points => '189,129 54,119');

$image->Draw(primitive => 'ellipse',
             strokewidth => 3,
             points => '169,159 50,100 0,360');

#Flood-fill the gap
$image->Draw(primitive      => 'color',
             method         => 'filltoborder',
             points         => '99, 149',
             bordercolor    =>  'red',
             fill           => 'green1');

#Frame with a red border
$image->Draw(primitive  => 'rectangle',
             points     => '0,0 399,299');
$image->Draw(primitive  => 'line',
             points     => '199,0 199,299');