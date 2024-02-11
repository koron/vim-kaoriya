DESTDIR = $(.CURDIR)/work
ROOT_DIR = $(.CURDIR)/../..

.include "$(ROOT_DIR)/VERSION"
VERSION = $(VIM_VER)-$(PATCHSET_VER)

VIM_SRCDIR = $(ROOT_DIR)/vim/src

VIM_CONFIG = --with-features=huge \
	     --enable-gui=no \
	     --enable-fail-if-missing

VIM_DIR = $(DESTDIR)/usr/local/share/vim
VIMRUNTIME_DIR = $(DESTDIR)$(VIM_DIR)/vim$(VIM_VER_SHORT)

OS_TARGET = freebsd14
VIM_PKGFILE = vim$(VIM_VER_SHORT)-kaoriya-$(OS_TARGET)-$(VERSION).tar.bz2

##############################################################################

version:
	@echo ROOT_DIR  = $(ROOT_DIR)
	@echo DESTDIR   = $(DESTDIR)
	@echo VERSION   = $(VERSION)
	@echo OS_TARGET = $(OS_TARGET)

package:
	rm -f $(VIM_PKGFILE)
	tar caf $(VIM_PKGFILE) --uid 0 --gid 0 --strip-components 1 -C $(DESTDIR) .

package-clean:
	rm -rf $(DESTDIR)

package-install-all: vim-install-auto kaoriya-install autofmt-install govim-install

package-auto: package-clean package-install-all package

##############################################################################

vim-patch:
	cd $(VIM_SRCDIR) && guilt pop -a && guilt push -a

vim-patch-reverse:
	cd $(VIM_SRCDIR) && guilt pop -a

vim-configure:
	cd $(VIM_SRCDIR) && ./configure $(VIM_CONFIG)

vim-build:
	cd $(VIM_SRCDIR) && make -j4

vim-install:
	cd $(VIM_SRCDIR) && make DESTDIR=$(DESTDIR) install

vim-clean:
	cd $(VIM_SRCDIR) && make clean

vim-distclean:
	cd $(VIM_SRCDIR) && make distclean

vim-install-auto: vim-patch vim-configure vim-build vim-install vim-distclean vim-patch-reverse

##############################################################################

KAORIYA_SRCDIR = $(ROOT_DIR)/kaoriya
KAORIYA_INSTDIR = $(VIM_DIR)

kaoriya-install:
	@cd $(KAORIYA_SRCDIR)/vim && \
	  for d in `find . -type d -not -name '.*'`; do \
	    echo mkdir: $$d ; \
	    install -d -m 0755 $(KAORIYA_INSTDIR)/$$d || exit 1 ; \
	  done ; \
	  for f in `find . -type f -not -name '.*'`; do \
	    echo install: $$f ; \
	    install -m 0666 $$f $(KAORIYA_INSTDIR)/$$f || exit 1 ; \
	  done

##############################################################################

AUTOFMT_SRCDIR = $(ROOT_DIR)/contrib/autofmt
AUTOFMT_INSTDIR = $(VIM_DIR)/plugins/autofmt

autofmt-install:
	@cd $(AUTOFMT_SRCDIR) && \
	  for d in `find . -type d -not -name '.*'`; do \
	    echo mkdir: $$d ; \
	    install -d -m 0755 $(AUTOFMT_INSTDIR)/$$d || exit 1 ; \
	  done ; \
	  for f in `find . -type f -not -name '.*' `; do \
	    echo install: $$f ; \
	    install -m 0666 $$f $(AUTOFMT_INSTDIR)/$$f || exit 1 ; \
	  done

##############################################################################

GOVIM_SRCDIR = $(ROOT_DIR)/contrib/go-vim
GOVIM_INSTDIR = $(VIM_DIR)/plugins/golang

govim-install:
	@cd $(GOVIM_SRCDIR) && \
	  for d in `find . -type d -not -name '.*'`; do \
	    echo mkdir: $$d ; \
	    install -d -m 0755 $(GOVIM_INSTDIR)/$$d || exit 1 ; \
	  done ; \
	  for f in `find . -type f -not -name '.*' `; do \
	    echo install: $$f ; \
	    install -m 0666 $$f $(GOVIM_INSTDIR)/$$f || exit 1 ; \
	  done
