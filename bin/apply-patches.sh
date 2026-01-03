#!/bin/sh

set -eu

cat ../patches/master/series | while read line ; do
  echo "Applying patch: ${line}"
  patch -p1 < "../patches/master/${line}"
done
