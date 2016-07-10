# How long to triplets?
#random

ultimate, penultimate, antepenultimate = None, None, None 

while True:
    antepenultimate = penultimate
    penultimate     = ultimate
    ultimate        = roll()

    if ultimate == penultimate == antepenultimate:
        break

# Reset variables so that they aren't plotted
ultimate, penultimate, antepenultimate = None, None, None 
