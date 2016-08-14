# Penney's Game
#random

# Two players select sequences of heads
# and tails (of the same length).
# Then a fair coin is repeatedly tossed.
# The player whose pattern appears first wins.
# 
# Details are in one of the Numberphile videos:
# https://www.youtube.com/watch?v=Sa9jLWKrX0c

pattern1 = "110"
pattern2 = "011"

digits = ""  # Protocol of the previous coin tosses

while True:
    # Toss a coin
    if roll(2) == 1:
        digits = digits + "0"
    else:
        digits = digits + "1"

    # Detect winner
    if digits.endswith(pattern1):
        winner = 1
        break
    elif digits.endswith(pattern2):
        winner = 2
        break
