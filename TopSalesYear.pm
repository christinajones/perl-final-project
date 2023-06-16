=begin comment
  Christina Jones
  Spring 2023

  Final Project: Video Game Information System

  Description: This is a module that contains subroutines for querying and displaying data about top game sales for a year chosen by the user. 

  It contains subroutines that create the following queries:
  	- Top sales by genre by year
  	- Top sales by platform by year
  	- Top sales by publisher by year
=end comment
=cut


use 5.36.0;
use Text::CSV;
use Term::ANSIColor;
use Scalar::Util qw(looks_like_number);

=begin comment
TOP SALES (YEAR): GENRE 
=end comment
=cut

sub tsy_genre{

	# file name is passed to the subroutine as a parameter
	    my $file = $_[0];

	# ask the user to input a year
	print "Please enter a year to search: ";
	chomp(my $user_year = <STDIN>);

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

	# identify the top selling game for each genre
		my %top_game_by_genre_year;
		foreach my $vg (@video_games){
			my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;


			# check if the year in the row is a number (to account for N/A entries) and if the year is a number check if that number is equal to the year the user entered
			if (looks_like_number($year) && $year == $user_year){
				# if the genre does not exist, or the sales in the row are greater than the current highest recorded sales for a game of the genre for the user's chosen year, record the data from the row as the new top selling game for the genre for the user's chosen year
				if(!exists($top_game_by_genre_year{$genre}) or $sales > $top_game_by_genre_year{$genre}{sales}){
				$top_game_by_genre_year{$genre} = { title => $title, sales => $sales};
				}
			}
		}
	# print the results in three columns (genre, title of game, sales) with bolded headings, genres alphabetized, and titles italicized
		printf ("%-35s %-57s %-40s\n", "=====", "================", "===================");
		printf ("%-43s %-65s %-40s\n", colored("Genre", "bold"), colored("Top Selling Game", "bold"), colored("Sales (in millions)", "bold"));
		printf ("%-35s %-57s %-40s\n", "=====", "================", "===================");
		#printf ("%-43s %-65s")
		for my $genre (sort keys %top_game_by_genre_year){
			my $title = $top_game_by_genre_year{$genre}{title};
			my $sales = $top_game_by_genre_year{$genre}{sales};
			printf("%-35s %-65s %-5.2f\n", $genre, colored($title, "italic"), $sales)
		}
}

=begin comment
TOP SALES (YEAR): PLATFORM 
=end comment
=cut

sub tsy_platform{

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
	    close $fh or die "Cannot close file\n";

	# ask the user to input a year
	print "Please enter a year to search: ";
	chomp(my $user_year = <STDIN>);

	# identify the top selling game for each genre
		my %top_game_by_platform_year;
		foreach my $vg (@video_games){
			my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;

			# check if the year in the row is a number (to account for N/A entries) and if the year is a number check if that number is equal to the year the user entered
			if (looks_like_number($year) && $year == $user_year){
				# if the platform does not exist, or the sales in the row are greater than the current highest recorded sales for a game of the platform for the user's chosen year, record the data from the row as the new top selling game for the platform for the user's chosen year
				if(!exists($top_game_by_platform_year{$platform}) or $sales > $top_game_by_platform_year{$platform}{sales}){
				$top_game_by_platform_year{$platform} = { title => $title, sales => $sales};
				}
			}
		}

	# print the results in three columns (platform, title of game, sales) with bolded headings, platforms alphabetized, and titles italicized
		printf ("%-35s %-57s %-40s\n", "========", "================", "===================");
		printf ("%-43s %-65s %-40s\n", colored("Platform", "bold"), colored("Top Selling Game", "bold"), colored("Sales (in millions)", "bold"));
		printf ("%-35s %-57s %-40s\n", "========", "================", "===================");
		#printf ("%-43s %-65s")
		for my $platform (sort keys %top_game_by_platform_year){
			my $title = $top_game_by_platform_year{$platform}{title};
			my $sales = $top_game_by_platform_year{$platform}{sales};
			printf("%-35s %-65s %-5.2f\n", $platform, colored($title, "italic"), $sales)
		}
}

=begin comment
TOP SALES (YEAR): PUBLISHER
=end comment
=cut

sub tsy_publisher{

	# file name is passed to the subroutine as a parameter
	    my $file = $_[0];

	# ask the user to input a year
	print "Please enter a year to search: ";
	chomp(my $user_year = <STDIN>);

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
	    close $fh or die "Cannot close file\n";

	# identify the top selling game for each genre
		my %top_game_by_publisher_year;
		foreach my $vg (@video_games){
			my ($title, $platform, $genre, $publisher, $sales, $year) = @$vg;

			# check if the year in the row is a number (to account for N/A entries) and if the year is a number check if that number is equal to the year the user entered
			if (looks_like_number($year) && $year == $user_year){
				# if the publisher does not exist, or the sales in the row are greater than the current highest recorded sales for a game of the publisher for the user's chosen year, record the data from the row as the new top selling game for the publisher for the user's chosen year
				if(!exists($top_game_by_publisher_year{$publisher}) or $sales > $top_game_by_publisher_year{$publisher}{sales}){
				$top_game_by_publisher_year{$publisher} = { title => $title, sales => $sales};
				}
			}
		}

	# print the results in three columns (publisher, title of game, sales) with bolded headings, publishers alphabetized, and titles italicized
		printf ("%-50s %-82s %-40s\n", "=========", "================", "===================");
		printf ("%-58s %-90s %-40s\n", colored("Publisher", "bold"), colored("Top Selling Game", "bold"), colored("Sales (in millions)", "bold"));
		printf ("%-50s %-82s %-40s\n", "=========", "================", "===================");
		#printf ("%-43s %-65s")
		for my $publisher (sort keys %top_game_by_publisher_year){
			my $title = $top_game_by_publisher_year{$publisher}{title};
			my $sales = $top_game_by_publisher_year{$publisher}{sales};
			printf("%-50s %-90s %-5.2f\n", $publisher, colored($title, "italic"), $sales)
		}
}

1;