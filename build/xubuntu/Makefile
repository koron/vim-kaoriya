ROOT_DIR = ../..

include $(ROOT_DIR)/VERSION

VIM_SRCDIR = $(ROOT_DIR)/vim/src

VIM_CONFIG = --with-features=huge \
	     --enable-gui=gtk2 \
	     --enable-luainterp=dynamic \
	     --with-luajit \
	     --enable-pythoninterp=dynamic \
	     --enable-python3interp=dynamic \
	     --enable-rubyinterp=dynamic \
	     --enable-fail-if-missing

VIM_DIR = /usr/local/share/vim
VIMRUNTIME_DIR = $(VIM_DIR)/vim$(VIM_VER_SHORT)

default: vim-build

install: kaoriya-install autofmt-install govim-install

vim-configure:
	cd $(VIM_SRCDIR) && ./configure $(VIM_CONFIG)

vim-build:
	cd $(VIM_SRCDIR) && make

vim-install:
	cd $(VIM_SRCDIR) && make install

vim-clean:
	cd $(VIM_SRCDIR) && make clean

vim-distclean:
	cd $(VIM_SRCDIR) && make distclean

vim-install-auto: vim-distclean vim-configure vim-build
	cd $(VIM_SRCDIR) && sudo $(MAKE) install

KAORIYA_SRCDIR = $(ROOT_DIR)/kaoriya
KAORIYA_INSTDIR = $(VIM_DIR)

kaoriya-install:
	@cd $(KAORIYA_SRCDIR)/vim && \
	  for f in `find . -type f -not -name '.*'`; do \
	    echo install: $$f ; \
	    install -o root -g root -m 0666 -D $$f $(KAORIYA_INSTDIR)/$$f || exit 1 ; \
	  done

AUTOFMT_SRCDIR = $(ROOT_DIR)/contrib/autofmt
AUTOFMT_INSTDIR = $(VIM_DIR)/plugins/autofmt

autofmt-install:
	@cd $(AUTOFMT_SRCDIR) && \
	  for f in `find . -type f -not -name '.*' `; do \
	    echo install: $$f ; \
	    install -o root -g root -m 0666 -D $$f $(AUTOFMT_INSTDIR)/$$f || exit 1 ; \
	  done

GOVIM_SRCDIR = $(ROOT_DIR)/contrib/go-vim
GOVIM_INSTDIR = $(VIM_DIR)/plugins/golang

govim-install:
	@cd $(GOVIM_SRCDIR) && \
	  for f in `find . -type f -not -name '.*' `; do \
	    echo install: $$f ; \
	    install -o root -g root -m 0666 -D $$f $(GOVIM_INSTDIR)/$$f || exit 1 ; \
	  done
