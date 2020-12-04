#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pygame
from pygame.locals import *
import sys

pygame.init()
screen = pygame.display.set_mode((800, 600))
clock  = pygame.time.Clock()
pygame.display.set_caption("Yeah, mein eigenes Videospiel")

screen.fill((255,255,255))
pygame.draw.rect(screen, (0,0,0),   (0, 200, 800, 10), 0)
pygame.display.update()

while True:
    clock.tick(20)

    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()

    pressed = pygame.key.get_pressed()
    if pressed[pygame.K_RIGHT]:
        print("Rechtstaste gedrückt!")
    elif pressed[pygame.K_LEFT]:
        print("Linkstaste gedrückt!")
