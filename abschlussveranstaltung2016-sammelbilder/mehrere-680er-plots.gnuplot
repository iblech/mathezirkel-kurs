set grid
set xrange [0:10000]
set title "680 Sticker"

set terminal pdf size 12cm, 9cm

set output "ww680-1.pdf"
plot \
    "./ww680.dat" using ($1):($2/100000):(100) smooth kdensity w l lw 2 t "eine Sammlerin, ohne Nachbestellung"

set output "ww680-2.pdf"
plot \
    "./ww680.dat" using ($1):($2/100000):(100) smooth kdensity w l lw 2 t "eine Sammlerin, ohne Nachbestellung", \
    "./ww680-coop2.dat" using 1:2:(100) smooth kdensity w l lw 2 t "zwei kooperative Sammlerinnen, ohne Nachbestellung"

set output "ww680-3.pdf"
plot \
    "./ww680.dat" using ($1):($2/100000):(100) smooth kdensity w l lw 2 t "eine Sammlerin, ohne Nachbestellung", \
    "./ww680-coop2.dat" using 1:2:(100) smooth kdensity w l lw 2 t "zwei kooperative Sammlerinnen, ohne Nachbestellung", \
    "./ww680-coop2-20nachkaufen.dat" using 1:2:(10) smooth kdensity w l lw 2 t "zwei kooperative Sammlerinnen, mit Nachbestellung"
    
set output "ww680-4.pdf"
plot \
    "./ww680.dat" using ($1):($2/100000):(100) smooth kdensity w l lw 2 t "eine Sammlerin, ohne Nachbestellung", \
    "./ww680-coop2.dat" using 1:2:(100) smooth kdensity w l lw 2 t "zwei kooperative Sammlerinnen, ohne Nachbestellung", \
    "./ww680-coop2-20nachkaufen.dat" using 1:2:(10) smooth kdensity w l lw 2 t "zwei kooperative Sammlerinnen, mit Nachbestellung", \
    "./ww680-coop3-20nachkaufen.dat" using 1:2:(10) smooth kdensity w l lw 2 t "drei kooperative Sammlerinnen, mit Nachbestellung"
