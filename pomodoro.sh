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

function help() {
# Here-text  
cat << EOF
Usage:
pomodoro.sh [OPTION...]
Help Options:
-h, --help                      Show help options
Application Options:
-w, --worktimer                 Specify the time(in minutes) for work
-r, --resttimer                 Specify the time(in minutes) for rest
-v, --version                   Version of the package.
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

function runClock() {
  while true; do
    if ((work)); then
      let "currTimer = $startTimer + $workTimer "
      delay
      echo "Work"
    else
      let "currTimer = $startTimer + $restTimer "
      delay
	  echo "Rest"
    fi
  done
}

function main() {    

  # notify-send --urgency=critical -t 0 "Title" "Hello World!"  
notify-send --urgency=normal -hint int:transient:1 --expire-time=3 "EYE-PROTECTOR \"ALERT\"" "Avert your damn eyes, NOW" 
  startTimer=$( getTime )

  if [ $# -eq 0 ]; then
    runClock
  fi

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



