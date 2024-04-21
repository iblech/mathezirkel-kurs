! ./runs.pl 1000 1 > runs-zeitreihe.txt

n = 10

bind a "n=n*1.1; replot"
bind A "n=n/1.1; replot"

set yrange [0:50]
plot "<" . sprintf("head -n %d runs-zeitreihe.txt", n) using 1:2:3 w lp lw 5 palette
pause -1
