#random

N = 4

xs = [0] * N
ys = [0] * N

xs[roll(N) - 1] = 1

for a in range(0, 2*N):
    for i in range(max(0,a-N+1), min(N,a+1)):
        j = a - i
        if roll(2) == 1:
            xs[i], ys[j] = ys[j], xs[i]

loc = (xs + ys).index(1)
