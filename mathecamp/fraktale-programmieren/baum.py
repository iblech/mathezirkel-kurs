#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Ausführen auf: https://trinket.io/ oder http://www.skulpt.org/

from turtle import *

speed(0)

def tree(size):
    if size <= 10:
        forward(size)
        back(size)
    else:
        forward(size/3)
        left(30)
        tree(size*2/3)
        right(30)
        forward(size/6)
        right(25)
        tree(size/2)
        left(25)
        forward(size/3)
        right(25)
        tree(size/2)
        left(25)
        forward(size/6)
        back(size)

left(90)
tree(150)
