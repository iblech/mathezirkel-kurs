w6-max30.dat:
	./sim-maximum.pl 6 30 100000 > w6-max30.dat

w6-max30.png: w6-max30.dat
	gnuplot w6-max30.gnuplot

ww680.dat:
	./sim-probabilities.pl 680 100000 > ww680.dat

ww680-coop2.dat:
	./sim-probabilities-coop.pl 680 2 0 100000 > ww680-coop2.dat

ww680-coop2-50nachkaufen.dat:
	./sim-probabilities-coop.pl 680 2 50 100000 > ww680-coop2-50nachkaufen.dat

ww680-coop3-50nachkaufen.dat:
	./sim-probabilities-coop.pl 680 3 50 100000 > ww680-coop3-50nachkaufen.dat

ww680-1.pdf ww680-2.pdf ww680-3.pdf ww680-4.pdf: ww680.dat ww680-coop2.dat ww680-coop2-50nachkaufen.dat ww680-coop3-50nachkaufen.dat
	gnuplot mehrere-680er-plots.gnuplot
