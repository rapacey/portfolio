#!/usr/bin/perl

use strict;
use warnings;

use GD::Graph::bars;
use GD::Graph::linespoints;
use PGPLOT;

my @data = (
    ['frogs', 'fish', 'toads', 'rodents'],
    [ 8,       3,       1,      2],
);

my $chart = GD::Graph::bars->new(700,500);
$chart->set(title => 'Hawk diet');
$chart->set_title_font('arialbd', 24);
$chart->set_x_axis_font('arial', 16);
$chart->set_y_axis_font('arial', 16);
my $gd_object = $chart->plot(\@data);

my @set = (
    [qw(Jan Feb Mar Apr May Jun Jul Aug Sep)], 
    [undef, 52, 53, 54, 55, 56, undef, 58, 59],
    [60, 61, 61, undef, 68, 66, 65, 63, undef], 
);

my $line_graph = new GD::Graph::linespoints(700,500);

$chart->set(
    x_label         => 'Month',
    y_label         => '# sold',
    title           => 'First three quarters, 2000',
    y_long_ticks    => 1, 
    markers         => [1, 5],
    marker_size     => 8,
    line_types      => [4, 1],
    line_width      => 3,
);
$chart->set_legend('outlet 1', 'outlet 2');