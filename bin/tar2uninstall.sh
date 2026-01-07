#!/bin/bash
#
# Generate an uninstall script from the tar file
#
# USAGE: ./tar2uninstall.sh {TARFILE}

set -eu

tarfile=$1

uninstall_list() {
  echo "#!/bin/sh"
  dirs=()
  while read line ; do
    if [[ ${#dirs[@]} > 0 ]] ; then
      taildir=${dirs[-1]}
      if [[ ! "$line" == "$taildir"* ]] ; then
        dirs=( "${dirs[@]:0:${#dirs[@]}-1}" )
        echo "rm -d \"$taildir\""
      fi
    fi
    if [[ "$line" == */ ]] ; then
      dirs+=($line)
    else
      echo "rm \"$line\""
    fi
  done

  while (( ${#dirs[@]} > 0 )) ; do
    dir=${dirs[-1]}
    dirs=( "${dirs[@]:0:${#dirs[@]}-1}" )
    if [[ "$dir" != "./" ]] then
      echo "rm -d \"$dir\""
    fi
  done
}

tar tf "$tarfile" | uninstall_list
