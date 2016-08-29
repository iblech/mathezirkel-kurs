#!/usr/bin/python
# ========================================================
# Python script for PiBot-A: obstacle avoidance
# Version 0.9 - by Thomas Schoch - www.retas.de
# ========================================================

from pololu_drv8835_rpi import motors, MAX_SPEED
from time import sleep
import wiringpi2 as wp2

# Signal handler for SIGTERM
import signal, sys
def sigterm_handler(signal, frame):
    motors.setSpeeds(0, 0)
    sys.exit(0) 
signal.signal(signal.SIGTERM, sigterm_handler)

def forward(dt):
  motors.setSpeeds(MAX_SPEED, MAX_SPEED)
  sleep(dt)

def left(dt):
  motors.setSpeeds(MAX_SPEED, 0)
  sleep(dt)

def right(dt):
  motors.setSpeeds(0, MAX_SPEED)
  sleep(dt)

try:
	while True:
		forward(1)
		left(0.53)
		forward(1)
		left(0.53)
		forward(1)
		left(0.53)
		forward(1)
		left(0.53)
		forward(1)
		left(0.53)
finally:
    	motors.setSpeeds(0, 0)
