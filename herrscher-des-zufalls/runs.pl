#!/usr/bin/env perl

use warnings;
use strict;
$|++;

sub X { rand() }

my @hist;

my $total_iterations = $ARGV[0] || 1;

for my $it (1..$total_iterations) {
  my $x = 0;

  for my $i (1..50) {
    $x++ if rand() > 0.5;

    if($ARGV[1]) {
      printf "%f\t%f\t%d\n", $i, 1 + $x + (rand()-0.5)*0.2, $it;
    }
  }

  $hist[$x]++;

  if($it > 4 and not $ARGV[1]) {
    for my $j (0..$#hist) {
      printf "%d\t%f\t%d\n", $j, ($hist[$j] || 0) / $it, $it;
    }
  }
  print "\n";
}
