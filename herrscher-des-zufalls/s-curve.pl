#!/usr/bin/env perl
# This is a small addition to the following instructive illustration:
#
#     Constance Crozier. Forecasting s-curves is hard. 2020.
#     https://constancecrozier.com/2020/04/16/forecasting-s-curves-is-hard/
#
# Usage:
# $ perl s-curve.pl > foo.gnuplot
# $ mkdir plots; gnuplot < foo.gnuplot
# $ ffmpeg -framerate 10 -i plots/%03d.png -vcodec libx264 -s 640x480 foo.mp4
# $ qt-faststart foo.mp4 bar.mp4

use warnings;
use strict;

use POSIX qw< floor >;

use constant PI => 4 * atan2(1,1);

sub S {
    my ($a,$b,$c,$t) = @_;

    return $c / (1 + $a * exp(-$b*$t));
}

sub normal {
    my ($mu, $sigma, $x) = @_;

    return exp(-1/2 * (($x-$mu)/$sigma)**2) / ($sigma * sqrt(2*PI));
}

sub draw_normal {
    my ($mu, $sigma) = @_;

    return sqrt(-2*log(rand())) * cos(2 * PI * rand()) * $sigma + $mu;
}

sub draw_true {
    my ($a,$b,$c,$t) = @_;

    my $S = S($a,$b,$c,$t);
    return draw_normal($S, 100);
}

# f(a,b,c,t,k) = Dichte, dass eine mit zufälligen Schwankungen behaftete
# a-b-c-S-Kurve zum Zeitpunkt t den Wert k annimmt.
sub f {
    my ($a,$b,$c,$t, $k) = @_;

    my $S = S($a,$b,$c,$t);

    return normal($S, 100, $k);
}

my (@valuesA, @valuesB, @valuesC);
for(my $v = 1; $v < 200; $v += 10) {
    push @valuesA, $v;
}
for(my $v = 0.01; $v < 0.5; $v += 0.01) {
    push @valuesB, $v;
}
for(my $v = 1000; $v < 10000; $v += 100) {
    push @valuesC, $v;
}

my @p;
for my $i (0..$#valuesA) {
    for my $j (0..$#valuesB) {
        for my $k (0..$#valuesC) {
            $p[$i][$j][$k] = 1 / (@valuesA * @valuesB * @valuesC);
        }
    }
}

sub jitter {
    return $_[0] + (rand() - 0.5) * $_[0]/20;
}

sub draw {
    my $x = rand();
    my $c = 0;

    for my $i (0..$#valuesA) {
        for my $j (0..$#valuesB) {
            for my $k (0..$#valuesC) {
                $c += $p[$i][$j][$k];
                return (jitter($valuesA[$i]),jitter($valuesB[$j]),jitter($valuesC[$k])) if $c >= $x;
            }
        }
    }

    die;
}

sub plot {
    my ($fh, $a,$b,$c) = @_;

    for(my $t = 1; $t <= 120; $t += 1) {
        print $fh $t, "\t", S($a,$b,$c,$t), "\n";
    }
    print $fh "\n";
}

sub plot_distribution {
    my $fh = shift;

    my $BINSIZE = 500;

    for(my $t = 1; $t <= 120; $t += 5) {
        my @w;
        for my $i (0..$#valuesA) {
            for my $j (0..$#valuesB) {
                for my $k (0..$#valuesC) {
                    my $s = S($valuesA[$i],$valuesB[$j],$valuesC[$k], $t);
                    $w[1 + floor(($s-$BINSIZE/2)/$BINSIZE)] += $p[$i][$j][$k];
                }
            }
        }

        for my $l (0..6500/$BINSIZE) {
            my $r = int((1 - ($w[$l] || 0)) * 256);
            $r = 255 if $r > 255;
            $r = 0   if $r < 0;
            printf $fh "%d\t%d\t%d\n", $t, $l * $BINSIZE,
                $r + 256*$r + 256*256*255;
        }
    }
}

#plot(draw()) for 1..1000;

my @true_parameters = (100,0.1,4000);

print "set grid\n";
print "set yrange [0:6500]\n";
print "set xrange [0:120]\n";
print "set terminal png\n";
print "S(a,b,c,t) = c/(1+a*exp(-b*t))\n";
$|++;

