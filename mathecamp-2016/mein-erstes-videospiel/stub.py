#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import numpy as np
import pygame
from pygame.locals import *
import sys

#####################################################################
# Hier die Zustandsvariablen initialisieren: Position und Geschwindigkeit
# des Spielers
#####################################################################

pos = np.array([0.0, 100.0])
vel = np.array([0.0, 0.0])


#####################################################################
# Hier den Code schreiben, um die simulierte Zeit um dt Sekunden
# weiterlaufen zu lassen
#####################################################################
def runPhysics(dt):
    global pos, vel

    # Erdbeschleunigung
    vel[1] = vel[1] - 9.81 * dt

    # Auf dem Boden angekommen? Dann abprallen
    if pos[1] - 50 <= 0 and vel[1] <= 0:
        vel[1] = -vel[1]

    pos    = pos + dt * vel


#####################################################################
# Hier den Code schreiben, um den Spieler und das Level zu zeichnen
#####################################################################
def drawScene():
    # Umrechnung von internen (x,y)-Koordinaten in Pixelkoordinaten:
    # Pixel-x-Koordinate = x-Koordinate + 200
    # Pixel-y-Koordinate = 200 - y-Koordinate
    pygame.draw.rect(screen, (255,0,0), (pos[0] + 200, 200 - pos[1], 50, 50), 0)
    pygame.draw.rect(screen, (0,0,0),   (0, 200, 800, 10), 0)


#####################################################################
# Initialisierung der PyGame-Bibliothek
#####################################################################
pygame.init()
screen = pygame.display.set_mode((800, 600))
clock  = pygame.time.Clock()
pygame.display.set_caption("Yeah, mein eigenes Videospiel")

speedup       = 2      # Zeitrafferfaktor
dt            = 0.2    # Zeitschrittgröße der Physik-Engine
userTime      = 0      # Realzeit seit Programmbeginn (in Sekunden)
simulatedTime = 0      # Simulierte Zeit seit Programmbeginn (in Sekunden)
FPS           = 20     # Frames pro Sekunde


#####################################################################
# Die Hauptschleife des Programms (hier muss zunächst nichts gemacht
# werden)
#####################################################################
while True:
    userTime = userTime + clock.tick(FPS) * speedup / 1000

    # Physik-Engine so oft aufrufen, bis die simulierte Zeit die Realzeit
    # eingeholt hat
    while simulatedTime < userTime:
        runPhysics(dt)
        simulatedTime = simulatedTime + dt

    screen.fill((255,255,255))
    drawScene()
    pygame.display.update()

    # Verarbeitung von ausgelösten Events
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()

    # Verarbeitung von gedrückten Tasten
    pressed = pygame.key.get_pressed()
    if pressed[pygame.K_RIGHT]:
        print("Rechtstaste gedrückt!")
        vel[0] = vel[0] + 1
    elif pressed[pygame.K_LEFT]:
        print("Linkstaste gedrückt!")
        vel[0] = vel[0] - 1
