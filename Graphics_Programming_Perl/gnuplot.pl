#!/usr/bin/perl

use strict;
use warnings;
use Term::Gnuplot ':ALL';

#Set up and initialize the terminal
plot_outfile_set('TermGnuplot.eps');
change_term('postscript');
set_options('eps', 'enhanced', '"Helvetica"', 24);
term_init();
term_start_plot();

#Plot some functions
draw_axes(-6, 6, -1, 1, 0.1);
plot_function(sub {sin $_[0]/3});
plot_function(sub {cos $_[0] * tan $_[0]});
plot_function(sub {-0.4 * $_[0]}, 4);

term_end_plot();
Term::Gnuplot::reset;