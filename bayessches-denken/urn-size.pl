#!/usr/bin/perl

use warnings;
use strict;

sub binom {
    my ($n, $k) = @_;

    my $product = 1;
    while ($k > 0) {
        $product *= $n--;
        $product /= $k--;
    }
    return $product;
}

sub prior {
    my $n = shift;

    return 1 <= $n && $n <= 20 ? 1/20 : 0;
}

sub likelihood {
    my ($k, $x) = @_;

    return binom($x,$k) / 2**$x;
}

my $k = $ARGV[0] || 4;
my @posterior;
my $sum = 0;

for my $x (0..29) {
    my $p = likelihood($k, $x);
    push @posterior, $p;
    $sum += $p;
}

for my $x (0..20) {
    printf "%d\t%f\n", $x, $posterior[$x]/$sum;
}
