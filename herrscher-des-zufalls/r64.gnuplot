! ./r64.pl 1000 1 > rekorde-zeitreihe.txt

n = 2

bind a "n=n*1.1; replot"
bind A "n=n/1.1; replot"

plot "<" . sprintf("head -n %d rekorde-zeitreihe.txt", n) using 1:2:3 w lp lw 5 palette, log(x)+0.5772, "./welttemprek.dat" using ($1-1959):2 w lp lw 5
pause -1
