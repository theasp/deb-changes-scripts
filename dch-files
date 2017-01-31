#!/bin/bash

for changesFile in "$@"; do
  dir=$(dirname $changesFile)

  grep-dctrl . -n -s Files $changesFile | while read line; do
    if [ "$line" != "" ]; then
      file=$dir/$(echo $line | awk '{ print $5 }')
      test -e $file && echo $file
    fi
  done
  echo $changesFile
done
