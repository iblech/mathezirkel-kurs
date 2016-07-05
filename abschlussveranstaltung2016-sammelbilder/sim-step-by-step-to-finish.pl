#!/usr/bin/perl

use warnings;
use strict;

my $M = $ARGV[0] || 6;

my $steps = 0;
my %seen;

until(keys %seen == $M) {
    $seen{int rand $M}++;
    $steps++;
    printf "%d\t%d\n", $steps, scalar keys %seen;
}
