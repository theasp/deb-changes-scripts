#!/bin/bash

#set -x

files=${@:1:$((${#@} - 1))}
dest=${@:${#@}}

if [ -z "$files" -o -z "$dest" ]; then
  echo "Usage: $0 <changes [...]> <dest>" 1>&2
  exit 1
fi

mv -v $(changes-files.sh $files) $dest/
