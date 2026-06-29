CURDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

ROOT_DIR	= $(abspath $(CURDIR)../..)
VIM_DIR		= $(ROOT_DIR)/vim
INSTALL_DIR	= $(abspath $(CURDIR)target/install-x64)

patch-apply:
	cd $(ROOT_DIR)/vim && guilt push -a

patch-revert:
	cd $(ROOT_DIR)/vim && guilt pop -a

build:
	./bin/make-vim

test:
	./bin/test-vim

test-clean:
	./bin/test-vim clean

clean:
	./bin/make-vim clean

zip:
	./bin/build-zip

package-auto:
	$(MAKE) clean test-clean patch-apply build test patch-revert zip

install-daily:
	./bin/install-vim /d/Vim/daily

install:
	./bin/install-vim /d/Vim

upload:
	./bin/upload-files

release: package-auto install-daily upload

##############################################################################

contrib-build: iconv-build gettext-build xpm-build luajit-build

contrib-install: iconv-install gettext-install xpm-install luajit-install

contrib-clean: iconv-clean gettext-clean xpm-clean luajit-clean

##############################################################################
# contrib/libiconv2

LIBICONV_DIR = $(ROOT_DIR)/contrib/libiconv2/msvc10

iconv-build:
	cd "$(LIBICONV_DIR)" && nmake -NOLOGO NODEBUG=1

iconv-install: iconv-build
	mkdir -p "$(INSTALL_DIR)/bin"
	mkdir -p "$(INSTALL_DIR)/include"
	mkdir -p "$(INSTALL_DIR)/lib"
	@cp -vu "$(LIBICONV_DIR)/iconv.dll" \
		"$(LIBICONV_DIR)/iconv_no_i18n.exe" \
		"$(INSTALL_DIR)/bin"
	@cp -vu "$(LIBICONV_DIR)/iconv.h" "$(INSTALL_DIR)/include"
	@cp -vu "$(LIBICONV_DIR)/iconv.lib" "$(INSTALL_DIR)/lib"

iconv-clean:
	cd "$(LIBICONV_DIR)" && nmake -NOLOGO NODEBUG=1 clean

##############################################################################
# contrib/gettext

GETTEXT_DIR = $(ROOT_DIR)/contrib/gettext

gettext-build:
	cd "$(GETTEXT_DIR)" && \
		nmake -NOLOGO -f Makefile.msvc DLL=1 \
		PREFIX="$$(cygpath -w "$(INSTALL_DIR)")"

gettext-install: gettext-build
	cd "$(GETTEXT_DIR)" && \
		nmake -NOLOGO -f Makefile.msvc DLL=1 \
		PREFIX="$$(cygpath -w "$(INSTALL_DIR)")" install

gettext-clean:
	cd "$(GETTEXT_DIR)" && \
		nmake -NOLOGO -f Makefile.msvc DLL=1 \
		PREFIX="$$(cygpath -w "$(INSTALL_DIR)")" clean

##############################################################################
# contrib/libXpm-win32

XPM_DIR = $(ROOT_DIR)/contrib/libXpm-win32/src

xpm-build:
	cd "$(XPM_DIR)" && nmake -NOLOGO -f Make_msvc_lib.mak NODEBUG=1

xpm-install: xpm-build
	mkdir -p "$(INSTALL_DIR)/include"
	mkdir -p "$(INSTALL_DIR)/lib-vc14"
	@cp -vu "$(XPM_DIR)/../include/X11/xpm.h" \
		"$(XPM_DIR)/simx.h" \
		"$(INSTALL_DIR)/include"
	@cp -vu "$(XPM_DIR)/libXpm.lib" "$(INSTALL_DIR)/lib-vc14"

xpm-clean:
	cd "$(XPM_DIR)" && nmake -NOLOGO -f Make_msvc_lib.mak NODEBUG=1 \
		clean

##############################################################################
# contrib/luajit-2.0

LUAJIT_DIR = $(ROOT_DIR)/contrib/luajit-2.0

luajit-build: $(LUAJIT_DIR)/src/luajit.exe

$(LUAJIT_DIR)/src/luajit.exe: $(LUAJIT_DIR)/src/msvcbuild.bat $(LUAJIT_DIR)/src/*.c $(LUAJIT_DIR)/src/*.h
	cd "$(LUAJIT_DIR)/src" && cmd //C msvcbuild.bat

luajit-install:
	mkdir -p "$(INSTALL_DIR)/include/lua"
	mkdir -p "$(INSTALL_DIR)/bin"
	mkdir -p "$(INSTALL_DIR)/lib"
	@cp -vu "$(LUAJIT_DIR)/src/lauxlib.h" \
		"$(LUAJIT_DIR)/src/lua.h" \
		"$(LUAJIT_DIR)/src/lua.hpp" \
		"$(LUAJIT_DIR)/src/luaconf.h" \
		"$(LUAJIT_DIR)/src/lualib.h" \
		"$(INSTALL_DIR)/include/lua"
	@cp -vu "$(LUAJIT_DIR)/src/lua51.dll" \
		"$(LUAJIT_DIR)/src/luajit.exe" \
		"$(INSTALL_DIR)/bin"
	@cp -vu "$(LUAJIT_DIR)/src/lua51.lib" "$(INSTALL_DIR)/lib"

luajit-clean:
	-rm -f "$(LUAJIT_DIR)"/src/*.obj
	-rm -f "$(LUAJIT_DIR)"/src/*.lib
	-rm -f "$(LUAJIT_DIR)"/src/*.exp
	-rm -f "$(LUAJIT_DIR)"/src/*.pdb
	-rm -f "$(LUAJIT_DIR)"/src/*.dll
	-rm -f "$(LUAJIT_DIR)"/src/*.exe
	-rm -f "$(LUAJIT_DIR)"/src/*.manifest
