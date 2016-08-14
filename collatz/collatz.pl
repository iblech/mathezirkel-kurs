#!/usr/bin/perl

use warnings;
use strict;

my $MAX = $ARGV[0] || 100;

my @table;

print "digraph foo { node [ shape=box ];";

for my $n (1..$MAX) {
    my $m = $n;

    until(defined $table[$m]) {
        my $next = $m % 2 == 0 ? $m / 2 : 3*$m + 1;
        $table[$m] = $next;
        print "$m -> $next;\n";
        $m = $next;
    }
}

print "}";
