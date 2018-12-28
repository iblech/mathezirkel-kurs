#!/usr/bin/env gnuplot

set parametric
set urange [ 0 : 2*pi ]
set vrange [ 0 : pi ]

i = 0
coolsin(t) = sin(t) < 0 ? 0 : sin(t)**2
spherex(u,v) = sin(u) * cos(v) # * (1 + 0.1 * coolsin(i+u+v) * coolsin(u*5+v*5))
spherey(u,v) = sin(u) * sin(v) # * (1 + 0.1 * coolsin(i+u+v) * coolsin(u*5+v*5))
spherez(u,v) = cos(u) # * (1 + 0.1 * coolsin(i+u+v) * coolsin(u*5+v*5))

triangle(a,b,t) = sin((t-a)/(b-a) * pi)
triangle(a,b,t) = 1

sawtooth(t) = \
    ( t <= 2.*pi/4.    ? t : \
      t <= 3./4.*2.*pi ? pi - t : t - 2.*pi \
    ) / (pi/2.)

a = 1
b = 0
c = 0
d = 0
h = 1
i = 0

doHide(w) = h ? (abs(w) > 0.1 ? 1/0 : w) : w

ellx(t) = cos(t) + a
elly(t) = b + 0.05 * sin(i*5+t) * sin(t*10)
ellz(t) = sin(t)/sqrt(2) + c
ellw(t) = doHide(d + \
    ( t <= 1 ? 0 : \
      t <= 2.7 ? triangle(1,3,t) : \
      t <= 3.3 ? 0 : \
      t <= 6 ? -triangle(3.3,6,t) : 0 \
    ))
ellw(t) = doHide(d + sawtooth(t))

ok(a,b,c,d) = int(system(sprintf(" \
    perl -we ' \
        use constant PI => 3.1415926535; \
        sub triangle_ { sin(($_[2]-$_[0])/($_[1]-$_[0]) * PI) } \
        sub triangle { 1 } \
        sub sawtooth { \
          ( $_[0] <= 2.*PI/4.    ? $_[0] : \
            $_[0] <= 3./4.*2.*PI ? PI - $_[0] : $_[0] - 2.*PI \
          ) / (PI/2.) } \
        sub ellx { cos($_[0]) + %f } \
        sub elly { %f } \
        sub ellz { sin($_[0])/sqrt(2) + %f } \
        sub ellw { %f + sawtooth($_[0]) } \
        for(my $t = 0; $t < 2*PI; $t += 0.01) { \
            if(sqrt((sqrt(ellx($t)**2 + elly($t)**2 + ellz($t)**2) - 1)**2 + ellw($t)**2) < 0.1) { \
                print 0, $/; \
                exit; \
            } \
        } \
        print 1, $/; \
    ' \
", a,b,c,d)))

s(u) = (u + 10) / 20 * 2*pi

set hidden3d
set title "Link of string and sphere"
set xlabel "x"
set ylabel "y"
set zlabel "z"
set xrange [ -1.2 : 2 ]
set yrange [ -1.2 : 2 ]
set zrange [ -1.2 : 1.2 ]
set cbrange [ -1 : 1 ]

set isosamples 30
set palette defined (0 "blue", 0.5 "black", 1 "red")

dt = 0.05
bind x "a = ok(a+dt,b,c,d) ? a+dt : a; replot"
bind X "a = ok(a-dt,b,c,d) ? a-dt : a; replot"
bind y "b = ok(a,b+dt,c,d) ? b+dt : b; replot"
bind Y "b = ok(a,b-dt,c,d) ? b-dt : b; replot"
bind z "c = ok(a,b,c+dt,d) ? c+dt : c; replot"
bind Z "c = ok(a,b,c-dt,d) ? c-dt : c; replot"
bind w "d = ok(a,b,c,d+dt) ? d+dt : d; replot"
bind W "d = ok(a,b,c,d-dt) ? d-dt : d; replot"
bind i "i = i + dt; replot"
bind I "i = i - dt; replot"
bind h "h = 1 - h; replot"
bind H "unset hidden3d; replot"

do for [ii=1:9999] {
    splot \
        spherex(u,v),spherey(u,v),spherez(u,v) w l lc rgb "gray" lw 1 t "", \
        "+" u (ellx(s($1))):(elly(s($1))):(ellz(s($1))):(ellw(s($1))) w l lc palette lw 8 t sprintf("%.2f", d)
    i = i + dt
}
pause -1
