# 100 Gefangene (Lösung mit mehreren Zählerinnen)
#random

import math

n    = 8      # Anzahl Gefangener

bulb = False  # Zustand der Glühbirne

mem  = [ 1 for i in range(n) ]

def P(k):
    t = int(math.log(n) / math.log(2) * (n * math.log(n) + n * math.log(math.log(n))))
    m = (k % t) / (n * math.log(n) + n * math.log(math.log(n)))
    return 2**int(m)

while True:
    randomPrisoner = roll(sides=n) - 1
    k              = __numberOfRolls
    
    if bulb:
        mem[randomPrisoner] += P(k-1)
        bulb = False
    
    if mem[randomPrisoner] >= n:
        break
    
    if mem[randomPrisoner] & P(k):
        bulb = True
        mem[randomPrisoner] -= P(k)

