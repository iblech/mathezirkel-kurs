#!/usr/bin/perl

use warnings;
use strict;
use feature qw< say >;

my $x = 0;

for (1..$ARGV[0]) {
    $x += rand() > 0.5 ? 1 : -1;
    say $x;
}
