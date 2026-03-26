#!/usr/bin/bash

set -eu

TESTDIR=./vim/src/testdir

total=$(ls -1 $TESTDIR/test_*.vim $TESTDIR/test*.in | wc -l)

last=0
while true ; do
  count=$(ls -1 $TESTDIR/test_*.res $TESTDIR/test*.out | wc -l)
  if [[ $last != $count ]] ; then
    echo $(date +%H:%M:%S) $count/$total
    last=$count
  fi
  sleep 5
done
