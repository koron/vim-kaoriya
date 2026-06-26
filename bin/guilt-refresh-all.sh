#!/bin/bash
#
# guilt-refresh-all.sh:
#
#     Run with all patches applied (guilt push -a) and refresh --git all
#     patches in reverse order
#
# USAGE: guilt push -a && ../bin/guilt-refresh-all.sh

set -eu

count=0

while true ; do
  curr=$(guilt top)
  if [[ -z "$curr" ]] ; then
    break
  fi
  echo "Refreshing: $curr"
  guilt refresh --git
  count=$((count++))
  guilt pop
done

if [[ $count -eq 0 ]] ; then
  echo "No patches applied"
  exit  1
fi
echo "All ($count) applied patches have been refreshed"
exit 0
