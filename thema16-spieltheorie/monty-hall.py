#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import random

numDoors       = 3
shouldSwitch   = False
numSimulations = 1000

numWins        = 0

# Liste der Türen -- also insgesamt numDoors viele Zahlen
doors = range(0,numDoors)

for i in range(numSimulations):
    # Tür, hinter der sich das Auto befindet -- natürlich unbekannt für den
    # Kandidaten
    carDoor = random.choice(doors)

    # Tür, die der Kandidat zu Beginn auswählt
    selectedDoor = random.choice(doors)

    # Liste der Türen, unter denen der Moderator eine auswählen und öffnen wird
    showableDoors = [ x for x in doors if x != carDoor and x != selectedDoor ]
    # Vom Moderator ausgewählte Tür
    uncoveredDoor = random.choice(showableDoors)

    print "Auto: %d, ausgewählt: %d, gezeigt: %d" % (carDoor, selectedDoor, uncoveredDoor)

    if shouldSwitch:
        # Liste der Türen, die zur neuen Auswahl stehen
        choosableDoors = [ x for x in doors if x != selectedDoor and x != uncoveredDoor ]
        selectedDoor = random.choice(choosableDoors)

    # Zähler hochsetzen
    if selectedDoor == carDoor:
        numWins = numWins + 1

print "*** Von %d Spielen insgesamt %d gewonnen, %.1f %%." % \
    (numSimulations, numWins, numWins / numSimulations * 100)
