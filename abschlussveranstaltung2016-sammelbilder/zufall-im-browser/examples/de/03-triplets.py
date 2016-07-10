# Wie oft bis zum Dreier-Pasch?
#random

letzter, vorletzter, vorvorletzter = None, None, None

while True:
    vorvorletzter = vorletzter
    vorletzter    = letzter
    letzter       = roll()

    if letzter == vorletzter and vorletzter == vorvorletzter:
        break

# Variablen zurücksetzen, damit sie nicht geplottet werden
letzter, vorletzter, vorvorletzter = None, None, None
