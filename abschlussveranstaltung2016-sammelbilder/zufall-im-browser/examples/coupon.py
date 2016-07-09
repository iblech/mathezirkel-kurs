# Wie oft, bis man alle hat?
#zufall

# Bis wir etwas anderes sagen, ...
while True:
    # ... würfeln und würfeln wir immer wieder.
    roll()

    # Haben wir insgesamt sechs verschiedene Augenzahlen gesehen?
    if geseheneAugenzahlen == 6:
        # Ja! Dann hören wir auf.
        break
