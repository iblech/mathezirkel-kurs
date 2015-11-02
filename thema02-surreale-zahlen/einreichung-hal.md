# Kombinatorische Spieltheorie in Haskell

Kombinatorische Spiele sind rundenbasierte Zwei-Personen-Spiele wie Mühle oder
Hackenbush, die keinerlei Zufallselemente enthalten und nicht mit verborgenen
Informationen arbeiten: Alle möglichen Züge sind für beide Spieler erkennbar;
Verlierer ist derjenige, der keinen Zug mehr tätigen kann.

Wie spielt man ein solches Spiel optimal? Diese Fragestellung kann man
mathematisch analysieren. Dabei ordnet man jedem Spielzustand eine gewisse
Zahl, seinen Wert, zu. Je nachdem, ob diese positiv oder negativ ist, besitzt der
eine oder andere Spieler eine Gewinnstrategie.

Die Theorie umfasst ein starkes Kompositionalitätsprinzip: Zerfällt ein Spiel
in zwei voneinander unabhängige Teilpartien, so ist der Gesamtwert gleich der
Summe der Werte der Teilpartien. Die dafür benötigten Zahlen sind allerdings
nicht die uns vertrauten, sondern die in den 70er Jahren von John Conway
vorgestellten surrealen Zahlen. Diese stellen eine elegante Verallgemeinerung
und Neuschöpfung des Zahlkonzepts dar.

Im Vortrag werden wir in die Grundlagen der kombinatorischen Spieltheorie
eintauchen und parallel eine entsprechende Haskell-Bibliothek zum
Experimentieren entwerfen. Weder mathematische Vorkenntnisse noch Erfahrung mit
Haskell werden vorausgesetzt.
