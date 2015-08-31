#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;

GetOptions( 'from=s'	=> \my $alg_from,  
            'to=s'      => \my $alg_to
	  );

die "More information is needed for a proper move.  Provide a from and to coordinate.\n" unless ( $alg_from && $alg_to );

die "The from coordinate must be of the form [a-h][1-8].  For example e1.\n" unless ( $alg_from =~ /^[a-h][1-8]$/i );
die "The to coordinate must be of the form [a-h][1-8].  For example f5.\n" unless ( $alg_to =~ /^[a-h][1-8]$/i );


my @board;

# Store the board in a 2-D array called @board. 
while (<DATA>) 
{
  # Read @board in here
  chomp;
  my @tmp = split;
  push @board, ( [ @tmp ] );
}

print "This is how the board looks to start.\nThe a1 square is always the WQR and the h8 square is always the BKR.\n\n";
print_board( \@board );

alg_move( \@board, $alg_from, $alg_to);

print_board( \@board );


sub alg_move
{
  my ($bref, $from, $to) = @_;
  my ($from_column, $from_row, $to_column, $to_row);
  my @letters = qw(a b c d e f g h);
  my @numbers = qw(0 8 7 6 5 4 3 2 1);
  my $i = 1;
  foreach my $letter ( @letters ) {
    $from_column = $i if $from =~ /$letter/;
    $to_column = $i if $to =~ /$letter/;
    $i++; }
    
  $from_row = $numbers[$1] if $from =~ /(\d)/;
  $to_row = $numbers[$1] if $to =~ /(\d)/;
  
  
  ## print "From column is $from_column and From row is $from_row\n";
  ## print "To column is $to_column and To row is $to_row\n\n";
  
  print "\nYou choose to move ", $bref->[$from_row-1]->[$from_column-1], " from $from to $to\n\n";
  
  my $from_pos = '--';

  $bref->[$to_row-1]->[$to_column-1] = $bref->[$from_row-1]->[$from_column-1];
  $bref->[$from_row-1]->[$from_column-1] = $from_pos;
    
}

sub print_board
{
  # This routine prints the board which is passed to it. 

  my $bref = shift;
  my $r = 8;
  print "-" x 42, "\n";
  for my $row ( @$bref )
  {
    for my $column ( @$row )
    {
      print "| $column ";
    }
    print "| $r\n";
    $r--;
  }
  print "-" x 42, "\n";
  print "  a    b    c    d    e    f    g    h\n";
}

__END__
Br Bn Bb BQ BK Bb Bn Br
Bp Bp Bp Bp Bp Bp Bp Bp
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
Wp Wp Wp Wp Wp Wp Wp Wp
Wr Wn Wb WQ WK Wb Wn Wr