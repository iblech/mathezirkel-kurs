#!/bin/bash

HOST="$1"
PORT=1234

while :; do
  read -n 1
  echo -n "$REPLY" > "/dev/udp/$HOST/$PORT"
done
