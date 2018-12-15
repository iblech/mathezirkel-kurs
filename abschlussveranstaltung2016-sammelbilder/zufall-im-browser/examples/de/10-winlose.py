# Prozentual gleich viel Gewinn oder Verlust
#random

# Zum Artikel
# http://nautil.us/issue/44/luck/-how-to-build-a-probability-microscope

# Ausgangskapital: 100 Euro
capital = 100

# Fünfzig Mal ...
for i in range(50):
    # ... eine Münze werfen.
    if(roll() % 2 == 0):
        # Zeigt sie Kopf, so machen wir 10% Gewinn:
        capital *= 1.10
    else:
        # Zeigt sie Zahl, so machen wir 10% Verlust:
        capital *= 0.90
