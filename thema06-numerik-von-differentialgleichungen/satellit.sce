// Scilab-Programm zur Simulation des Orbits eines Satelliten um die Erde

// Alle physikalischen Größen sind in SI-Einheiten kodiert.

// Gravitationskonstante
G = 6.6738480e-11

// Masse der Erde
M = 5.97219e24

// Anfangsposition und -geschwindigkeit für einen geostationären Orbit
u = [0, 35786000+6371000]
v = [-3070, 0]

// Anfangszeit
t = 0

// Zu plottender Bereich
dim = [-150000000, -150000000, 150000000, 150000000]

// Zeit in Sekunden, die zwischen je zwei Zeitschritten vergehen soll
dt = 12

// Routine, die für die Zeitdauer T die Simulation durchführt.
// Wenn thrustTime positiv ist, werden bei Beginn der Simulation für die
// Zeitdauer thrustTime die Triebwerke gezündet.
// Ist thrustDir 0, so erfolgt Beschleunigung in Normalrichtung, sonst in
// Tangentialrichtung.
function advance(T, thrustTime, thrustDir)
    global u v t
    tbegin = t

    while t < tbegin+T do
        // Jede simulierte Viertelstunde die Position ausgeben
        if(modulo(t,3600/4) == 0)
            plot2d([u(1)], [u(2)], rect=dim, style=-14);
            phi = 180-atan(u(1),u(2))*180/%pi;
            day = t/86400;
            xtitle(sprintf("Tage nach Beginn: %.2f, Winkel: %.1f", day, phi));
        end

        // Beschleunigung durch die Gravitation
        a = G * M / norm(u)^3 * (-u);

        // Beschleunigung durch Triebwerke
        if(t-tbegin < thrustTime)
            if(thrustDir == 0)  // Normalrichtung
                a = a + 10 * u/norm(u);
            else  // Tangentialrichtung
                a = a + 10 * [-u(2),u(1)]/norm(u);
            end
        end

        // Implizites Euler-Verfahren (nicht geeignet für ernsthafte
        // Anwendungen!)
        v = v + dt*a;
        u = u + dt*v;
        t = t + dt;
    end
endfunction

clf;

function reset()
    global u v t
    u = [0, 35786000+6371000]
    v = [-3070, 0]

    // Anfangszeit
    t = 0
endfunction

// Beispielmanöver: ein Hohmann-Transfer.
function hohmann()
    advance(3600*24, 0,0);
    advance(3600*18, 0,0);
    advance(3600*6, 60,1);
    advance(3600*75, 0,0);
    advance(3600*144, 60,1);
endfunction

hohmann();
