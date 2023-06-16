=begin comment
  Christina Jones
  Spring 2023

  Final Project: Video Game Information System

  Description: This is a module that contains subroutines for querying and displaying data about lowest sales. 

  It contains subroutines that create the following queries:
  	- Highest sales by game
  	- Highest sales by platform
  	- Highest sales by pulisher
  	- Highest sales by year
=end comment
=cut


use 5.36.0;
use Text::CSV;
use Term::ANSIColor;

=begin comment
HIGHEST SALES: GAME

note: recently edited to avoid the "one game to rule them all" approach. that is, it can handle the possibility that more than one game may be the highest selling (i.e. sales numbers are equal).
=end comment
=cut

sub hs_game{

	# file name is passed to the subroutine as a parameter
	    my $file = $_[0];

	# create csv following documentation for Text::CSV; binary characters can be used in quoted fields, errors result in a warning, and separation character is a comma
	    my $csv = Text::CSV->new({binary => 1, auto_diag => 1, sep_char => ','});

	# open the file
	    open my $fh, '<', $file or die "Cannot open input file\n";

	# load rows of csv file into an array
	    my @video_games;
	    while(my $row = $csv->getline($fh)) {
	        push @video_games, $row;
	    }

	# close the file
	    close $fh;

	# sort the video games array to find the highest sales figure
	    my @sorted_video_games = sort { $b->[4] <=> $a->[4] } @video_games; # sort @video_games by sales figures in descending order
	    my $hs = $sorted_video_games[0]->[4]; # the highest sales figure is sales figure of the first element of @sorted_video_games

	# find all of the highest selling video games and alphabetize them
	    my @hs_video_games = grep { $_->[4] == $hs} @sorted_video_games; # load all of the highest selling games into @hs_video_games
	    @hs_video_games = sort { $a->[0] cmp $b->[0] } @hs_video_games; # aphabetically sort the titles in @hs_video_games

	# print the results with sales figure colored bright green and all video game titles italicized
	    print "The highest sales per game is: " . colored($hs, "bright_green") . " million copies. The game(s) that sold " . colored($hs, "bright_green") . " million copies: ";
	    foreach my $vg (@hs_video_games) {
	        my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
	        print colored($title, "italic bright_green") . ".\n";
	    }
};

=begin comment
HIGHEST SALES: GENRE
=end comment
=cut

sub hs_genre{
	# file name is passed to the subroutine as a parameter
	  my $file = $_[0];

	# create csv following documentation for Text::CSV; binary characters can be used in quoted fields, errors result in a warning, and separation character is a comma
	  my $csv = Text::CSV->new({binary => 1, auto_diag => 1, sep_char => ','});

	# open the file
	    open my $fh, '<', $file or die "Error: Could not open $file!\n";

	# load rows of csv file into an array
	    my @video_games;
	    while(my $row = $csv->getline($fh)) {
	        push @video_games, $row;
	    }

	# close the file
	    close $fh;

	# calculate the total number of sales for each genre
	    my %genre_sales;
	    foreach my $vg (@video_games){
	        my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
	        $genre_sales{$genre} += $sales;
	    }

	# compare the sales for each genre and record the genre with the highest sales
	    my $highest_sales_genre;
	    my $highest_sales = 0;

	    foreach my $genre (keys %genre_sales){
	        if ($genre_sales{$genre} > $highest_sales){
	            $highest_sales = $genre_sales{$genre};
	            $highest_sales_genre = $genre;
	        }
	    }

	# print the results with the genre name and sales printed in bright green, and the sales printed with two decimal places
	    $highest_sales = sprintf("%.2f", $highest_sales);
	    print "The genre with the highest video game sales is " . colored($highest_sales_genre, "bright_green") . ", which has sold " . colored($highest_sales, "bright_green") . " million games.\n";
};

=begin comment
HIGHEST SALES: PLATFORM
=end comment
=cut

