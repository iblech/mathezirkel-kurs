# Einsatzverdopplungsstrategie bei Roulette
#zufall

balance = 100  # Startkapitel
stake   = 1    # Einsatz

# Solange wir nicht mehr als 100 Euro in den Miesen sind, ...
while balance >= stake:
    # ... treffe eine Zufallsauswahl.
    coin = roll(sides=2)

    # Wenn wir verlieren:
    if coin == 1:
        balance = balance - stake
        stake   = 2 * stake
    # Wenn wir gewinnen:
    else:
        balance = balance + stake
        break

# Variablen zurücksetzen, damit sie nicht geplottet werden.
coin, stake = None, None
