set grid
set yrange [ 0:7 ]

N=1
bind "n" "N = N + 1; replot"

plot sprintf("<./sim-step-by-step.pl 6 %d", N) w lp
