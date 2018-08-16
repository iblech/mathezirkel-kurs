#!/usr/bin/env perl

use warnings;
use strict;

use List::Util qw< sum >;

# f(N,M,K,m) = Wahrscheinlichkeit, dass beim Ziehen von K Bonbons aus einer Urne
# mit N weißen und M roten Bonbons genau m weiße dabei sind (der Einfachheit
# halber mit Zurücklegen)
sub f {
    my ($N,$M,$K,$m) = @_;

    return 0 if $m > $K;
    return binom($K,$m) * ($M/($N+$M))**$m * ($N/($N+$M))**($K-$m);
}

sub binom {
    my ($n,$k) = @_;

    my $a = 1;
    for my $i (1..$k) {
        $a *= $n-- / $k--;  # /
    }

    return $a;
}

sub min0 { $_[0] > 0 ? $_[0] : 0 }

my @p = ((0) x 100, (1/100) x 100);

my $it = 0;
while() {
    # my $k = <>;
    my $k = 0;
    for(1..10) {
        $k++ if rand() < 10/(150+10);
    }

    #print "\033[2J";
    print "Neue Beobachtung: $k\n";

    my @q;
    for my $N (0..$#p) {
        if($p[$N] == 0) {
            push @q, 0;
            next;
        }
        push @q, f($N,10,10,$k) * $p[$N] / sum(map { f($_,10,10,$k)*$p[$_] } 0..$#p);
    }

    @p = @q;
    $it++;

    #printf "%2d: %.8f %s\n", $_, $p[$_], $p[$_] == 0 ? "" : "*" x min0(100 + log $p[$_]) for 0..60;
    printf "E = %.3f\n", sum(map { $p[$_] * $_ } 0..$#p);
    print "\n";
}

# P(N=n | X=x) = P(X = x | N=n) * P(N = n) / sum_m (P(X=x|N=m) P(N=m))
