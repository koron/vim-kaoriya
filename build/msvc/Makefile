# vim:set ts=8 sts=8 sw=8 tw=0 noet:

# Switches:
#
#   DISABLE_IF=1	Disable all language interfaces
#     DISABLE_PERL=1	Disalbe Perl interfaces
#     DISABLE_PYTHON=1	Disalbe Python interfaces
#     DISABLE_LUA=1	Disalbe Lua interfaces
#     DISABLE_RUBY=1	Disalbe Ruby interfaces

VIM_VER		= 74-kaoriya-$(WINDOWS_CPUTYPE)
DATE_VER	= %%date:~-10,4%%%%date:~-5,2%%%%date:~-2,2%%

RTDIR_NAME	= vim74

BUILD_DIR	= $(MAKEDIR)
OUTPUT_DIR	= $(MAKEDIR)\target
INSTALL_DIR	= $(OUTPUT_DIR)\install-$(CPUTYPE)
CONTRIB_DIR	= ..\..\contrib
XPM_DIR		= $(CONTRIB_DIR)\libXpm-win32\src
ICONV_DIR	= $(CONTRIB_DIR)\libiconv2\msvc10
GETTEXT_DIR	= $(CONTRIB_DIR)\gettext
VIMPROC_DIR	= $(CONTRIB_DIR)\vimproc
VIMPROC_DLL	= vimproc_$(WINDOWS_CPUTYPE).dll
LUAJIT_DIR	= $(CONTRIB_DIR)\luajit-2.0
VIM_DIR		= ..\..\vim
VIM_INSTALL_DIR	= $(INSTALL_DIR)\share\vim\runtime
VIM_PATCH_DIR	= $(INSTALL_DIR)\share\vim\patch
VIM_DIST_DIR	= $(OUTPUT_DIR)\vim$(VIM_VER)
KAORIYA_DIR	= ..\..\kaoriya
SNAPSHOT_DIR	= $(OUTPUT_DIR)\vim$(VIM_VER)-snapshot

MSVCRT_DIR	= $(VCINSTALLDIR)\redist\$(MSVCRT_CPUTYPE)\$(MSVCRT_SUBDIR)

COPY		= Robocopy /XO

# Check CPU type.
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
CPUTYPE=x64
MSVCRT_CPUTYPE=x64
WINDOWS_CPUTYPE=win64
!ELSE
CPUTYPE=x32
MSVCRT_CPUTYPE=x86
WINDOWS_CPUTYPE=win32
!ENDIF

# Check MSVC version.
!IF "$(_NMAKE_VER)" >= "9." && "$(_NMAKE_VER)" < "@."
MSVC_VERSION=msvc9
MSVCRT_SUBDIR=Microsoft.VC90.CRT
MSVCRT_FILES=msvcr90.dll Microsoft.VC90.CRT.manifest
!ELSEIF "$(_NMAKE_VER)" >= "10." && "$(_NMAKE_VER)" < "11."
MSVC_VERSION=msvc10
MSVCRT_SUBDIR=Microsoft.VC100.CRT
MSVCRT_FILES=msvcr100.dll
!ELSEIF "$(_NMAKE_VER)" >= "11." && "$(_NMAKE_VER)" < "12."
MSVC_VERSION=msvc11
MSVCRT_SUBDIR=Microsoft.VC110.CRT
MSVCRT_FILES=msvcr110.dll
!ELSEIF "$(_NMAKE_VER)" >= "12." && "$(_NMAKE_VER)" < "13."
MSVC_VERSION=msvc12
MSVCRT_SUBDIR=Microsoft.VC120.CRT
MSVCRT_FILES=msvcr120.dll
!ELSEIF "$(_NMAKE_VER)" >= "14." && "$(_NMAKE_VER)" < "15."
MSVC_VERSION=msvc14
MSVCRT_SUBDIR=Microsoft.VC140.CRT
MSVCRT_FILES=vcruntime140.dll
!ELSE
!ERROR Unknown MSVC version: $(_NMAKE_VER)
!ENDIF

