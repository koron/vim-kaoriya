#!/bin/sh
# vim:set sts=2 sw=2 tw=0 et:

./configure \
  --prefix=/opt/vim92
  --with-features=huge \
  --enable-gui=gtk3 \
  --enable-imctrl-fcitx5 \
  --enable-luainterp=dynamic \
  --with-luajit \
  --enable-python3interp=dynamic \
  --enable-rubyinterp=dynamic \
  --enable-fail-if-missing
