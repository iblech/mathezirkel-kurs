# -*- coding: utf-8 -*-
#
# Bei diesem Beispielprogramm steuert man mit den Pfeiltasten ein rotes Quadrat.
#
# Zum Ausführen Python und die Bibliothek pygame installieren. Unter Linux geht das so:
#
#     sudo apt-get install python-pygame
#
# Unter Windows von http://continuum.io/downloads Anaconda herunterladen und
# installieren. Dann fehlt aber noch die pygame-Bibliothek. Bitte schreib mich
# an, wenn du das versuchen willst! Ich helfe gerne! iblech@web.de.

import pygame
import sys
from pygame.locals import *

FPS = 60

pygame.init()
DISPLAYSURF = pygame.display.set_mode((400, 300))
pygame.display.set_caption('Mathe macht Spaß!')

BLACK = (  0,   0,   0)
WHITE = (255, 255, 255)
RED   = (255,   0,   0)
GREEN = (  0, 255,   0)
BLUE  = (  0,   0, 255)

clock = pygame.time.Clock()

posX = 100
posY = 100

while True:
   clock.tick(FPS)
   DISPLAYSURF.fill(WHITE)
   pygame.draw.polygon(DISPLAYSURF, GREEN, ((146, 0), (291, 106), (236, 277)))
   pygame.draw.polygon(DISPLAYSURF, RED, ((posX, posY), (posX+30,posY), (posX+30,posY+30), (posX,posY+30)))

   pressed = pygame.key.get_pressed()
   if pressed[pygame.K_RIGHT]:
            posX = posX + 1
   if pressed[pygame.K_LEFT]:
            posX = posX - 1
   if pressed[pygame.K_UP]:
            posY = posY - 10
   if pressed[pygame.K_DOWN]:
            posY = posY + 10

   for event in pygame.event.get():
       if event.type == QUIT:
          pygame.quit()
          sys.exit()

   pygame.display.update()
