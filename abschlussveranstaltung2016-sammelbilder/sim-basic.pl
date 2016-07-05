#!/usr/bin/perl

use warnings;
use strict;

my $M = $ARGV[0] || 10;
my $N = $ARGV[1] || 1000;

my $record = 0;

print "AnzahlBenoetigterWuerfe\n";

for (1..$N) {
    my $steps = 0;
    my %seen;
    until(keys %seen == $M) {
        $seen{int rand $M}++;
        $steps++;
    }
    $record += $steps;
    print $steps, $/;
}

print STDERR $record / $N, $/;
