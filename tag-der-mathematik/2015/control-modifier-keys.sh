#!/bin/bash

case "$1" in
  enable)
    xmodmap \
      -e "add control = Control_L" \
      -e "add control = Control_R" \
      -e "add mod1 = Alt_L" \
      -e "add mod1 = Meta_L"
    ;;
  disable)
    xmodmap -e "clear control" -e "clear mod1"
    ;;
esac
