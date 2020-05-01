#!/usr/bin/env bash
set -e

get_display_info() {
  xrandr --verbose | grep -m 1 -w "$1 connected" -A8 | grep "$2" | cut -f2- -d: | tr -d ' '
}

get_brightness() {
  echo "($(get_display_info "$1" 'Brightness: ') * 100 ) / 1" | bc
}

echo $(get_brightness "$1")
