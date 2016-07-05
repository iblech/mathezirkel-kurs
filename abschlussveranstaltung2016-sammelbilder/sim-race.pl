#!/usr/bin/perl

use warnings;
use strict;

my $M = $ARGV[0] || 6;
my $P = $ARGV[1] || 25;

my @players;
push @players, {} for 1..$P;

while(1) {
    for my $p (@players) {
        next if keys %{ $p->{seen} } == $M;

        my $roll = int rand $M;
        $p->{seen}{$roll}++;
        $p->{str} .= 1 + $roll;
    }

    system("clear");
    for my $p (@players) {
        print $p->{str}, " " x (40 - length $p->{str}), length $p->{str}, $/;
    }

    <STDIN>;
}
