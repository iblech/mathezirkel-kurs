#!/usr/bin/env bash

num_rows=$1
num_cols=$2

dir=$(mktemp -d)

echo $dir

for i in $(seq 2 $num_rows); do
  xterm -e "./demo.pl $num_rows $num_cols $i $num_cols 2>$dir/stats-$i-$num_cols.txt" &
done

while :; do
  sleep 1
  {
    {
      for i in $(seq 2 $num_rows); do
        tail -n1 $dir/stats-$i-$num_cols.txt || continue 1
      done

      enum=1 ./demo.pl 1 $num_cols
    } | tr '\n' '*'
    echo
  } | bc -l
done
