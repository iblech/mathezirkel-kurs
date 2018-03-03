#!/bin/bash

case "$1" in
  1)
    mplayer 10_Hours_of_Infinite_Fractal_and_Falling_Shepard_s_Tone.low.mp4
    ;;
  2)
    xawtv
    ;;
  3)
    animate -geometry 735x405 harry-potter-bus.gif 
    ;;
  4)
    mplayer -vo null Forest_Rain_\&_Thunderstorm_Sounds_10_Hours___Sleep_or_Study_to_Rain_Falling_White_Noise_Ambiance.mp4
    ;;
esac
