#!/bin/bash
SC_LOCATION="/home/${USER}/Pictures/Screenshots"
SC_YEAR=$(date +%Y)
SC_MONTH=$(date +"%m %B")
SC_CURRENT_TIME="$(date +"%d %a %H:%M:%S")"

SC_DIR="${SC_LOCATION}/${SC_YEAR}/${SC_MONTH}"
SC_FILE="${SC_DIR}/${SC_CURRENT_TIME}.png"

mkdir -p "${SC_DIR}"

gnome-screenshot -a -f "${SC_FILE}"
#spectacle -r -b -n -o "${SC_FILE}"
if [ -f "${SC_FILE}" ]; then
  wl-copy < "${SC_FILE}"
  ln -sf "${SC_FILE}" "${SC_LOCATION}/latest.png"
fi
