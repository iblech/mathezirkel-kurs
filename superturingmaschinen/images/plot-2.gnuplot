set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#9600ff' linetype 1 linewidth 4
set style line 3 linecolor rgb '#4444ff' linetype 1 linewidth 4

unset border
set grid
unset xtics
unset ytics
set xrange [ -4.5 : 4.5 ]
set yrange [ -1.5 : 1.5 ]
set xzeroaxis ls 1 lw 3
set yzeroaxis ls 1 lw 3
set samples 10000

set terminal pdf size 8cm, 4cm dashed
set output "plot-2.pdf"

set title "unstetig"
plot (x < -0.05 ? -1 : x > 0.05 ? 1 : 1/0) w l ls 3 t "", \
  (abs(x) < 0.05 ? 0 : 1/0) w l ls 3 t ""
