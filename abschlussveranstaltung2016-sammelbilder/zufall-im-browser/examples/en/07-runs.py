# Runs in coin tosses
#random

# This code counts the number of runs in
# repeated coin tosses. For instance the
# tosses "HHHTTTTTHH" contain three runs.
#
# The number of runs is the main ingredient
# of the "run test". This is a statistical
# test which tries to detect whether a given
# series of coin tosses was the result of a
# fair coin.

# Result of the previous coin toss
lastRoll     = None

# Number of runs so far
numberOfRuns = 0

for i in range(50):
    # We toss a coin ...
    newRoll = roll(sides=2)

    # ... and compare the result with the previous
    # toss. If it's different, then we're dealing
    # with a new run.
    if newRoll != lastRoll:
        lastRoll = newRoll
        numberOfRuns = numberOfRuns + 1

# Reset variables so they don't get plotted
lastRoll = None
newRoll  = None
