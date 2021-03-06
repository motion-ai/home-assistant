#!/bin/bash

# make a PNG file of a certain color and size and name it
function png.make()
{
  local color=${1:-ff0000}
  local name=${2:-$(mktemp)}
  local size=${3:-256x256}

  convert -size ${size} xc:\#${color} ${name}.png && echo "${name}.png"
}

# convert PNG into 2x2 transparent/non-transparent mask
function png.dots()
{
  local file=${1:-}
  local size=${2:-256x256}
  local out=${file%*.png}-signal.png

  if [ ! -z "${file:-}" ]; then
    convert ${file} \( -size 2x2 xc:black -size 1x1 xc:white -gravity northwest -composite -write mpr:tile +delete -size "${size}" tile:mpr:tile \) -alpha off -compose copy_opacity -composite ${out} && echo "${out}"
  fi
}

###
### MAIN
###

echo $(png.dots $(png.make ${*}))