archive:
	$(MAKE) archive-pre
	$(MAKE) archive-dist

archive-pre:
	$(MAKE) "$(INSTALL_DIR)\bin\iconv.dll"
	$(MAKE) "$(INSTALL_DIR)\bin\intl.dll"
	$(MAKE) "$(INSTALL_DIR)\bin\$(VIMPROC_DLL)"
	$(MAKE) "$(INSTALL_DIR)\bin\lua51.dll"
	$(MAKE) vim-clean gvim-clean vim-install
	$(MAKE) vim-mo-install vim-patch-install

contrib: $(INSTALL_DIR)\bin\iconv.dll $(INSTALL_DIR)\bin\intl.dll \
	$(INSTALL_DIR)\lib\libXpm.lib \
	$(INSTALL_DIR)\bin\$(VIMPROC_DLL) $(INSTALL_DIR)\bin\lua51.dll

build: iconv-build gettext-build xpm-build vimproc-build luajit-build

install: iconv-install gettext-install xpm-install vimproc-install \
	luajit-install

clean: iconv-clean gettext-clean xpm-clean vimproc-clean luajit-install

distclean: iconv-distclean gettext-distclean xpm-distclean vimproc-distclean \
	luajit-distclean

### ICONV

iconv-build:
	cd "$(ICONV_DIR)"
	nmake NODEBUG=1
	cd "$(BUILD_DIR)"

iconv-install: iconv-build
	-$(COPY) "$(ICONV_DIR)" "$(INSTALL_DIR)\bin" \
		iconv.dll iconv_no_i18n.exe
	-$(COPY) "$(ICONV_DIR)" "$(INSTALL_DIR)\include" \
		iconv.h
	-$(COPY) "$(ICONV_DIR)" "$(INSTALL_DIR)\lib" \
		iconv.lib

iconv-clean:
	cd "$(ICONV_DIR)"
	nmake clean
	cd "$(BUILD_DIR)"

iconv-distclean:
	cd "$(ICONV_DIR)"
	nmake distclean
	cd "$(BUILD_DIR)"

### GETTEXT

gettext-build:
	cd "$(GETTEXT_DIR)"
	nmake /NOLOGO /F Makefile.msvc DLL=1 \
		MFLAGS="-MD -D_BIND_TO_CURRENT_VCLIBS_VERSION=1" \
		PREFIX="$(INSTALL_DIR)"
	cd "$(BUILD_DIR)"

gettext-install: gettext-build
	cd "$(GETTEXT_DIR)"
	nmake /NOLOGO /F Makefile.msvc DLL=1 \
		MFLAGS="-MD -D_BIND_TO_CURRENT_VCLIBS_VERSION=1" \
		PREFIX="$(INSTALL_DIR)" install
	cd "$(BUILD_DIR)"

gettext-clean:
	cd "$(GETTEXT_DIR)"
	nmake /NOLOGO /F Makefile.msvc DLL=1 \
		MFLAGS="-MD -D_BIND_TO_CURRENT_VCLIBS_VERSION=1" \
		PREFIX="$(INSTALL_DIR)" clean
	cd "$(BUILD_DIR)"

gettext-distclean:
	cd "$(GETTEXT_DIR)"
	nmake /NOLOGO /F Makefile.msvc DLL=1 \
		MFLAGS="-MD -D_BIND_TO_CURRENT_VCLIBS_VERSION=1" \
		PREFIX="$(INSTALL_DIR)" distclean
	cd "$(BUILD_DIR)"

### XPM

xpm-build:
	cd "$(XPM_DIR)"
	nmake -f Make_msvc_lib.mak NODEBUG=1
	cd "$(BUILD_DIR)"

xpm-install: xpm-build
	-$(COPY) "$(XPM_DIR)\..\include\X11" "$(INSTALL_DIR)\include" \
		xpm.h
	-$(COPY) "$(XPM_DIR)" "$(INSTALL_DIR)\include" \
		simx.h
	-$(COPY) "$(XPM_DIR)" "$(INSTALL_DIR)\lib" \
		libXpm.lib

