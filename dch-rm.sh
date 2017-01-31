#!/bin/bash

set -x

for file in "$@"; do
  changes-files.sh "$file" | xargs -rp rm
done
