=begin comment
  Christina Jones
  Spring 2023

  Final Project: Video Game Information System

  Description: This is a module that contains subroutines for querying and displaying data about lowest sales. 

  It contains subroutines that create the following queries:
  	- Lowest sales by game
  	- Lowest sales by platform
  	- Lowest sales by pulisher
  	- Lowest sales by year
=end comment
=cut

use 5.36.0;
use Text::CSV;
use Term::ANSIColor;

=begin comment
LOWEST SALES: GAME

note: recently edited to avoid the "one game to rule them all" approach. that is, it can handle the possibility that more than one game may be the lowest selling (i.e. sales numbers are equal).
=end comment
=cut

sub ls_game{
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

	# sort the video games array to find the lowest sales figure
	    my @sorted_video_games = sort { $a->[4] <=> $b->[4] } @video_games; # sort @video_games by sales figures in ascending order
	    my $ls = $sorted_video_games[0]->[4]; # the lowest sales figure is sales figure of the first element of @sorted_video_games

	# find all of the lowest selling video games and alphabetize them
	    my @ls_video_games = grep { $_->[4] == $ls} @sorted_video_games; # load all of the lowest selling games into @ls_video_games
	    my $ls_total = @ls_video_games; # count the number of lowest selling games
	    @ls_video_games = sort { $a->[0] cmp $b->[0] } @ls_video_games; # aphabetically sort the titles in @ls_video_games

	# print the results with sales figure colored bright green and all video game titles italicized
	    print "The lowest sales per game is: " . colored($ls, "bright_green") . " million copies. The game(s) that sold " . colored($ls, "bright_green") . " million copies:\n";
	    foreach my $vg (@ls_video_games) {
	        my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
	        print colored($title, "italic") . "\n";
	    }
};

=begin comment
LOWEST SALES: GENRE
=end comment
=cut

sub ls_genre{

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

	# compare the sales for each platform and record the platform with the lowest sales
	    my $lowest_sales_genre;
	    my $lowest_sales = undef; # begin with lowest sales undefined so that first loaded key/value pair become the baseline for sales

	    foreach my $genre (keys %genre_sales){
	        if (!defined $lowest_sales or $genre_sales{$genre} < $lowest_sales){
	            $lowest_sales = $genre_sales{$genre};
	            $lowest_sales_genre = $genre;
	        }
	    }

	# print the results with the platform name and sales printed in bright green, and the sales printed with two decimal places
	    $lowest_sales = sprintf("%.2f", $lowest_sales);
	    print "The genre with the lowest video game sales is " . colored($lowest_sales_genre, "bright_green") . ", which has sold " . colored($lowest_sales, "bright_green") . " million games.\n";

};

=begin comment
LOWEST SALES: PLATFORM
=end comment
=cut

sub ls_platform{

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

	# compare the sales for each platform and record the platform with the lowest sales
	    my $lowest_sales_platform;
	    my $lowest_sales = undef; # begin with lowest sales undefined so that first loaded key/value pair become the baseline for sales

	    foreach my $platform (keys %platform_sales){
	        if (!defined $lowest_sales or $platform_sales{$platform} < $lowest_sales){
	            $lowest_sales = $platform_sales{$platform};
	            $lowest_sales_platform = $platform;
	        }
	    }

	# print the results with the platform name and sales printed in bright green, and the sales printed with two decimal places
	    $lowest_sales = sprintf("%.2f", $lowest_sales);
	    print "The platform with the lowest video game sales is " . colored($lowest_sales_platform, "bright_green") . ", which has sold " . colored($lowest_sales, "bright_green") . " million games.\n";

};

=begin comment
LOWEST SALES: PUBLISHER
=end comment
=cut

sub ls_publisher{
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

	# compare the sales for each platform and record the platform with the highest sales
	    my $lowest_sales_publisher;
	    my $lowest_sales = undef; # begin with lowest sales undefined so that first loaded key/value pair become the baseline for sales

	    foreach my $publisher (keys %publisher_sales){
	        if (!defined $lowest_sales or $publisher_sales{$publisher} < $lowest_sales){
	            $lowest_sales = $publisher_sales{$publisher};
	            $lowest_sales_publisher = $publisher;
	        }
	    }

	# print the results with the publisher name and sales printed in bright green, and the sales printed with two decimal places
	    $lowest_sales = sprintf("%.2f", $lowest_sales);
	    print "The publisher with the lowest video game sales is " . colored($lowest_sales_publisher, "bright_green") . ", which has sold " . colored($lowest_sales, "bright_green") . " million games.\n";
};

=begin comment
LOWEST SALES: YEAR
=end comment
=cut

sub ls_year{
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
	  for my $vg (@video_games){
	    my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
	        $yearly_sales{$year} += $sales;
	  }
	    
	# compare the sales for each year and record the year with the lowest sales
	   my $lowest_sales_year;
	   my $lowest_sales = undef;

	   foreach my $year (keys %yearly_sales){

	   if (!defined $lowest_sales or $yearly_sales{$year} < $lowest_sales){
	            $lowest_sales = $yearly_sales{$year};
	            $lowest_sales_year = $year;
	        }
	  }

	# print the results with the year name and sales printed in bright green and the sales printed with two decimal places
	    $lowest_sales = sprintf("%.2f", $lowest_sales);
	    print "The year with the lowest video game sales is " . colored($lowest_sales_year, "bright_green") . ". A total of " . colored($lowest_sales, "bright_green") . " million video games were sold in " . colored($lowest_sales_year, "bright_green") . ".\n";
};

1;