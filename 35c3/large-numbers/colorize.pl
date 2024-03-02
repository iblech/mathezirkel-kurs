#!/usr/bin/env perl
# Usage: ./graham 3 100 | ./colorize.pl i=0
# Usage: i=0; ./graham 3 100 | ./colorize.pl | while read; do echo "$REPLY"; perl -MTime::HiRes=sleep -we "sleep $i/200"; : $((i++)); done

use warnings;
use strict;

my @lines = map { [split //] } <>;

for(my $i = 0; $i < @lines; $i++) {
    my @new_line;

    my $is_same = 1;
    for(my $j = $#{ $lines[$i] }; $j >= 0; $j--) {
        $is_same = 0 if $lines[$i][$j] eq " ";
        if($is_same and $lines[$i][$j] eq $lines[-1][$j]) {
            push @new_line, "\033[37m\033[32;1m$lines[$i][$j]\033[0m";
        } else {
            push @new_line, $lines[$i][$j];
            $is_same = 0;
        }
    }

    print join "", reverse @new_line;
}
