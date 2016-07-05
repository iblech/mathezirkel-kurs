set terminal "png"
set output "w6-max30.png"
set grid
set boxwidth 1
plot "w6-max30.dat" w boxes  #smooth cumulative
