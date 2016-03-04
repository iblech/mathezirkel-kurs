#!/bin/bash

case "$1" in
  1)
    mplayer 10_Hours_of_Infinite_Fractal_and_Falling_Shepard_s_Tone.low.mp4
    ;;
  2)
    xawtv -c /dev/video0
    ;;
  3)
    animate -geometry +32+97 harry-potter-bus.gif 
    ;;
  4)
    mplayer Forest_Rain_\&_Thunderstorm_Sounds_10_Hours___Sleep_or_Study_to_Rain_Falling_White_Noise_Ambiance.mp3
    ;;
esac
