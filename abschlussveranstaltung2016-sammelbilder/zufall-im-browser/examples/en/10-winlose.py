# Procentually equal profits or losses
#random

# Inspired from
# http://nautil.us/issue/44/luck/-how-to-build-a-probability-microscope

# Seed capital: 100 dollars
capital = 100

# For 50 times, ...
for i in range(50):
    # ... we'll roll a dice.
    if(roll() % 2 == 0):
        # If heads, we earn a profit of 10%.
        capital *= 1.10
    else:
        # If tails, we lose 10%.
        capital *= 0.90
