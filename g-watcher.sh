#!/bin/bash

usage() {
	echo "bash g-watcher.sh <-d DIRECTORY> <-b BINARY> <-m MAKEFILE_DIRECTORY> [-h]"
	exit 0
}

SKIP=0
DIR=""
BINARY=""
MAKE=""

while getopts "m::hb:d:" opt; do
  case $opt in
    m)
      MAKE=${OPTARG}
      ;;
    b)
      BINARY=${OPTARG}
      ;;
    d)
      DIR=${OPTARG}
      ;;
    h)
      usage
      ;;
    *)
      usage
    ;;
  esac
done

if [ -z "${DIR}" ] || [ -z "${BINARY}" ] || [ -z "${MAKE}" ]; then
  usage
fi

echo "Watching directory ${DIR}..."
inotifywait --exclude '.*\.swp|.*\.o|.*~' --event MODIFY -q -m -r ${DIR} | while read 
do 
  if (( $SKIP > 0 )); then
    SKIP=1
    continue; 
  fi
	
  make -j8 -C ${MAKE}
  if (( $? > 0 )); then
    notify-send 'Build failed'
    continue
  fi
  echo "Build succeeded"
  echo "Running ${BINARY}"
  $BINARY
  if (( $? > 0 )); then
    notify-send 'Test failed'
    continue
  fi
  echo "Test succeeded"
	
  SKIP=0
done
