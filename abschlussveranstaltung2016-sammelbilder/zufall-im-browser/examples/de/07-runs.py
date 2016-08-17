# Runs in Münzwürfen
#random

# Dieser Code zählt die Anzahl Runs bei
# wiederholten Münzwürfen. Etwa liegen bei
# "KKKZZZZZKK" drei Runs vor.
#
# Die Anzahl Runs ist beim Run-Test wichtig.
# Dieser ist ein einfacher statistischer Test,
# der von einem gegebenem Wurfprotokoll versucht,
# die Frage zu beantworten, ob es von einer echten
# Münze stammt.

# Ergebnis des vorherigen Münzwürfs
lastRoll     = None

# Anzahl Runs bisher
numberOfRuns = 0

for i in range(50):
    # Wir werfen eine Münze ...
    newRoll = roll(sides=2)

    # ... und vergleichen das Ergebnis mit dem des
    # letzten Wurfs. Wenn es anders als das vorherige
    # ist, haben wir es mit einem neuen Run zu tun.
    if newRoll != lastRoll:
        lastRoll = newRoll
        numberOfRuns = numberOfRuns + 1

# Variablen zurücksetzen, damit sie nicht geplottet werden
lastRoll = None
newRoll  = None
