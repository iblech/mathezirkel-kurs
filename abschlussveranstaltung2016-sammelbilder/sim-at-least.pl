#!/usr/bin/perl

use warnings;
use strict;

my $M = $ARGV[0] || 6;
my $N = $ARGV[1] || 10000;

my @record;

for (1..$N) {
    my $steps = 0;
    my %seen;
    until(keys %seen == $M) {
        $seen{int rand $M}++;
        $steps++;
    }
    $record[$steps]++;
}

for my $steps (0..$#record) {
    my $cum = 0;
    $cum += $_ || 0 for @record[$steps..$#record];
    printf "%d\t%.4f\n", $steps, $cum / $N;
}
