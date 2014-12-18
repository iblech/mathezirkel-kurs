set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#ff4444' linetype 1 linewidth 4
set style line 3 linecolor rgb '#4444ff' linetype 2 linewidth 1

unset xtics
unset ytics
unset border
set xzeroaxis ls 1
set yzeroaxis ls 1
set samples 100000

set terminal pdf size 4cm, 4cm dashed

set xrange [-0.1:10]
#set xtics ("0" 0, "1" 1)
#set ytics ("0" 0, "1" 1)

set output "asymptotic-notation.pdf"
plot x*sin(x)*sin(x) t "" w l ls 2, 1 t "" w l ls 3