my @Xs = (107.64996241684651, 75.644293785293215, 238.03834193128432, 212.84885430223056,
     129.20759397417027, 56.393322676763646, 170.12889442681342, 33.366488761391047,
     225.47781802730543, 10.952977852756348, 34.181242119954476, 11.503160420741779,
     140.66878464822102, 167.22673954320516, 187.4695305651741, 124.86097874381383,
     205.41008895562359, 201.8017249612241, 288.25758938303255, 381.68713597628516,
     454.89582917386525, 457.39038542311926, 197.2879868717402, 304.2219466604754,
     451.92884422920019, 403.73303635917949, 534.11348429490295, 677.94499039009679,
     617.26532641811457, 728.88982652908317, 768.02740562418035, 819.42701562256366,
     788.04269661376838, 1016.4573174924733, 1137.7235689874294, 947.83405244780897,
     996.48743686367652, 1467.6315386660849, 1250.9504924124185, 1536.4436760895942,
     1461.8396409582242, 1640.9866287797483, 1534.468731605717, 1906.7615586382337,
     1763.7863548454397, 2017.9110034235543, 2056.2614086348867, 2048.1548195727805,
     2390.1413523091219, 2211.4613065477506, 2491.4135842189789, 2628.9074086839596,
     2739.4225587555588, 2505.7456511682417, 2615.1113563315175, 3106.1805804247019,
     3011.2364283040265, 3109.0005441173803, 3075.5685776905339, 3163.8849100225507,
     3378.8253871787128, 3269.4296466560263, 3345.6872745083624, 3523.2744933424242,
     3445.2254022292273, 3523.8527872843574, 3419.066957109414, 3643.4758745491936,
     3639.8258099536629, 3663.491424107187, 3670.0470771043165, 3843.4877746757547,
     3698.6798155844672, 3783.8738219272536, 3809.5095544095061, 3853.0073182972542,
     3708.6473522752531, 4065.2531114095095, 3965.6247858108045, 3936.569950277787,
     3832.4227471130566, 3856.313366930161, 3697.578731615949, 3861.2882573059915,
     3803.9775412821677, 3974.4093591269816, 3820.9622954701817, 3808.941102006147,
     4049.7394097249962, 3859.7000474242068, 4020.5594156009602, 3977.3167191564257,
     3917.1219937629903, 3764.8918669464924, 3937.9162636736573, 3940.8749799135685,
     4005.1404397169922, 4032.7789472279251, 3989.4915477996387, 4057.3531010554461,
     4013.6726137807759, 3985.4071469252058, 3943.3014318463042, 4016.6254087962311,
     4062.560331786301, 4038.0817403385199, 4043.1318296967193, 4113.549877647798,
     4019.4294152727889, 3999.0073588161522, 4094.6441108375552, 3933.0748050644411,
     4104.3562663660023, 4051.9917629860529, 3885.8223745044797, 3918.0688583897108,
     3995.4162178647953, 4004.6417834949148, 3944.2031935737714);

open my $fh, ">", "plots/values.dat" or die $!;
print $fh $_, "\t", $Xs[$_ - 1], "\n" for 1..119;
close $fh or die $!;

for(my $t = 1; $t <= 119; $t += 1) {
    my ($a,$b,$c) = (0,0,0);
    for my $i (0..$#valuesA) {
        for my $j (0..$#valuesB) {
            for my $k (0..$#valuesC) {
                $a += $p[$i][$j][$k] * $valuesA[$i];
                $b += $p[$i][$j][$k] * $valuesB[$j];
                $c += $p[$i][$j][$k] * $valuesC[$k];
            }
        }
    }

    printf "set output 'plots/%03d.png'\nset title 't = %03d'\n", $t, $t;
    print "unset arrow\n";
    print "set arrow from $t,0 to $t,6500 nohead dt 2 lc rgb 'blue' front\n";
    open my $fh, ">", sprintf("plots/%03d.dat", $t) or die $!;
    plot_distribution($fh);
    close $fh or die;
    print "plot ";
    printf "'plots/%03d.dat' using 1:2:3 t '' w p ps 5 pt 5 lc rgb variable, ", $t;
    printf "S(%f,%f,%f,x) t '' w l lc '#ffddff', ", draw() for 1..100;
    print "'plots/values.dat' t '' w p pt 2 lc 'grey' lw 2, ";
    printf "S(%f,%f,%f,x) t 'true' w l lw 4 lc 'black', ", @true_parameters;
    printf "S(%f,%f,%f,x) t 'predicted' w l lw 4 lc '#ff0055'", $a, $b, $c;
    print "\n";

    my $X = $Xs[$t - 1];

    printf STDERR "t = %d, new observation: %.02f [true expectation value: %.02f]\n", $t, $X, S(@true_parameters, $t);

    my $sum = 0;
    for my $i (0..$#valuesA) {
        for my $j (0..$#valuesB) {
            for my $k (0..$#valuesC) {
                $sum += f($valuesA[$i],$valuesB[$j],$valuesC[$k], $t, $X) * $p[$i][$j][$k];
            }
        }
    }

    my @q;
    for my $i (0..$#valuesA) {
        for my $j (0..$#valuesB) {
            for my $k (0..$#valuesC) {
                $q[$i][$j][$k] =
                    f($valuesA[$i],$valuesB[$j],$valuesC[$k], $t, $X) * $p[$i][$j][$k] / $sum;
            }
        }
    }
    @p = @q;
}
