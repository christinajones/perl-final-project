=begin comment
  Christina Jones
  Spring 2023

  Final Project: Video Game Information System

  Description: This is a menu based program that outputs information about video games.
  The data displayed by the program is sourced from a csv file. The information is
  displayed based upon a user's selected criteria.

  The criteria options presented to the user are:
    - Top Sales (by: genre, platform, publisher, and year)
    - Top Sales for a Year (by: genre, platform, and publisher)
    - Highest Sales (by: game, platform, publisher, and year)
    - Lowest Sales (by: game, platform, publisher, and year)

  Any time an option fails within the menu or submenus the user is presented with
  the text "Our Princess is in Another Castle" in a nod to Super Mario Brothers.

  Required data file: vgasales.csv

  Required Modules:
    - Switch
    - Term::Menus
    - Term::ANSIColor
    - Text::CSV
    - ProgramMenus, and all of its dependencies (written by me)
=end comment
=cut

# set perl version
	use 5.36.0;

# set so that .pm files included in the directory can be used as modules for the program. credit: https://stackoverflow.com/a/46550384
	use FindBin 1.51 qw( $RealBin );
	use lib $RealBin;

# include modules in the directory that contain subroutines for the program
	use CSVCleanUp;
	use ScriptMenus;

# set name of video game data file
	my $data_file = "vgasales.csv";

# clean the data file to remove double commas and duplicates
	my $cleaned_data_file = CSVCleanUp::csv_clean_up($data_file);

# launch the main menu and pass the clean data file into the menu for use with options
	ScriptMenus::main_menu($cleaned_data_file);
