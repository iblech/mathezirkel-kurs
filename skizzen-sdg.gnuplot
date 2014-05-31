set style line 1 linecolor rgb '#000000' linetype 1 linewidth 2
set style line 2 linecolor rgb '#ff4444' linetype 1 linewidth 4
set style line 3 linecolor rgb '#4444ff' linetype 1 linewidth 4

unset xtics
unset ytics
unset border
set xzeroaxis ls 1
set yzeroaxis ls 1
set samples 10000

set terminal pdf size 7cm, 4cm


## Schnittverhalten
set xrange [-3:3]
set yrange [-1:3]

set output "sdg-schnittverhalten1.pdf"
plot 0 t "" w l ls 2, x/2. t "" w l ls 3

set output "sdg-schnittverhalten2.pdf"
plot 0 t "" w l ls 2, x**2. t "" w l ls 3


## Nicht differenzierbare Funktionen
set xrange [-3:3]
set yrange [-1:3]

set output "sdg-nicht-diffbar1.pdf"
plot abs(x) t "" w l ls 2

set output "sdg-nicht-diffbar2.pdf"
set xrange [-0.085:0.085]
set yrange [-0.09:0.09]
plot x*sin(1./x) t "" w l ls 2
