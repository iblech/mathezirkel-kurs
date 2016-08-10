#!/usr/bin/perl

use warnings;
use strict;

my $weightedsum = 0;
my $cump        = 0;

while(<>) {
    my ($val, $p) = split /\s/;

    $weightedsum += $val * $p;
    $cump += $p;

    for my $q (0.9, 0.95, 0.99) {
        if($cump >= $q and $cump - $p < $q) {
            print "$q-Quantil: <= $val\n";
        }
    }
}

print "Erwartungswert: $weightedsum\n";
