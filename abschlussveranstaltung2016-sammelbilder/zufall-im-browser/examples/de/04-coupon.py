# Wie oft, bis man alle hat?
#random

seenNumbers = {}

# Bis wir etwas anderes sagen, ...
while True:
    # ... würfeln und würfeln wir immer wieder
    # und notieren die auftretenden Augenzahlen.
    seenNumbers[roll()] = True

    # Haben wir insgesamt sechs verschiedene Augenzahlen gesehen?
    if len(seenNumbers) == 6:
        # Ja! Dann hören wir auf.
        break
