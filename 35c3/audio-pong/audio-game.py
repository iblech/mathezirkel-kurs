#!/usr/bin/python3
# Copyright (C) 2018 Matthias Hutzler, Hendrik Oenings
# License: GNU GPL version 3 or newer

import pygame
import pyaudio
import audioop
import random
import math

# audio input parameters
CHUNK = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 44100

# setup pygame

width = 1366
height = 768
screen = pygame.display.set_mode((width, height))

w = width * 0.0225  # rectangle width
h = height * 0.2    # rectangle height

# setup pyaudio

p = pyaudio.PyAudio()

stream = p.open(format=FORMAT,
                channels=CHANNELS,
                rate=RATE,
                input=True,
                frames_per_buffer=CHUNK)

volume = 0
y = 0
rad = 15
acc = 1.15
ballx = width/2
bally = height/2
vx = 0
vy = 0

nomvx = 3
factvy = 2.4
maxvy = 5
startvy = 0.9

vollower = 2000
volupper = 15000
factvol = 1.1
factmisc = 1.25
sumrad = 3

pygame.font.init()
font = pygame.font.SysFont("open-sans", 24)
fixf = pygame.font.SysFont("courier", 18)

textwidth = width/2 - 100
texttitle = font.render("Audio-Pong", True, (0, 0, 255));
#texttitle = font.render("Audio-Pong - Version 0.1", True, (0, 0, 255));
textsubtitle = font.render("Copyright (C) 2018 Matthias Hutzler, Hendrik Oenings", True, (0, 0, 255));

def render():
    global textblwidth
    global textblheight
    global textradius
    global textvollower
    global textvolcurrent
    global textvolupper
    textblwidth    = fixf.render("[T|G] BLW: "      + str(round(w)),        True, (0, 100, 100))
    textblheight   = fixf.render("[R|F] BLH: "      + str(round(h)),        True, (0, 100, 100))
    textradius     = fixf.render("[E|D] RAD: "      + str(round(rad)),      True, (0, 0, 100))
    textvollower   = fixf.render("[Q|A] VOL-LOW: "  + str(round(vollower)), True, (0, 0, 0))
    textvolcurrent = fixf.render("[===] VOL-CUR: "  + str(round(volume)),   True, (0, 100, 0))
    textvolupper   = fixf.render("[W|S] VOL-HIGH: " + str(round(volupper)), True, (0, 0, 0))

quit = False
dorender = True
dodebug = False
while not quit:
    # current volume
    data = stream.read(CHUNK, exception_on_overflow = False)
    volume = audioop.rms(data, 2)

    yy = 1 - (volume-vollower)/(volupper-vollower)
    if yy < 0:
        yy = 0
    if yy > 1:
        yy = 1
    y += 0.1*(yy-y)

    # handle events
    for e in pygame.event.get():
        if e.type == pygame.QUIT:
            quit = True
        if e.type == pygame.KEYDOWN:
            if e.key == pygame.K_ESCAPE:
                quit = True
            if e.key == pygame.K_SPACE:
                vx = (int(random.random()) * 2 - 1) * nomvx
                vy = (random.random() - 0.5) * 2 * startvy
            if e.key == pygame.K_q:
                vollower *= factvol
            if e.key == pygame.K_a:
                vollower /= factvol
            if e.key == pygame.K_w:
                volupper *= factvol
            if e.key == pygame.K_s:
                volupper /= factvol
            if e.key == pygame.K_e:
                rad += sumrad
            if e.key == pygame.K_d:
                rad -= sumrad
            if e.key == pygame.K_r:
                h *= factmisc
            if e.key == pygame.K_f:
                h /= factmisc
            if e.key == pygame.K_t:
                w *= factmisc
            if e.key == pygame.K_g:
                w /= factmisc
            if e.key == pygame.K_F12:
                dorender = not dorender
            if e.key == pygame.K_F5:
                dodebug = not dodebug

    # draw
    ystart = int(y*(height-h))
    ballx += vx
    bally += vy
    if vy > maxvy:
        vy = maxvy
    if vy < -maxvy:
        vy = -maxvy

    if ballx < w + rad or ballx >= width - w - rad:
        if bally >= ystart and bally < (ystart + h):
            vx *= -1
            vy += (random.random() - 0.5) * factvy
            vx *= acc
        else:
            ballx = width/2
            bally = height/2
            vx = 0
            vy = 0

    if bally < rad or bally >= height - rad:
        vy *= -1

    screen.fill((255, 255, 255))

    if dorender:
        screen.blit(texttitle,    ((width - texttitle.get_width()) / 2, 10 + texttitle.get_height() / 2))
        #screen.blit(textsubtitle, ((width - textsubtitle.get_width()) / 2, 20 + textsubtitle.get_height() * 3 / 2))

        if dodebug:
            render()
            print(vollower, " v--^ ", volupper)
            screen.blit(textblwidth,    (textwidth, height - 60 - textblwidth.get_height()    * 13 / 2))
            screen.blit(textblheight,   (textwidth, height - 50 - textblheight.get_height()   * 11 / 2))
            screen.blit(textradius,     (textwidth, height - 40 - textradius.get_height()     *  9 / 2))
            screen.blit(textvolupper,   (textwidth, height - 30 - textvolupper.get_height()   *  7 / 2))
            screen.blit(textvolcurrent, (textwidth, height - 20 - textvolcurrent.get_height() *  5 / 2))
            screen.blit(textvollower,   (textwidth, height - 10 - textvollower.get_height()   *  3 / 2))

    rect = (0, ystart, w, h)
    pygame.draw.rect(screen, (255, 0, 0), rect)
    rect = (width-w, ystart, w, h)
    pygame.draw.rect(screen, (255, 0, 0), rect)

    pos = (int(ballx), int(bally))
    pygame.draw.circle(screen, (100, 0, 0), pos, rad)

    pygame.display.update()
