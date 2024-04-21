! ./rekorde.pl 1000 10 > rekorde-zeitreihe.txt

n = 2

bind a "n=n*1.1; replot"
bind A "n=n/1.1; replot"

set yrange [0:20]
plot "<" . sprintf("head -n %d rekorde-zeitreihe.txt", n) using 1:2:3 w lp lw 5 palette
pause -1
