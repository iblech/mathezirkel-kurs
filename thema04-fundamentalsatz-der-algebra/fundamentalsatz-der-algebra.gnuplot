# http://www.cut-the-knot.org/fta/fta_sketch1.shtml

f(z) = z**3. + 2.*z**2. - z + 0.5

r = 2.3
g(t) = r*exp(2*pi*sqrt(-1)*t)

bbox = 25
sc = 1.1
tmax = 0.01

bind a "r = r / sc; set xrange [-bbox:bbox]; set yrange [-bbox:bbox]; replot"
bind s "r = r * sc; set xrange [-bbox:bbox]; set yrange [-bbox:bbox]; replot"

bind A "bbox = bbox / sc**5.; set xrange [-bbox:bbox]; set yrange [-bbox:bbox]; replot"
bind S "bbox = bbox * sc**5.; set xrange [-bbox:bbox]; set yrange [-bbox:bbox]; replot"

bind z "tmax = tmax - 0.05; tmax = tmax < 0 ? 0 : tmax; set trange [0:tmax]; replot"
bind u "tmax = tmax + 0.05; tmax = tmax > 1 ? 1 : tmax; set trange [0:tmax]; replot"

set parametric
set grid
set trange [0:tmax]
set xrange [-bbox:bbox]
set yrange [-bbox:bbox]
plot real(f(g(t))), imag(f(g(t))) t sprintf("r=%f, tmax=%f", r, tmax), \
  real(g(t)),imag(g(t)) t ""
