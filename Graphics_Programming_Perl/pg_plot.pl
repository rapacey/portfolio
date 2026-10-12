#!/usr/bin/env perl

use strict;
use warnings;
use PGPLOT; 

# 1. Define X and Y data arrays
my @x = (1, 2, 3, 4, 5);
my @y = (1, 4, 9, 16, 25);
my $num_points = scalar(@x);

# 2. Open the plot device
# "/PNG" creates a png file named 'pgplot.png'. 
# Use "/XWINDOW" or "/XSERVE" for an interactive window.
pgbeg(0, "pgplot.png/PNG", 1, 1) == 1 or die "Cannot open PGPLOT device\n";

# 3. Define the viewport boundaries and scale the axes
# Arguments: (xmin, xmax, ymin, ymax, justify, axis_style)
# axis_style 0 = draw box and label coordinates
pgenv(0, 6, 0, 30, 0, 0);

# 4. Add labels and titles
# Arguments: (x_label, y_label, top_title)
pglabel("X Axis Units", "Y Axis Units", "Sample X-Y Plot");

# 5. Set line configurations (optional)
pgsci(5); # Set color index (5 = Cyan)
pgslw(3); # Set line width to 3

# 6. Draw lines between points
# Pass array references using \@x and \@y
pgline($num_points, \@x, \@y);

# 7. Alternatively, draw data points instead of lines (scatter plot)
pgsci(4); # Change color index (4 = Blue)
# Draw points with symbol 17 (filled circle)
pgpoint($num_points, \@x, \@y, 17);

# 8. Close the plot device
pgend();

print "Plot generated successfully as 'pgplot.png'.\n";
