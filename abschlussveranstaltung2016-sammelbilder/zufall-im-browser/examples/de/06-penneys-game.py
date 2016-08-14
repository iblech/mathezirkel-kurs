# Penneys Spiel
#random

# Zwei Spielerinnen verkünden eine Folge
# von drei oder mehr Münzergebnissen.
# Dann wird wiederholt eine Münze geworfen.
# Es gewinnt die Spielerin, deren Muster
# das erste Mal auftritt.
# 
# Details gibt's in einem der Numberphile-Videos:
# https://www.youtube.com/watch?v=Sa9jLWKrX0c

pattern1 = "110"
pattern2 = "011"

digits = ""  # Protokoll der aufgetretenden Münzwürfe

while True:
    # Münze werfen
    if roll(2) == 1:
        digits = digits + "0"
    else:
        digits = digits + "1"

    # Gewinnerin feststellen
    if digits.endswith(pattern1):
        winner = 1
        break
    elif digits.endswith(pattern2):
        winner = 2
        break