xpm-clean:
	cd "$(XPM_DIR)"
	nmake -f Make_msvc_lib.mak clean
	cd "$(BUILD_DIR)"

xpm-distclean:
	cd "$(XPM_DIR)"
	nmake -f Make_msvc_lib.mak clean
	cd "$(BUILD_DIR)"

### VIMPROC

vimproc-build:
	cd "$(VIMPROC_DIR)"
	nmake /F Make_msvc.mak nodebug=1
	cd "$(BUILD_DIR)"

vimproc-install: vimproc-build
	-$(COPY) "$(VIMPROC_DIR)\lib" "$(INSTALL_DIR)\bin" \
		$(VIMPROC_DLL)

vimproc-clean:
	cd "$(VIMPROC_DIR)"
	nmake /F Make_msvc.mak clean
	cd "$(BUILD_DIR)"

vimproc-distclean:
	cd "$(VIMPROC_DIR)"
	nmake /F Make_msvc.mak clean
	cd "$(BUILD_DIR)"

### LuaJIT

luajit-build:
	cd "$(LUAJIT_DIR)\src"
	msvcbuild.bat
	cd "$(BUILD_DIR)"

luajit-install: luajit-build
	-$(COPY) "$(LUAJIT_DIR)\src" "$(INSTALL_DIR)\include\lua" \
		lauxlib.h lua.h lua.hpp luaconf.h lualib.h
	-$(COPY) "$(LUAJIT_DIR)\src" "$(INSTALL_DIR)\bin" \
		lua51.dll luajit.exe
	-$(COPY) "$(LUAJIT_DIR)\src" "$(INSTALL_DIR)\lib" \
		lua51.lib
	-$(COPY) /E "$(LUAJIT_DIR)\src\jit" "$(INSTALL_DIR)\bin\lua\jit" /XF .gitignore

luajit-clean:

luajit-distclean: luajit-clean

### VIM

vim-build:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak
	cd "$(BUILD_DIR)"

vim-clean:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak clean
	cd "$(BUILD_DIR)"

vimd-build:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak DEBUG=yes
	cd "$(BUILD_DIR)"

vimd-clean:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak DEBUG=yes clean
	cd "$(BUILD_DIR)"

gvim-build:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak GUI=yes IME=yes
	cd "$(BUILD_DIR)"

gvim-clean:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak GUI=yes IME=yes clean
	cd "$(BUILD_DIR)"

gvimd-build:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak GUI=yes IME=yes DEBUG=yes
	cd "$(BUILD_DIR)"

gvimd-clean:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak GUI=yes IME=yes DEBUG=yes clean
	cd "$(BUILD_DIR)"

vim-install: vim-build gvim-build
	-$(COPY) "$(VIM_DIR)\src" "$(INSTALL_DIR)\bin" \
		vim.exe gvim.exe vimrun.exe
	-$(COPY) "$(VIM_DIR)\src\xxd" "$(INSTALL_DIR)\bin" xxd.exe

vim-mo-install:
	IF NOT EXIST "$(VIM_INSTALL_DIR)" MD "$(VIM_INSTALL_DIR)"
	cd "$(VIM_DIR)\src\po"
	nmake -f Make_mvc.mak VIMRUNTIME="$(VIM_INSTALL_DIR)" \
		GETTEXT_PATH="$(INSTALL_DIR)\bin" install-all
	cd "$(BUILD_DIR)"

vim-patch-install:
	IF NOT EXIST "$(VIM_PATCH_DIR)" MD "$(VIM_PATCH_DIR)"
	cd "$(VIM_DIR)"
	-DEL /F /Q "$(VIM_PATCH_DIR)\*"
	-$(COPY) "..\patches\master" "$(VIM_PATCH_DIR)" *.diff series
	cd "$(BUILD_DIR)"

