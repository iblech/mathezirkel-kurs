#!/usr/bin/env perl

use warnings;
use strict;
$|++;

sub X { rand() }

my @hist;

my $total_iterations = $ARGV[0] || 1;

for my $it (1..$total_iterations) {
  my $x = -1;

  my $num_records = 0;
  for my $i (1..1000) {
    my $new_x = X();
    if($new_x > $x) {
      $x = $new_x;
      $num_records++;
    }

    if($ARGV[1]) {
      printf "%f\t%f\t%d\n", $i, $num_records + (rand()-0.5)*0.3, $it
        if $ARGV[1] == 1 or $i % $ARGV[1] == 1;
    }
  }

  $hist[$num_records]++;

  if($it > 4 and not $ARGV[1]) {
    for my $j (0..$#hist) {
      printf "%d\t%f\t%d\n", $j, ($hist[$j] || 0) / $it, $it;
    }
  }
  print "\n";
}
