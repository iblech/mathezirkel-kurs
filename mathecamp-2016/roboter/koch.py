#!/usr/bin/python
# ========================================================

from pololu_drv8835_rpi import motors, MAX_SPEED
from time import sleep
import wiringpi as wp2
global POWER_RIGHT
global POWER_LEFT

POWER_RIGHT = 1
POWER_LEFT = 1

# Signal handler for SIGTERM
import signal, sys
def sigterm_handler(signal, frame):
    motors.setSpeeds(0, 0)
    sys.exit(0) 
signal.signal(signal.SIGTERM, sigterm_handler)

def forward(dt):
  motors.setSpeeds(MAX_SPEED, MAX_SPEED)
  sleep(dt)

# time needed for one full turn (one tau)
ttau = 2.12

def left(phi):
  motors.setSpeeds(0, MAX_SPEED)
  sleep(ttau*phi/360)
def better_left(phi):
  motors.setSpeeds(-MAX_SPEED*POWER_LEFT, MAX_SPEED*POWER_RIGHT)
  sleep(ttau*phi/360*0.5)

def right(phi):
  motors.setSpeeds(MAX_SPEED, 0)
  sleep(ttau*phi/360)
def better_right(phi):
  teildrehung = 10
  for i in range(int(phi/teildrehung)):
    if i % 2 == 0:
      motors.setSpeeds(0,-MAX_SPEED)
    else:
      motors.setSpeeds(MAX_SPEED,0)
    if phi - i*teildrehung >= teildrehung:
      sleep(ttau*teildrehung/360)
    else:
      sleep(phi - i*teildrehung)
  motors.setSpeeds(MAX_SPEED*POWER_LEFT,-MAX_SPEED*POWER_RIGHT)
  sleep(ttau*phi/360*0.5)


def koch(l):
  if l<0.5:
    forward(l)
  else:
    better_curves = False
    koch(l/3.0)
    if better_curves:
      better_left(60)
    else:
      left(60)
    koch(l/3.0)
    if better_curves:
      better_right(120)
    else:
      right(120)
    koch(l/3.0)
    if better_curves:
      better_left(60)
    else:
      left(60)
    koch(l/3.0)
try:
  pass
  #koch(1.5)
finally:
  motors.setSpeeds(0, 0)
for i in range(4):
  forward(1)
  better_right(90)
motors.setSpeeds(0,0)
