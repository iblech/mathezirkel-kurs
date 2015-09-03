#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Ausführen auf: https://trinket.io/ oder http://www.skulpt.org/

from turtle import *

speed(0)

def koch(size):
    if size <= 10:
        forward(size)
    else:
        koch(size/3)
        left(60)
        koch(size/3)
        right(120)
        koch(size/3)
        left(60)
        koch(size/3)

def flake(size):
    koch(size)
    right(120)
    koch(size)
    right(120)
    koch(size)
    right(120)

flake(200)
