#!/usr/bin/env perl

use warnings;
use strict;

my ($pos,$neg,$zero) = (0,0,0);
my %occ;

my $summary_only = $ARGV[2];

for my $a (1..($ARGV[0] || 1)) {
  my $x = 0;
  my $p = "";

  my $jitter = (rand() - 0.5) * 0.85;

  for my $i (1..($ARGV[1] || 100)) {
    my $c = rand() > 0.5 ? "0" : "1";

    if("$p$c" eq "11") {
      $x++;
    } elsif("$p$c" eq "10") {
      $x--;
    }

    $p = $c;

    printf "%f\t%f\t%d\n", $i, $x + $jitter, $a
      unless $summary_only;
  }

  $pos++  if $x > 0;
  $neg++  if $x < 0;
  $zero++ if $x == 0;
  $occ{$x}++;

  print "\n"
    unless $summary_only;
}

for my $x (sort { $a <=> $b } keys %occ) {
  printf "%d\t%d\n", $x, $occ{$x};
}

printf STDERR "%d\t%d\t%d\n", $pos, $neg, $zero;
