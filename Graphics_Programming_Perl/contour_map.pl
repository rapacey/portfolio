use strict;
use warnings;
use PDL;
use PDL::Graphics::PGPLOT;
use Text::CSV qw(csv);

# 1. Configuration & Parameters
my $csv_file   = 'bathymetric_contours.csv';
my $grid_size  = 100; # Define resolution matrix size (e.g., 100x100 grid)

# 2. Extract Data from CSV
# Assumes columns for coordinates and depth values (e.g., Longitude/Latitude/Depth or WKT Geometry)
my $rows = csv(in => $csv_file, headers => "auto") 
    or die "Failed to read CSV: " . Text::CSV->error_diag;

my (@longitudes, @latitudes, @depths);

foreach my $row (@$rows) {
    # ADJUST THESE KEYS based on your specific CSV header layout
    # GIS CSV exports often use names like 'unnamed: 0', 'X', 'Y', 'Z', or 'geometry'
    push @longitudes, $row->{X} || $row->{Longitude};
    push @latitudes,  $row->{Y} || $row->{Latitude};
    push @depths,     $row->{Z} || $row->{Depth};
}

# Convert arrays into 1D PDL vectors
my $lon_pdl   = pdl(\@longitudes);
my $lat_pdl   = pdl(\@latitudes);
my $depth_pdl = pdl(\@depths);

# 3. Establish Vector Coordinate Boundaries
my $min_lon = $lon_pdl->min; my $max_lon = $lon_pdl->max;
my $min_lat = $lat_pdl->min; my $max_lat = $lat_pdl->max;

# 4. Bin Data / Generate a Structured 2D Matrix Grid
# Create empty grid arrays
my $grid = zeroes($grid_size, $grid_size);
my $counts = zeroes($grid_size, $grid_size);

# Map irregular points onto the structured matrix indices
my $x_idx = (($lon_pdl - $min_lon) / ($max_lon - $min_lon) * ($grid_size - 1))->round->atmost($grid_size - 1);
my $y_idx = (($lat_pdl - $min_lat) / ($max_lat - $min_lat) * ($grid_size - 1))->round->atmost($grid_size - 1);

# Populate matrix cell values
for (my $i = 0; $i < $depth_pdl->nelem; $i++) {
    my $xi = $x_idx->at($i);
    my $yi = $y_idx->at($i);
    
    $grid->slice("($xi),($yi)")   += $depth_pdl->at($i);
    $counts->slice("($xi),($yi)") += 1;
}

# Calculate average depth per cell, masking empty regions
$counts->where($counts == 0) .= 1; # Avoid division by zero
my $bathymetry_grid = $grid / $counts;

# 5. Render via PGPLOT
dev('/xwindow'); # Swap to 'bathymetry.ps/cps' to export as PostScript file

# Set plot viewport window transformation coordinates [MinX, MaxX, MinY, MaxY]
my $transform = pdl([ $min_lon, ($max_lon - $min_lon)/$grid_size, 0,
                      $min_lat, 0, ($max_lat - $min_lat)/$grid_size ]);

env($min_lon, $max_lon, $min_lat, $max_lat, 0, 0);

# Generate the surface terrain plot
cont($bathymetry_grid, {
    TRANS => $transform,
    TITLE => 'Geelong Bathymetric Contour Visualization',
    XLAB  => 'Longitude (WGS84)',
    YLAB  => 'Latitude (WGS84)'
});
