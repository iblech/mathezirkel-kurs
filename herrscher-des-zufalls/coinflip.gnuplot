! ./coinflip.pl 10000 100 > coinflip.txt

n = 100

bind a "n=n*1.1; replot"
bind A "n=n/1.1; replot"

set grid
plot "<" . sprintf("head -n %d coinflip.txt", n) using 1:2:3 w lp lw 5 palette, 0 w l lw 5
pause -1

