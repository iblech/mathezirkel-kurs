#!/usr/bin/env bash

dir="$(mktemp -d)"

function cleanup {
    rm -r -- "$dir"
}

trap cleanup exit

gifsicle --unoptimize -- | convert -- - "$dir/frame-%03d.png"

avconv -i "$dir/frame-%03d.png" -vcodec copy -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "$dir/output.mp4"
cat -- "$dir/output.mp4"
