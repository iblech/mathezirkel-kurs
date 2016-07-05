#!/usr/bin/perl

use warnings;
use strict;

my $M = $ARGV[0] || 6;
my $G = $ARGV[1] || 30;
my $N = $ARGV[2] || 10000;

my @counts;

for (1..$N) {
    my $max = 0;
    for (1..$G) {
        my $steps = 0;
        my %seen;
        until(keys %seen == $M) {
            $seen{int rand $M}++;
            $steps++;
        }
        $max = $steps if $steps > $max;
    }
    $counts[$max]++;
}

for my $i (0..$#counts) {
    printf "%d\t%f\n", $i, ($counts[$i] || 0) / $N, $/;
}
