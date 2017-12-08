from math import log
from sys import argv
n = int(argv[1])
p = [0]*(n+1)
p[0] = 1
a = [0]

# Berechne die Pentagonalzahlen
k=1
while a[-1] < n+1:
	a.append( (3*k*k - k)/2 )
	a.append( (3*k*k + k)/2 )
	k += 1

# Nutze die Rekursion des eulerschen Pentagonalsatzes um die Partitionsfunktion zu berechnen
for i in xrange(1,n+1):
	j = 1
	while i - a[j] >= 0:
		if j % 4 == 3 or j % 4 == 0:
			p[i] -= p[i-a[j]]
		else:
			p[i] += p[i-a[j]]
		j += 1

# Gib p(n) und die Anzahl der Stellen von p(n) aus
print 'Die Anzahl der Partitionen von ' + str(argv[1]) + ' ist ' + str(p[-1]) + '.'
print 'Diese Zahl hat ' + str(len(str(p[-1])))+ ' Stellen.'
