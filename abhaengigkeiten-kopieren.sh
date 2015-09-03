#!/bin/bash

perl -i -pwe 's+\.\./zirkelblatt+zirkelblatt+' ./*/*.tex
perl -i -pwe 's+\.\./cover+cover+' ./zirkelblatt*cls

for i in ./*/*.tex; do
  echo "$i"
  (
    cd "`dirname "$i"`"
    cp ../cover.png .
    cp ../zirkelblatt*cls .
  )
done
