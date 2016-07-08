#!/usr/bin/perl

use warnings;
use strict;

use List::Util qw< sum >;

my $M = $ARGV[0] || 10;
my $P = $ARGV[1] || 2;
my $J = $ARGV[2] // 2;  # Anzahl Nachbestellungen pro Sammler
my $N = $ARGV[3] || 1000;

my @counts;

for (1..$N) {
    my $steps = 0;
    my %seen;
    until(keys %seen >= $M - $P*$J and $P*$J >= sum(0, map { $_ < $P ? $P-$_ : 0 } values %seen)) {
        $seen{int rand $M}++ for 1..$P;
        $steps++;
    }
    $counts[$steps]++;
}

for my $i (0..$#counts) {
    printf "%d\t%f\n", $i, ($counts[$i] || 0) / $N, $/;
}
