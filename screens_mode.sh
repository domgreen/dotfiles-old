#!/bin/bash

LCD=eDP-1
RIGHT_SCREEN=DP-1-2
MIDDLE_SCREEN=DP-1-1

detect_setup_table() {
  local xr_out=$(xrandr --current)
  [[ "${xr_out}" =~ "${MIDDLE_SCREEN} connected" ]] &&  [[ "${xr_out}" =~ "${RIGHT_SCREEN} connected" ]] && echo -n "yes"
  echo -n "no"
}

make_setup_table() {
  echo "Making Setup Table"
  xrandr \
    --output ${LCD} --pos 0x0 --auto --mode 1920x1080
  echo "Left on"
  xrandr \
    --output ${MIDDLE_SCREEN} --pos 1920x0 --auto --primary
  echo "Middle on"
  xrandr \
    --output ${RIGHT_SCREEN} --rotate right --pos 5360x0 --auto
  echo "Right on"
}

detect_setup_detached() {
  local xr_out=$(xrandr --current)
  [[ "${xr_out}" =~ "${MIDDLE_SCREEN} disconnected" ]] &&  [[ "${xr_out}" =~ "${RIGHT_SCREEN} disconnected" ]] && echo -n "yes"
  echo -n "no"
}

make_setup_detached() {
  xrandr \
    --output ${RIGHT_SCREEN} --off \
    --output ${LCD} --pos 0x0 --auto --primary \
    --output ${LEFT_SCREEN} --off \
    --output ${MIDDLE_SCREEN} --off
}

if [[ "$1" == "detached" ]]; then
  echo "Detached setup forced"
  make_setup_detached
  exit 0;
fi

if [[ "$1" == "table" ]]; then
  echo "Table setup forced"
  make_setup_table
fi;


if [[ "$(detect_setup_table)" =~ "yes" ]]; then
  echo "Detected table setup"
  make_setup_table
  exit 0;
fi;

if [[ $(detect_setup_detached) =~ "yes" ]]; then
  echo "Detected detached setup"
  make_setup_detached
  exit 0;
fi;

xfce4-display-settings --minimal
