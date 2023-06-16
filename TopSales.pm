=begin comment
  Christina Jones
  Spring 2023

  Final Project: Video Game Information System

  Description: This is a module that contains subroutines for querying and displaying data about top game sales. 

  It contains subroutines that create the following queries:
  	- Top sales by genre
  	- Top sales by platform
  	- Top sales by publisher
  	- Top sales by year 
=end comment
=cut


use 5.36.0;
use Text::CSV;
use Term::ANSIColor;

=begin comment
TOP SALES: GENRE
=end comment
=cut

sub ts_genre{
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
	    close $fh or die "Error: Cannot close file\n";

	# identify the top selling game for each genre
		my %top_game_by_genre;
		foreach my $vg (@video_games){
			my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
			# if the genre does not exist, or the sales in the row are greater than the current highest recorded sales for a game of the genre, record the data from the row as the new top selling game for the genre
			if(!exists($top_game_by_genre{$genre}) or $sales > $top_game_by_genre{$genre}{sales}){
				$top_game_by_genre{$genre} = { title => $title, sales => $sales}; # https://perldoc.perl.org/perldsc#HASHES-OF-HASHES
			}
		}
	# print the results in three columns (genre, title of game, sales) with bolded headings, genres alphabetized, and titles italicized
		printf ("%-35s %-57s %-40s\n", "=====", "================", "===================");
		printf ("%-43s %-65s %-40s\n", colored("Genre", "bold"), colored("Top Selling Game", "bold"), colored("Sales (in millions)", "bold"));
		printf ("%-35s %-57s %-40s\n", "=====", "================", "===================");

		for my $genre (sort keys %top_game_by_genre){
			my $title = $top_game_by_genre{$genre}{title};
			my $sales = $top_game_by_genre{$genre}{sales};
			printf("%-35s %-65s %-5.2f\n", $genre, colored($title, "italic"), $sales)
		}

};

=begin comment
TOP SALES: PLATFORM 
=end comment
=cut

sub ts_platform{

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
	    close $fh or die "Error: Cannot close file\n";

	# identify the top selling game for each platform
		my %top_game_by_platform;
		foreach my $vg (@video_games){
			my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
			# if the platform does not exist, or the sales in the row are greater than the current highest recorded sales for a game of the platform, record the data from the row as the new top selling game for the platform
			if(!exists($top_game_by_platform{$platform}) or $sales > $top_game_by_platform{$platform}{sales}){
				$top_game_by_platform{$platform} = { title => $title, sales => $sales};
			}
		}
	# print the results in three columns (platform, title of game, sales) bolded headings, platforms alphabetized, and titles italicized
		printf ("%-35s %-57s %-40s\n", "========", "================", "===================");
		printf ("%-43s %-65s %-40s\n", colored("Platform", "bold"), colored("Top Selling Game", "bold"), colored("Sales (in millions)", "bold"));
		printf ("%-35s %-57s %-40s\n", "========", "================", "===================");
		for my $platform (sort keys %top_game_by_platform){
			my $title = $top_game_by_platform{$platform}{title};
			my $sales = $top_game_by_platform{$platform}{sales};
			printf("%-35s %-65s %-5.2f\n", $platform, colored($title, "italic"), $sales);
		}

};

=begin comment
TOP SALES: PUBLISHER
=end comment
=cut

sub ts_publisher{
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
	    close $fh or die "Error: Cannot close file\n";

	# identify the top selling game for each publisher
		my %top_game_by_publisher;
		foreach my $vg (@video_games){
			my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
			# if the publisher does not exist, or the sales in the row are greater than the current highest recorded sales for a game of the platform, record the data from the row as the new top selling game for the platform
			if(!exists($top_game_by_publisher{$publisher}) or $sales > $top_game_by_publisher{$publisher}{sales}){
				$top_game_by_publisher{$publisher} = { title => $title, sales => $sales};
			}
		}
	# print the results in three columns (platform, title of game, sales) bolded headings, platforms alphabetized, and titles italicized
		printf ("%-45s %-109s %-60s\n", "=========", "================", "===================");
		printf ("%-53s %-117s %-40s\n", colored("Publisher", "bold"), colored("Top Selling Game", "bold"), colored("Sales (in millions)", "bold"));
		printf ("%-45s %-109s %-60s\n", "=========", "================", "===================");
		for my $publisher (sort keys %top_game_by_publisher){
			my $title = $top_game_by_publisher{$publisher}{title};
			my $sales = $top_game_by_publisher{$publisher}{sales};
			printf("%-45s %-117s %-5.2f\n", $publisher, colored($title, "italic"), $sales);
		}
};

=begin comment
TOP SALES: YEAR 
=end comment
=cut

sub ts_year{
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
	    close $fh or die "Error: Cannot close file\n";

	# identify the top selling game for each year
		my %top_game_by_year;
		foreach my $vg (@video_games){
			my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;
			# if the year does not exist, or the sales in the row are greater than the current highest recorded sales for a game for the year, record the data from the row as the new top selling game for the year
			if(!exists($top_game_by_year{$year}) or $sales > $top_game_by_year{$year}{sales}){
				$top_game_by_year{$year} = { title => $title, sales => $sales};
			}
		}
	# print the results in three columns (platform, title of game, sales) bolded headings, platforms alphabetized, and titles italicized
		printf ("%-35s %-57s %-40s\n", "====", "================", "===================");
		printf ("%-43s %-65s %-40s\n", colored("Year", "bold"), colored("Top Selling Game", "bold"), colored("Sales (in millions)", "bold"));
		printf ("%-35s %-57s %-40s\n", "====", "================", "===================");
		for my $year (sort keys %top_game_by_year){
			my $title = $top_game_by_year{$year}{title};
			my $sales = $top_game_by_year{$year}{sales};
			printf("%-35s %-65s %-5.2f\n", $year, colored($title, "italic"), $sales);
		}
};

1;