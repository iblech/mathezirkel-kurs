# Wie oft bis zum Dreier-Pasch?
#zufall

letzter, vorletzter, vorvorletzter = None, None, None

while True:
    vorvorletzter = vorletzter
    vorletzter    = letzter
    letzter       = roll()

    if letzter == vorletzter and vorletzter == vorvorletzter:
        break
