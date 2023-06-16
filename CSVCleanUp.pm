=begin comment
  Christina Jones
  Spring 2023

  Final Project: Video Game Information System

  Description: This is module contains a "cleaning" subroutine for use with the csv file. 

  It does the following:
	- Takes in a file name as input and constructs from it an output file name
	- Loads all data from the file
	- Replaces double commas with single commas in each row
	- Removes duplicated rows
	- Writes the cleaned data to a new file
	- Returns the name of the file to which the cleaned data was written
=end comment
=cut



package CSVCleanUp;

use 5.36.0;
use Exporter;

our @ISA = qw( Exporter );
our @EXPORT_OK = qw(csv_clean_up); # everything that can be exported
our @EXPORT = qw(csv_clean_up); # export by default


# csv clean up subroutine
sub csv_clean_up{
	# create input file and output file names
	my $input_file = $_[0];
	my ($input_name, $input_extension) = split'\.',$input_file; # split the input file name on the period to extract filename and file extension
	my $output_file = "$input_name" . "_clean" . ".$input_extension"; # create the output file name as the input file's filename, a marker that it has been cleaned, and the input file's extension

	# load data from the file
	open my $input, '<', $input_file or die "Cannot open input file: $!\n";
	chomp(my @lines = <$input>);
	close $input;

	# clean up the data by replacing double commas with a single comma in each line and remove duplicate lines
	my %unique_lines;
	foreach my $line(@lines){
		$line=~ s/,,/,/g;
		$unique_lines{$line} = 1; # thanks to: https://www.theunixschool.com/2013/05/perl-remove-duplicate-elements-from.html
	}

	# write the cleaned up data to a new file and remove the blank line from the end of the file
	open my $output, '>', $output_file or die "Cannot open output file: $!\n";

	foreach my $unique_line(keys %unique_lines){
		print $output $unique_line;
	}
	close $output or die "Cannot close output file: $!\n";

	# return the name of the output file so it can be passed after it is cleaned
	return $output_file;
}

1;