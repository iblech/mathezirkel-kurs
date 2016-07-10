# Stake doubling strategy
#random

balance = 100  # seed money
stake   = 1

# As long as we aren't broke and not yet content, ...
while balance >= stake and balance < 120:
    # ... we toss a coin.
    coin = roll(sides=2)

    # In case we lose:
    if coin == 1:
        balance = balance - stake
        stake   = 2 * stake
    # In case we win:
    else:
        balance = balance + stake
        stake = 1

# Reset variables so that they aren't plotted
coin, stake = None, None
