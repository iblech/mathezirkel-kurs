#!/usr/bin/env gnuplot

set parametric
set urange [ 0 : 2*pi ]
set vrange [ 0 : 2*pi ]

spherex(u,v) = sin(u) * cos(v)
spherey(u,v) = sin(u) * sin(v)
spherez(u,v) = cos(u)

triangle(a,b,t) = sin((t-a)/(b-a) * pi)

a = 3
b = 0
c = 0
d = 0

ellx(t) = cos(t)*3 + a
elly(t) = b
ellz(t) = sin(t) + c
ellw(t) = d + \
    ( t <= 1 ? 0 : \
      t <= 3 ? triangle(1,3,t) : \
      t <= 3.3 ? 0 : \
      t <= 6 ? -triangle(3.3,6,t) : 0 \
    )

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
bind x "a = a <= 4-eps  ? a + 0.1 : a; replot"
bind X "a = a >= 2+eps  ? a - 0.1 : a; replot"
bind y "b = b <= 1-eps  ? b + 0.1 : b; replot"
bind Y "b = b >= -1+eps ? b - 0.1 : b; replot"
bind z "c = c <= 1-eps  ? c + 0.1 : c; replot"
bind Z "c = c >= -1+eps ? c - 0.1 : c; replot"
bind w "d = d <= 1-eps  ? d + 0.1 : d; replot"
bind W "d = d >= -1+eps ? d - 0.1 : d; replot"

splot \
    spherex(u,v),spherey(u,v),spherez(u,v) w l lc 4 lw 1, \
    "+" u (ellx(s($1))):(elly(s($1))):(ellz(s($1))):(ellw(s($1))) w l lc palette lw 8
pause -1
