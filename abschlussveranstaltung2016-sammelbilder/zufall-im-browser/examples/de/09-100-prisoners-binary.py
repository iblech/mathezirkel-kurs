# 100 Gefangene (einfache Lösung)
#random

n    = 15     # Anzahl Gefangener

seen = 1      # Anzahl Seelen, die die Zählerin gesammelt hat
dropped = {}  # Gedächtnis der Drohnen, ob sie ihre Seele schon
              # abgegeben haben

bulb = False  # Zustand der Glühbirne (an/aus)

while True:
    randomPrisoner = roll(sides=n)
    if randomPrisoner == 1:
        if bulb:
            bulb = False
            seen = seen + 1
        if seen == n:
            break
    else:
        if not bulb and not randomPrisoner in dropped:
            dropped[randomPrisoner] = True
            bulb = True
