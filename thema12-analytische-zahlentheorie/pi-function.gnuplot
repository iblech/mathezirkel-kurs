set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#ff4444' linetype 1 linewidth 4
set style line 3 linecolor rgb '#4444ff' linetype 1 linewidth 4

unset xtics
unset ytics
unset border
set xzeroaxis ls 1
set yzeroaxis ls 1
set samples 100000

set terminal pdf size 10cm, 6cm dashed

#set xrange [-1:10000]
#set xtics ("0" 0, "1" 1)
#set ytics ("0" 0, "1" 1)

set output "pi-function-1.pdf"
plot "<./pi-function 0.01 | head -n 7700" t "" w l ls 2

set output "pi-function-2.pdf"
plot "<./chebyshev-function 1 | head -n 3000" t "" w l ls 2
