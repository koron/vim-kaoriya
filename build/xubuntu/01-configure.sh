#!/bin/sh
# vim:set sts=2 sw=2 tw=0 et:

./configure \
  --with-features=huge \
  --enable-gui=gtk2 \
  --enable-luainterp=dynamic \
  --with-luajit \
  --with-lua-prefix=/opt/luajit \
  --enable-pythoninterp=dynamic \
  --enable-python3interp=dynamic \
  --enable-rubyinterp=dynamic \
  --enable-fail-if-missing
