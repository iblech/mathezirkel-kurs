// Berechnet die rechte Seite des Gleichungssystems.
// Hier gehen die vorgegebenen Randwerte ein (Heizung und Fenster).
function [b] = assembleRHS(N,t)
    // Gitterbreite
    h  = 1/N;

    // x- bzw. y-Koordinaten der einzelnen Gitterpunkte
    cs = 0 : 1/N : 1;

    b = zeros((N+1)*(N+1),1);

    // Schleife über alle Gitterpunkte
    for i = 0:N
        for j = 0:N
            // Indexumrechnung
            k = i*(N+1) + j + 1;

            // unterer Rand
            if(i == 0 & cs(j+1) > 0.3 & cs(j+1) < 0.7)
                b(k) = 10;

            // oberer Rand
            elseif(i == N & modulo(j,8) < 2)
                b(k) = 40;

            // linker Rand
            elseif(j == 0 & cs(i+1) > 0.3 & cs(i+1) < 0.7)
                b(k) = 40;

            // rechter Rand
            elseif(j == N & cs(i+1) > 0.3 & cs(i+1) < 0.7 & t > 1)
                b(k) = 0;

            // sonstige Teile der Ränger
            elseif(i == 0 | j == 0 | i == N | j == N)
                b(k) = 20;
            end

            //if(cs(i+1) > 0.5 & cs(i+1) < 0.6 & cs(j+1) > 0.5 & cs(j+1) < 0.6)
            //  f(k) = -10000;
            //end
        end
    end
endfunction
  
// Berechnet die Matrix zum negierten Laplace-Operator.
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
    b = assembleRHS(N,0);
    u = lusolve(A,b);
    heatplot(N,u);
endfunction

// Demoprogramm: instationäre Wärmeverteilung
// Fehler: Sollte eigentlich f, nicht die Randbedingungen, verändern.
function calcEvolution(N)
    A = assembleA(N);

    // Ausgangszustand
    b = assembleRHS(N,0);
    u = lusolve(A,b);
    heatplot(N,u);

    dt = 0.1
    for t = 0:dt:10
        b = assembleRHS(N,t)
        m = speye((N+1)*(N+1),(N+1)*(N+1))-dt*A
        u = lusolve(speye((N+1)*(N+1),(N+1)*(N+1))-dt*A, dt*b + u); // u + dt * (b - A*u);
        heatplot(N,u);
        sleep(50);
    end
endfunction

calcEvolution(30);
