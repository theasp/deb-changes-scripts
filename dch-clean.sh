#!/bin/bash

DIR=$1
if [[ -z $DIR ]]; then
  echo "Usage: $0 <dir>" 1>&2
  exit 1
fi

declare -A CHANGES
set -e
set -x

cd $DIR
for file in *.changes; do
  pkg=${file%%_*}
  if [[ $pkg ]]; then
    echo $pkg
    CHANGES["$pkg"]+=$(printf "%s " $file);
  fi
done

echo C: $CHANGES[@]

for pkg in "${CHANGES[@]}"; do
  if [[ $(wc -w <<<"$pkg") -gt 1 ]]; then
    declare -A versions=()

    for change in $pkg; do
      v=$(cut -f 2 -d _ <<<"$change")
      
      versions["$v"]=$change
    done

    for v in $(sed -e 's/ /\n/' <<<$pkg \
                 | cut -f 2 -d _  \
                 | dpkg-sort-versions.pl \
                 | head -n -1);
    do
      changes-rm.sh ${versions["$v"]}
    done          
  fi
done
