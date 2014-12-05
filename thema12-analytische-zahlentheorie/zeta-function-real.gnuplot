set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#ff4444' linetype 1 linewidth 4
set style line 3 linecolor rgb '#000000' linetype 2 linewidth 1

unset xtics
unset ytics
unset border
set xzeroaxis ls 1
set yzeroaxis ls 1
set samples 100000

set terminal pdf size 4cm, 4cm dashed

set xrange [-1:6]
set yrange [-1:6]
#set xtics ("0" 0, "1" 1)
#set ytics ("0" 0, "1" 1)

set output "zeta-function-real.pdf"
set arrow from 1,-1 to 1,6 nohead ls 3
plot 1 t "" w l ls 3, "<./zeta-function-real.pl" t "" w l ls 2
