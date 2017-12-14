#!/usr/bin/env gnuplot

set parametric
set urange [ 0 : 2*pi ]
set vrange [ 0 : 2*pi ]

spherex(u,v) = sin(u) * cos(v)
spherey(u,v) = sin(u) * sin(v)
spherez(u,v) = cos(u)

triangle(a,b,t) = sin((t-a)/(b-a) * pi)
triangle(a,b,t) = 1

a = 3
b = 0
c = 0
d = 0
h = 1

doHide(w) = h ? (abs(w) > 0.05 ? 1/0 : w) : w

ellx(t) = cos(t)*3 + a
elly(t) = b
ellz(t) = sin(t) + c
ellw(t) = doHide(d + \
    ( t <= 1 ? 0 : \
      t <= 2.7 ? triangle(1,3,t) : \
      t <= 3.3 ? 0 : \
      t <= 6 ? -triangle(3.3,6,t) : 0 \
    ))

ok(a,b,c,d) = int(system(sprintf(" \
    perl -we ' \
        use constant PI => 3.1415926535; \
        sub triangle_ { sin(($_[2]-$_[0])/($_[1]-$_[0]) * PI) } \
        sub triangle { 1 } \
        sub ellx { cos($_[0])*3 + %f } \
        sub elly { %f } \
        sub ellz { sin($_[0]) + %f } \
        sub ellw { %f + \
            ( $_[0] <= 1 ? 0 : \ \
              $_[0] <= 2.7 ? triangle(1,3,$_[0]) : \ \
              $_[0] <= 3.3 ? 0 : \ \
              $_[0] <= 6 ? -triangle(3.3,6,$_[0]) : 0 \ \
            ) } \
        for(my $t = 0; $t < 2*PI; $t += 0.01) { \
            if(abs(ellx($t)**2 + elly($t)**2 + ellz($t)**2 - 1) < 0.1 && abs(ellw($t)) < 0.1) { \
                print 0, $/; \
                exit; \
            } \
        } \
        print 1, $/; \
    ' \
", a,b,c,d)))

print ok(a,b,c,d)

s(u) = (u + 10) / 20 * 2*pi

set xlabel "x"
set ylabel "y"
set zlabel "z"
set xrange [ -1.2 : 9 ]
set yrange [ -1.2 : 9 ]
set zrange [ -2.2 : 2 ]
set cbrange [ -1 : 1 ]

set isosamples 60
set palette defined (0 "blue", 0.5 "black", 1 "red")

eps = 0.2
bind x "a = ok(a+0.1,b,c,d) ? a+0.1 : a; replot"
bind X "a = ok(a-0.1,b,c,d) ? a-0.1 : a; replot"
bind y "b = ok(a,b+0.1,c,d) ? b+0.1 : b; replot"
bind Y "b = ok(a,b-0.1,c,d) ? b-0.1 : b; replot"
bind z "c = ok(a,b,c+0.1,d) ? c+0.1 : c; replot"
bind Z "c = ok(a,b,c-0.1,d) ? c-0.1 : c; replot"
bind w "d = ok(a,b,c,d+0.1) ? d+0.1 : d; replot"
bind W "d = ok(a,b,c,d-0.1) ? d-0.1 : d; replot"
bind h "h = 1 - h; replot"

splot \
    spherex(u,v),spherey(u,v),spherez(u,v) w l lc 4 lw 1, \
    "+" u (ellx(s($1))):(elly(s($1))):(ellz(s($1))):(ellw(s($1))) w l lc palette lw 8
pause -1
