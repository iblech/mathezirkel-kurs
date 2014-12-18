set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#ff4444' linetype 1 linewidth 4
set style line 3 linecolor rgb '#000000' linetype 2 linewidth 1

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

set output "mangoldt-function.pdf"
plot "<./mangoldt-function | head -n 155" t "" w impulses ls 2
