! ./rekorde.pl 10000 > rekorde-hist.txt

n = 100

bind a "n=n*1.1; replot"
bind A "n=n/1.1; replot"

set xrange [0:20]
plot "<" . sprintf("head -n %d rekorde-hist.txt | tail -n 2000", n) using 1:2:3 w lp lw 5 palette
pause -1
