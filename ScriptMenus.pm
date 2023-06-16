=begin comment
  Christina Jones
  Spring 2023

  Final Project: Video Game Information System

  Description: This is a module that contains menu and submenu subroutines. 

  It contains subroutines that create the following menus:
    -Main Menu
      -Sub Menu for Top Sales
      -Sub Menu for Top Sales by Chosen Year
      -Sub Menu for Highest Sales
      -Sub Menu for Lowest Sales
=end comment
=cut

package ScriptMenus;
use 5.36.0;

# set so that .pm files included in the directory can be used as modules for the program. credit: https://stackoverflow.com/a/46550384
use FindBin 1.51 qw( $RealBin );
use lib $RealBin;

use Switch;
use Term::Menus;

# include modules in the directory that contain subroutines for the program
use TopSales;
use TopSalesYear;
use HighestSales;
use LowestSales;

# Menu Options Lists
  my @main_options = ("Highest Sales", "Lowest Sales", "Top Sales", "Top Sales By Chosen Year"); # main menu options
  my @hls_options = ("Game", "Genre", "Platform", "Publisher", "Year"); # highest/lowest sales submenu options
  my @ts_options = ("Genre", "Platform", "Publisher", "Year"); # top sales submenu options
  my @tsy_options = ("Genre", "Platform", "Publisher"); # top sales by given year submenu options

# main menu
sub main_menu{

  my $file = $_[0];
  my $main_banner = "==== Video Game Information System ====\n\nPlease Select Game Information to View:";
  my $main_selection =&pick(\@main_options,$main_banner);

  switch($main_selection){
    case "Top Sales"{
      ts_submenu($file);
    }
    case "Top Sales By Chosen Year"{
      tsy_submenu($file);
    }
    case "Highest Sales"{
      hs_submenu($file);
    }
    case "Lowest Sales"{
      ls_submenu($file);
    }
    else {
      print 'Our Princess is in Another Castle!\n';
    }
  }
};


#top sales submenu
sub ts_submenu{
 
  my $file = $_[0];
  my $ts_banner = 'View Top Sales By...';
  my $ts_selection =&pick(\@ts_options,$ts_banner);

  switch($ts_selection){
    case "Genre"{
      ts_genre($file);
    }
    case "Platform"{
      ts_platform($file);
    }
    case "Publisher"{
      ts_publisher($file);
    }
    case "Year"{
      ts_year($file);
    }
    else {
      print 'Our Princess is in Another Castle!\n';
    }
  }
};


#top sales by given year submenu
sub tsy_submenu{
  
  my $file = $_[0];
  my $tsy_banner = "View a Year\'s Top Sales By...";
  my $tsy_selection =&pick(\@tsy_options, $tsy_banner);

  switch($tsy_selection){
    case "Genre"{
      tsy_genre($file);
    }
    case "Platform"{
      tsy_platform($file);
    }
    case "Publisher"{
      tsy_publisher($file);
    }
    else{
      print 'Our Princess is in Another Castle!\n';
    }
  }
};


# highest sales submenu
sub hs_submenu{

  my $file = $_[0];
  my $hs_banner = "View Highest Sales By...";
  my $hs_selection =&pick(\@hls_options, $hs_banner);

  switch($hs_selection){
    case "Game"{
      hs_game($file);
    }
    case "Genre"{
      hs_genre($file);
    }
    case "Platform"{
      hs_platform($file);
    }
    case "Publisher"{
      hs_publisher($file);
    }
    case "Year"{
      hs_year($file);
    }
    else{
      print 'Our Princess is in Another Castle!\n';
    }
  }
};

# lowest sales submenu
sub ls_submenu{
  
  my $file = $_[0];
  my $ls_banner = "View Lowest Sales By...";
  my $ls_selection =&pick(\@hls_options, $ls_banner);

  switch($ls_selection){
    case "Game"{
      ls_game($file);
    }
    case "Genre"{
      ls_genre($file);
    }
    case "Platform"{
      ls_platform($file);
    }
    case "Publisher"{
      ls_publisher($file);
    }
    case "Year"{
      ls_year($file);
    }
    else{
      print 'Our Princess is in Another Castle!\n';
    }
  }
};

1;