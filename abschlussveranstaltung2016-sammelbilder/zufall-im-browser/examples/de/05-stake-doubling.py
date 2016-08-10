# Einsatzverdopplungsstrategie
#random

balance = 100  # Startkapital
stake   = 1

# Solange wir noch nicht pleite und noch nicht zufrieden sind, ...
while balance >= stake and balance < 120:
    # ... werfen wir eine Münze.
    coin = roll(sides=2)

    # Wenn wir verlieren:
    if coin == 1:
        balance = balance - stake
        stake   = 2 * stake
    # Wenn wir gewinnen:
    else:
        balance = balance + stake
        stake = 1

# Variablen zurücksetzen, damit sie nicht geplottet werden.
coin, stake = None, None
