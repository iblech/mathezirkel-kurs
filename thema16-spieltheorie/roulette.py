#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import random

numWins        = 0
numExperiments = 1000

for i in xrange(numExperiments):
    balance = 0  # Gesamtbilanz
    stake   = 1  # Einsatz

    # Solange wir nicht mehr als 100 Euro in den Miesen sind, ...
    while balance >= -100:
        # ... treffe eine Zufallsauswahl.
        G = random.choice([1,2])

        # Wenn wir verlieren:
        if G == 1:
            balance = balance - stake
            stake   = 2 * stake
        # Wenn wir gewinnen:
        else:
            balance = balance + stake
            numWins = numWins + 1
            break

print numWins / numExperiments

# Viele Varationen der Strategie sind denkbar. Zum Beispiel: Sobald der
# Gewinnfall eingetreten ist, wieder mit dem initialen Einsatz von nur einem
# Euro weiterspielen. Abbrechen, sobald man zu große Verluste gemacht hat oder
# mit seinem Gewinn zufrieden ist.
