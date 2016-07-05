#!/usr/bin/perl

use warnings;
use strict;

my $M = $ARGV[0] || 6;
my $N = $ARGV[1] || 10;

srand 47;

my $steps = 0;
my %seen;

for (1..$N) {
    $seen{int rand $M}++;
    $steps++;
    printf "%d\t%d\n", $steps, scalar keys %seen;
    if(keys %seen == $M) {
        print "\n";
        %seen = ();
        $steps = 0;
    }
}
