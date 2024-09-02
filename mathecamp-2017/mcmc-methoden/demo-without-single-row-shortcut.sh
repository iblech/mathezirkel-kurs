#!/usr/bin/env bash

num_rows=$1
num_cols=$2

dir=$(mktemp -d)

echo $dir

for i in $(seq 1 $num_rows); do
  xterm -e "./demo.pl $num_rows $num_cols $i $num_cols 2>$dir/stats-$i-$num_cols.txt" &
done

for j in $(seq 1 $(($num_cols-1))); do
  xterm -e "./demo.pl $num_rows $num_cols 1 $j 2>$dir/stats-1-$j.txt" &
done

while :; do
  sleep 1
  {
    {
      for i in $(seq 1 $num_rows); do
        tail -n1 $dir/stats-$i-$num_cols.txt || continue 1
      done

      for j in $(seq 2 $(($num_cols-1))); do
        tail -n1 $dir/stats-1-$j.txt || continue 1
      done

      echo -n 2
    } | tr '\n' '*'
    echo
  } | bc -l
done
