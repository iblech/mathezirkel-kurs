set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#9600ff' linetype 1 linewidth 4
set style line 3 linecolor rgb '#4444ff' linetype 1 linewidth 4

unset border
set grid
unset xtics
unset ytics
set xrange [ -4.5 : 4.5 ]
set yrange [ -5 : 5 ]
set xzeroaxis ls 1 lw 3
set yzeroaxis ls 1 lw 3
set samples 10000

set terminal pdf size 8cm, 4cm dashed
set output "plot-1-en.pdf"

set title "continuous"
plot ((x-0.5)**3. + 3*(x-0.5)**2. - 6*(x-0.5) - 8)/4. w l ls 3 t ""
