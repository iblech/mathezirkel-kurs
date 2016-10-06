#!/usr/bin/perl

use warnings;
use strict;

use Time::HiRes qw< sleep >;
$|++;

sub plot {
    my ($time, $cursor, @tape) = @_;

    print "\033[H\033[J";

    print "+---" x @tape, "+----\n";

    print "| $_ " for @tape;
    print "| ...\n";

    print "+---" x @tape, "+----\n";

    if($cursor <= $#tape) {
        my $filler = "    " x $cursor;
        print "$filler  ^\n";
        print "$filler  |\n";
    } else {
        print "\n\n";
    }

    print "\n\n\n    Zeitschritt: $time\n";
}

sub ordinal {
    my ($i, $j) = @_;

    my $str = join " + ",
        $i == 0 ? () : $i == 1 ? "omega" : "$i omega",
        $j == 0 ? () : $j;

    return $str || "0";
}

my $delay = 0;
sub pause {
    $delay /= 1.7;
    sleep $delay;
}

for my $i (0..40) {
    $delay = 5 / 1.5**($i < 20 ? $i : 20);
    plot(ordinal($i, 0), 0, 0, ("0") x 10); pause();
    plot(ordinal($i, 1), 0, 1, ("0") x 10); pause();
    for my $j (1..47) {
        plot(ordinal($i, 1+$j), $j, 0, ("0") x 10);
        pause();
    }
}

plot("omega^2", 0, 1, ("0") x 10);

print "\n\nMaschine ist angehalten.\n";