sub hs_platform{
	# file name is passed to the subroutine as a parameter
	  my $file = $_[0];

	# create csv following documentation for Text::CSV; binary characters can be used in quoted fields, errors result in a warning, and separation character is a comma
	  my $csv = Text::CSV->new({binary => 1, auto_diag => 1, sep_char => ','});

	# open the file
	    open my $fh, '<', $file or die "Error: Could not open $file!\n";

	# load rows of csv file into an array
	    my @video_games;
	    while(my $row = $csv->getline($fh)) {
	        push @video_games, $row;
	    }

	# close the file
	    close $fh;

	# calculate the total number of sales for each platform
	    my %platform_sales;
	    foreach my $vg (@video_games){
	        my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
	        $platform_sales{$platform} += $sales;
	    }

	# compare the sales for each platform and record the platform with the highest sales
	    my $highest_sales_platform;
	    my $highest_sales = 0;

	    foreach my $platform (keys %platform_sales){
	        if ($platform_sales{$platform} > $highest_sales){
	            $highest_sales = $platform_sales{$platform};
	            $highest_sales_platform = $platform;
	        }
	    }

	# print the results with the platform name and sales printed in bright green, and the sales printed with two decimal places
	    $highest_sales = sprintf("%.2f", $highest_sales);
	    print "The platform with the highest video game sales is " . colored($highest_sales_platform, "bright_green") . ", which has sold " . colored($highest_sales, "bright_green") . " million games.\n";
};

=begin comment
HIGHEST SALES: PUBLISHER
=end comment
=cut

sub hs_publisher{
	# file name is passed to the subroutine as a parameter
	  my $file = $_[0];

	# create csv following documentation for Text::CSV; binary characters can be used in quoted fields, errors result in a warning, and separation character is a comma
	  my $csv = Text::CSV->new({binary => 1, auto_diag => 1, sep_char => ','});

	# open the file
	    open my $fh, '<', $file or die "Error: Could not open $file!\n";

	# load rows of csv file into an array
	    my @video_games;
	    while(my $row = $csv->getline($fh)) {
	        push @video_games, $row;
	    }

	# close the file
	  close $fh;
	  
	# calculate the total number of sales for each publisher
	    my %publisher_sales;
	    foreach my $vg (@video_games){
	      my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
	        $publisher_sales{$publisher} += $sales;
	    }

	# compare the sales for each publisher and record the platform with the highest sales
	    my $highest_sales_publisher;
	    my $highest_sales = 0; # begin with highest sales at 0 so that first loaded key/value pair become the baseline for sales

	    foreach my $publisher (keys %publisher_sales){
	        if ($publisher_sales{$publisher} > $highest_sales){
	            $highest_sales = $publisher_sales{$publisher};
	            $highest_sales_publisher = $publisher;
	        }
	    }

	# print the results with the publisher name and sales printed in bright green, and the sales printed with two decimal places
	$highest_sales = sprintf("%.2f", $highest_sales);
	print "The publisher with the highest video game sales is " . colored($highest_sales_publisher, "bright_green") . ", which has sold " . colored($highest_sales, "bright_green") . " million games.\n";
};

=begin comment
HIGHEST SALES: YEAR
=end comment
=cut

sub hs_year{
	# file name is passed to the subroutine as a parameter
	  my $file = $_[0];

	# create csv following documentation for Text::CSV; binary characters can be used in quoted fields, errors result in a warning, and separation character is a comma
	  my $csv = Text::CSV->new({binary => 1, auto_diag => 1, sep_char => ','});

	# open the file
	    open my $fh, '<', $file or die "Error: Could not open $file!\n";

	# load rows of csv file into an array
	    my @video_games;
	    while(my $row = $csv->getline($fh)) {
	        push @video_games, $row;
	    }

	# close the file
	  close $fh;

	# calculate the total number of sales for each year
	  my %yearly_sales;
	  foreach my $vg (@video_games){
	    my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
	        $yearly_sales{$year} += $sales;
	  }
	    
	# compare the sales for each year and record the year with the highest sales
	   my $highest_sales_year;
	   my $highest_sales = 0;

	   foreach my $year (keys %yearly_sales){

	   if ($yearly_sales{$year} > $highest_sales){
	    $highest_sales_year = $year;
	    $highest_sales = $yearly_sales{$year};
	   }
	  }

	# print the results with the year name and sales printed in bright green and the sales printed with two decimal places
	$highest_sales = sprintf("%.2f", $highest_sales);
	print "The year with the highest video game sales is " . colored($highest_sales_year, "bright_green") . ". A total of " . colored($highest_sales, "bright_green") . " million video games were sold in " . colored($highest_sales_year, "bright_green") . ".\n";
};

1;