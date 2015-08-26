#!/bin/sh
# vim:set sts=2 sw=2 tw=0 et:

initdir=`pwd`
srcdir=$1 ; shift
dstdir=$1 ; shift

check() {
  echo $initdir
  echo $srcdir
  echo $dstdir
}

list_patches() {
  if ! cd "$1" ; then
    exit 1
  fi

  # Get applied patch list (patches).
  if ! hg --color=never qpush -a 2>&1 > /dev/null ; then
    exit 1
  fi
  hg --color=never qapplied
  hg --color=never qpop -a 2>&1 > /dev/null
}

run() {
  patches=`list_patches $srcdir`

  # Collect patches.
  if [ ! -d "$dstdir" ] ; then
    if ! mkdir -p "$dstdir" ; then
      exit 1
    fi
  fi
  rm -f "$dstdir/series"
  for p in $patches ; do
    cp "$srcdir/.hg/patches/$p" "$dstdir"
    echo $p >> "$dstdir/series"
  done
}

run
