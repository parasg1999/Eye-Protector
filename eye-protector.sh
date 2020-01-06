#! /bin/bash

# This is a shell script for pomodoro technique

# Constants
VERSION=1.0

# Variables
# Default timers in minutes
workTimer=25
restTimer=5
work=1
startTimer=0
currTimer=0
min_brightness=0.6
max_brightness=1
brightness=1

function help() {
# Here-text  
cat << EOF

Usage:
eye-protector.sh [options]

Help Options:
-h  , --help                    Show this help menu

Application Options:
-wt , --worktimer               Specify the time(in minutes) for work (default $workTimer minutes). 
-rt , --resttimer               Specify the time(in minutes) for rest (default $restTimer minutes).
-v  , --version                 Version of the package.
-rb , --restore-brightness      If you exit the process before work timer starts, use this option to reset the brightness to default.
-mb , --min-brightness          Set the brightness that you want during the rest. Possible values between 0 and 0.5.
-mbf, --min-brightness-force    Set the brightness that you want during the rest. For advanced users only.

EOF
}

function getTime() {
  temp=$(date +%s)
  echo $temp
}

function delay() {
  while [[ $( getTime ) -lt $currTimer ]]; do
    true
  done
  work=$((1-work))
  startTimer=$(getTime)
  getTime
}

# Notification to start work
function notif_work_time() {
  notify-send --urgency=critical -t 0 "Pomodoro" "Let's get back to work!"  
}

# Notification to start rest
function notif_rest_time() {
  notify-send --urgency=critical -t 0 "Pomodoro" "Time to relax for a bit!"
}

function brightness_util() {
  screen_name=$(xrandr | grep " connected" | cut -f1 -d " ")
  xrandr --output "${screen_name}" --brightness "${brightness}"
}

function runClock() {
  while true; do
    if ((work)); then
      let "currTimer = $startTimer + $workTimer * 2"
      delay
      brightness=$min_brightness
      notif_rest_time
    else
      let "currTimer = $startTimer + $restTimer * 2"
      delay
      brightness=$max_brightness
      notif_work_time
    fi
    brightness_util
  done
}

function main() {    

  startTimer=$( getTime )

  # if [ $# -eq 0 ]; then
  #   runClock
  # fi

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        help
        exit 0
        ;;
      -v|--version)
        echo $VERSION
        exit 0
        ;;
      -rb|--restore-brightness)
	brightness=1
	brightness_util
	echo -e "Brightness set to default (Try completing your rest next time) \e[31m;)\e[0m"
	exit 0
	;;
      -mb|--min-brightness)
	shift
	if [ $1 -lt 0.5 ]; then
	  echo "Use -mbf flag to set the brightness this low."
	  exit 0
	fi
	min_brightness=$1
	;;
      -mbf|--min-brightness-force)
	shift
	min_brightness=$1
	;;
      -wt|--worktimer)
        shift
        workTimer=$1
        ;;
      -rt|--resttimer)
        shift
        restTimer=$1
        ;;
      *)
        echo $1
        echo 'Invalid usage...'
        exit 1
        ;;
    esac
    shift
  done

  runClock
}

main "$@"
