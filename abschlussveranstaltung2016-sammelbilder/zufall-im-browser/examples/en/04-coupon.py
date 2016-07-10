# How long till every number occured? (Coupon collector's problem)
#random

seenNumbers = {}

# Until we change our mind, ...
while True:
    # ... we roll and record the occuring numbers.
    seenNumbers[roll()] = True

    # Have we seen all six numbers?
    if len(seenNumbers) == 6:
        # Yes! Then we stop.
        break
