#!/usr/bin/env bash

# From https://developers.google.com/speed/docs/insights/OptimizeImages
convert \
    -sampling-factor 4:2:0 \
    -strip \
    -quality 85 \
    -interlace JPEG \
    -colorspace sRGB \
    -resize 128x128 \
    $1 $2
