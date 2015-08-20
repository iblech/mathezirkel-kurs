set grid
set style histogram clustered gap 1
set style fill solid border -1

binwidth=0.1
set boxwidth binwidth
bin(x,width)=width*floor(x/width) + binwidth/2.0

plot "<./chisq-test" using (bin($1,binwidth)):(1.0) smooth freq with boxes
