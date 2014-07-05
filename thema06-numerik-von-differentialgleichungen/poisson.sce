// Scilab-Programm zur Lösung der Poisson-Gleichung

// Berechnet die rechte Seite des Gleichungssystems.
// Hier gehen die vorgegebenen Randwerte ein (Heizung und Fenster).
function [b] = assembleRHS(N)
    // Gitterbreite
    h  = 1/N;

    // x- bzw. y-Koordinaten der einzelnen Gitterpunkte
    cs = 0 : 1/N : 1;

    b = zeros((N+1)*(N+1),1);

    // Schleife über alle Gitterpunkte
    for i = 0:N  // y-Koordinaten
        for j = 0:N  // k-Koordinaten
            // Indexumrechnung
            k = i*(N+1) + j + 1;

            // unterer Rand
            if(i == 0 & cs(j+1) > 0.3 & cs(j+1) < 0.7)
                b(k) = 10;

            // oberer Rand
            elseif(i == N & modulo(round(cs(j+1)*40),8) < 2)
                b(k) = 40;

            // linker Rand
            elseif(j == 0 & cs(i+1) > 0.3 & cs(i+1) < 0.7)
                b(k) = 40;

            // sonstige Teile der Ränder
            elseif(i == 0 | j == 0 | i == N | j == N)
                b(k) = 20;
            end
        end
    end
endfunction
  
// Berechnet die Matrix zum Laplace-Operator.
function [A] = assembleA(N)
    h  = 1/N;
    cs = 0 : 1/N : 1;

    A = sparse([], [], [(N+1)*(N+1),(N+1)*(N+1)]);

    for i = 0:N
        for j = 0:N
            k = i*(N+1) + j + 1;
            if(i == 0 | i == N | j == 0 | j == N)
                A(k,k) = 1;
            else
                A(k,k)       = -4 / h^2;
                A(k,k-(N+1)) =  1 / h^2;
                A(k,k+(N+1)) =  1 / h^2;
                A(k,k-1)     =  1 / h^2;
                A(k,k+1)     =  1 / h^2;
            end
        end
    end
endfunction

// Plottet eine Wärmeverteilung.
function heatplot(N, u)
    cs = 0 : 1/N : 1;

    zs = [];
    for i = 0:N
        for j = 0:N
            zs(j+1,i+1) = u(i*(N+1) + j + 1);
        end
    end
    
    xset("colormap",jetcolormap(64));
    Sgrayplot(cs,cs,zs);
endfunction

// Demoprogramm: stationäre Wärmeverteilung
function calcStationary(N)
    A = assembleA(N);
    b = assembleRHS(N);
    u = lusolve(A,b);
    heatplot(N,u);
endfunction

calcStationary(10);
