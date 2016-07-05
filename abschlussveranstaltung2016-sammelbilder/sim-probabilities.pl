#!/usr/bin/perl

use warnings;
use strict;

my $M = $ARGV[0] || 10;
my $N = $ARGV[1] || 1000;

my @counts;

for (1..$N) {
    my $steps = 0;
    my %seen;
    until(keys %seen == $M) {
        $seen{int rand $M}++;
        $steps++;
    }
    $counts[$steps]++;
}

for my $i (0..$#counts) {
    printf "%d\t%f\n", $i, ($counts[$i] || 0) / $N, $/;
}
