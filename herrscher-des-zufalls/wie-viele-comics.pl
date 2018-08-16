#!/usr/bin/env perl

use warnings;
use strict;

use List::Util qw< sum >;

# f(N,k) = Wahrscheinlichkeit, dass beim Ziehen aus einer Urne mit N Comics
# die erste Wiederholung nach genau k Ziehungen auftritt
sub f {
    my ($N, $k) = @_;

    return 0 if $k <= 1;
    return 0 if $N == 0;

    my $p = 1;
    for my $i (reverse (0..($k-2))) {
        $p *= ($N - $i) / $N;
    }
    $p *= ($k-1) / $N;

    return $p;
}

sub min0 { $_[0] > 0 ? $_[0] : 0 }

my @p = (1/20) x 20;

my $it = 0;
while() {
    # my $k = <>;
    my @seen;
    my $k = 0;
    while() {
        $k++;
        last if $seen[int rand 17]++;
    }

    print "\033[2J";
    print "Neue Beobachtung: $k\n\n";

    my @q;
    for my $N (0..$#p) {
        push @q, f($N, $k) * $p[$N] / sum(map { f($_,$k)*$p[$_] } 0..$#p);
    }

    @p = @q;
    $it++;

    printf "%2d: %.8f %s\n", $_, $p[$_], $p[$_] == 0 ? "" : "*" x min0(100 + log $p[$_]) for 0..$#p;
    printf "E = %.3f\n", sum(map { $p[$_] * $_ } 0..$#p);
    print "\n";

    last if $it > 5;
}

# P(N=n | X=x) = P(X = x | N=n) * P(N = n) / sum_m (P(X=x|N=m) P(N=m))