### DISTRIBUTION

build-dist:
# Create distribution directories.
	IF NOT EXIST "$(VIM_DIST_DIR)" MKDIR "$(VIM_DIST_DIR)"
	IF NOT EXIST "$(VIM_DIST_DIR)\origdoc" MKDIR "$(VIM_DIST_DIR)\origdoc"
	IF NOT EXIST "$(VIM_DIST_DIR)\patch" MKDIR "$(VIM_DIST_DIR)\patch"
	IF NOT EXIST "$(VIM_DIST_DIR)\plugins" MKDIR "$(VIM_DIST_DIR)\plugins"
	IF NOT EXIST "$(VIM_DIST_DIR)\$(RTDIR_NAME)" MKDIR "$(VIM_DIST_DIR)\$(RTDIR_NAME)"
	IF NOT EXIST "$(VIM_DIST_DIR)\switches" MKDIR "$(VIM_DIST_DIR)\switches"
# KaoriYa specific files.
	-$(COPY) /E "$(KAORIYA_DIR)\doc" "$(VIM_DIST_DIR)"
	-$(COPY) /E "$(KAORIYA_DIR)\vim" "$(VIM_DIST_DIR)"
# Switches.
	IF NOT EXIST "$(VIM_DIST_DIR)\switches\enabled" MKDIR "$(VIM_DIST_DIR)\switches\enabled"
	-DEL /F /Q "$(VIM_DIST_DIR)\switches\enabled\*.vim"
# Plugin - vimdoc-ja
	-$(COPY) /E "$(CONTRIB_DIR)\vimdoc-ja" "$(VIM_DIST_DIR)\plugins\vimdoc-ja" /XD .git /XF .git*
	"$(INSTALL_DIR)\bin\vim.exe" -n -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\plugins\vimdoc-ja\doc | quit"
# Plugin - autofmt
	-$(COPY) /E "$(CONTRIB_DIR)\autofmt" "$(VIM_DIST_DIR)\plugins\autofmt" /XD .git /XF .git*
	"$(INSTALL_DIR)\bin\vim.exe" -n -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\plugins\autofmt\doc | quit"
# Plugin - vimproc
	-$(COPY) /E "$(CONTRIB_DIR)\vimproc\doc" \
		"$(VIM_DIST_DIR)\plugins\vimproc\doc"
	"$(INSTALL_DIR)\bin\vim.exe" -n -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\plugins\vimproc\doc | quit"
	-$(COPY) /E "$(CONTRIB_DIR)\vimproc\plugin" \
		"$(VIM_DIST_DIR)\plugins\vimproc\plugin"
	-$(COPY) /E "$(CONTRIB_DIR)\vimproc\autoload" \
		"$(VIM_DIST_DIR)\plugins\vimproc\autoload" \
		vimproc.vim
	-$(COPY) "$(INSTALL_DIR)\bin" \
		"$(VIM_DIST_DIR)\plugins\vimproc\lib" \
		$(VIMPROC_DLL)
	-$(COPY) /E "$(CONTRIB_DIR)\vimproc\autoload\vimproc" \
		"$(VIM_DIST_DIR)\plugins\vimproc\autoload\vimproc"
# Plugin - golang
	-$(COPY) /E "$(CONTRIB_DIR)\go-vim" "$(VIM_DIST_DIR)\plugins\golang" /XD .git /XF .git*
# Vim and other executable and resource files.
	-$(COPY) "$(VIM_DIR)" "$(VIM_DIST_DIR)\origdoc" README.txt
	-$(COPY) "$(INSTALL_DIR)\bin" "$(VIM_DIST_DIR)" \
		vim.exe gvim.exe vimrun.exe xxd.exe iconv.dll intl.dll \
		luajit.exe lua51.dll
	-$(COPY) /E "$(VIM_DIR)\runtime" "$(VIM_DIST_DIR)\$(RTDIR_NAME)"
	-$(COPY) /E "$(VIM_INSTALL_DIR)" "$(VIM_DIST_DIR)\$(RTDIR_NAME)"
	"$(INSTALL_DIR)\bin\vim.exe" -n -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\$(RTDIR_NAME)\doc | quit"
