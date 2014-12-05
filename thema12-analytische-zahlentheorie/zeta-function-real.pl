#!/usr/bin/perl

use warnings;
use strict;

for(my $s = 1; $s < 6; $s += 0.04) {
  my $zeta = 0;
  $zeta += 1/$_**$s for 1..100000;
  print "$s\t$zeta\n";
}