# Copy MSVC runtime files.
	-$(COPY) "$(MSVCRT_DIR)" "$(VIM_DIST_DIR)" $(MSVCRT_FILES)
# Copy patch (diff) files.
	-$(COPY) /E "$(VIM_PATCH_DIR)" "$(VIM_DIST_DIR)\patch"
# Copy lua related files
	-$(COPY) /E "$(INSTALL_DIR)\bin\lua" "$(VIM_DIST_DIR)\lua"

archive-dist: build-dist
	$(MAKE) zip-dist

zip-dist:
	cd "$(OUTPUT_DIR)"
	zip -r9q vim$(VIM_VER)-$(DATE_VER).zip vim$(VIM_VER)
	cd "$(BUILD_DIR)"

clean-dist:
	-RD /S /Q "$(VIM_DIST_DIR)"

build-release-pre:
	$(MAKE) "$(INSTALL_DIR)\bin\iconv.dll"
	$(MAKE) "$(INSTALL_DIR)\bin\intl.dll"
	$(MAKE) "$(INSTALL_DIR)\lib\libXpm.lib"
	$(MAKE) "$(INSTALL_DIR)\bin\$(VIMPROC_DLL)"
	$(MAKE) "$(INSTALL_DIR)\bin\lua51.dll"
	$(MAKE) vim-clean gvim-clean vim-install
	$(MAKE) vim-mo-install vim-patch-install
	$(MAKE) build-dist

build-release-core:
	$(MAKE) zip-dist


snapshot: snapshot-build snapshot-install snapshot-archive

snapshot-pre: snapshot-install snapshot-archive

snapshot-build:
	$(MAKE) vim-clean vim-build
	$(MAKE) gvim-clean gvim-build

snapshot-install:
	IF NOT EXIST "$(SNAPSHOT_DIR)" MD "$(SNAPSHOT_DIR)"
	-$(COPY) "$(VIM_DIR)\src" "$(SNAPSHOT_DIR)" vim.exe gvim.exe

snapshot-archive:
	cd "$(OUTPUT_DIR)"
	zip -r9q vim$(VIM_VER)-snapshot-$(DATE_VER).zip vim$(VIM_VER)-snapshot
	cd "$(BUILD_DIR)"


.PHONY:	archive archive-pre contrib build install clean distclean \
	iconv-build iconv-install iconv-clean iconv-distclean \
	gettext-build gettext-install gettext-clean gettext-distclean \
	xpm-build xpm-install xpm-clean xpm-distclean \
	vimproc-build vimproc-install vimproc-clean vimproc-distclean \
	luajit-build luajit-install luajit-clean luajit-distclean \
	vim-build vim-clean vimd-build vimd-clean \
	gvim-build gvim-clean gvimd-build gvimd-clean \
	vim-install vim-mo-install vim-patch-install \
	build-dist archive-dist zip-dist clean-dist \
	build-release-pre build-release-core \
	snapshot

"$(INSTALL_DIR)\bin\iconv.dll":
	$(MAKE) iconv-clean iconv-install iconv-distclean

"$(INSTALL_DIR)\bin\intl.dll":
	$(MAKE) gettext-clean gettext-install gettext-distclean

"$(INSTALL_DIR)\lib\libXpm.lib":
	$(MAKE) xpm-clean xpm-install xpm-distclean

"$(INSTALL_DIR)\bin\$(VIMPROC_DLL)":
	$(MAKE) vimproc-clean vimproc-install vimproc-distclean

"$(INSTALL_DIR)\bin\lua51.dll":
	$(MAKE) luajit-install

"$(INSTALL_DIR)\bin\vim.exe":
	$(MAKE) vim-clean gvim-clean vim-install vim-mo-install \
		vim-clean gvim-clean
