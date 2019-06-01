# vim:set ts=8 sts=8 sw=8 tw=0 noet:

# Switches:
#
#   DISABLE_IF=1	Disable all language interfaces
#     DISABLE_PERL=1	Disable Perl interfaces
#     DISABLE_PYTHON=1	Disable Python interfaces
#     DISABLE_LUA=1	Disable Lua interfaces
#     DISABLE_RUBY=1	Disable Ruby interfaces

!include ..\..\VERSION

DIST_VER	= $(VIM_VER_SHORT)-kaoriya-$(WINDOWS_CPUTYPE)
DATE_VER	= %%date:~-10,4%%%%date:~-5,2%%%%date:~-2,2%%

RTDIR_NAME	= vim$(VIM_VER_SHORT)

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
LANGJA_DIR	= $(CONTRIB_DIR)\lang-ja
VIM_DIR		= ..\..\vim
VIM_INSTALL_DIR	= $(INSTALL_DIR)\share\vim\runtime
VIM_PATCH_DIR	= $(INSTALL_DIR)\share\vim\patch
VIM_DIST_DIR	= $(OUTPUT_DIR)\vim$(DIST_VER)
KAORIYA_DIR	= ..\..\kaoriya
SNAPSHOT_DIR	= $(OUTPUT_DIR)\vim$(DIST_VER)-snapshot

MSVCRT_DIR	= $(VCINSTALLDIR)\redist\$(MSVCRT_CPUTYPE)\$(MSVCRT_SUBDIR)

COPY		= Robocopy /XO

# Check CPU type.
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
CPUTYPE=x64
MSVCRT_CPUTYPE=x64
WINDOWS_CPUTYPE=win64
VIMDLL_BASE=vim64
!ELSE
CPUTYPE=x32
MSVCRT_CPUTYPE=x86
WINDOWS_CPUTYPE=win32
VIMDLL_BASE=vim32
!ENDIF
VIMDLL=$(VIMDLL_BASE).dll

# Check MSVC version.
!IF "$(_NMAKE_VER)" >= "9." && "$(_NMAKE_VER)" < "@."
MSVC_VERSION=msvc9
MSVCRT_SUBDIR=Microsoft.VC90.CRT
MSVCRT_FILES=msvcr90.dll
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
	$(MAKE) "$(INSTALL_DIR)\bin\winpty-agent.exe"
	$(MAKE) vim-clean vim-install
	$(MAKE) vim-mo-install vim-patch-install
	$(MAKE) langja-install

contrib: $(INSTALL_DIR)\bin\iconv.dll $(INSTALL_DIR)\bin\intl.dll \
	$(INSTALL_DIR)\lib\libXpm.lib \
	$(INSTALL_DIR)\bin\$(VIMPROC_DLL) \
	$(INSTALL_DIR)\bin\lua51.dll \
	$(INSTALL_DIR)\bin\winpty-agent.exe

build: iconv-build gettext-build xpm-build vimproc-build luajit-build

install: iconv-install gettext-install xpm-install vimproc-install \
	luajit-install

clean: iconv-clean gettext-clean xpm-clean vimproc-clean luajit-clean \
	version-clean

distclean: iconv-distclean gettext-distclean xpm-distclean vimproc-distclean \
	luajit-distclean

version: version-interfaces

version-interfaces:
	-@..\..\vim\src\vim.exe -e -s --noplugins -c "source tools/version-interfaces.vim"
	@cat version-interfaces.out
	@rm -f version-interfaces.out

version-clean:
	rm -f version-interfaces.out

rebuild-vim: vim-clean vim-build

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

### rprichard/winpty

WINPTY_VERSION=0.4.3
WINPTY_BASENAME=winpty-$(WINPTY_VERSION)-msvc2015
WINPTY_ZIP=$(WINPTY_BASENAME).zip
WINPTY_EXTDIR=target\$(WINPTY_BASENAME)
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
WINPTY_ARCHDIR=x64_xp
!ELSE
WINPTY_ARCHDIR=ia32_xp
!ENDIF

winpty-install: winpty-extract
	-$(COPY) "$(WINPTY_EXTDIR)\$(WINPTY_ARCHDIR)\bin" \
		"$(INSTALL_DIR)\bin" \
		winpty.dll winpty-agent.exe

winpty-download: target\$(WINPTY_ZIP)

winpty-extract: $(WINPTY_EXTDIR)

winpty-clean:
	-RD /S /Q $(WINPTY_EXTDIR)
	-DEL /F /Q $(INSTALL_DIR)\bin\winpty.dll
	-DEL /F /Q $(INSTALL_DIR)\bin\winpty-agent.exe

winpty-distclean: winpty-clean
	-DEL /F /Q target\$(WINPTY_ZIP)

target\$(WINPTY_ZIP):
	curl -sL https://github.com/rprichard/winpty/releases/download/$(WINPTY_VERSION)/$(WINPTY_ZIP) -o $@

$(WINPTY_EXTDIR): target\$(WINPTY_ZIP)
	unzip -qqo target\$(WINPTY_ZIP) -d $(WINPTY_EXTDIR)

### lang-ja

langja-install:
	IF NOT EXIST "$(VIM_INSTALL_DIR)" MD "$(VIM_INSTALL_DIR)"
	IF NOT EXIST "$(VIM_INSTALL_DIR)\lang\ja\LC_MESSAGES" \
		MD "$(VIM_INSTALL_DIR)\lang\ja\LC_MESSAGES"
	IF NOT EXIST "$(VIM_INSTALL_DIR)\lang\ja.euc-jp\LC_MESSAGES" \
		MD "$(VIM_INSTALL_DIR)\lang\ja.euc-jp\LC_MESSAGES"
	IF NOT EXIST "$(VIM_INSTALL_DIR)\lang\ja.sjis\LC_MESSAGES" \
		MD "$(VIM_INSTALL_DIR)\lang\ja.sjis\LC_MESSAGES"
	IF NOT EXIST "$(VIM_INSTALL_DIR)\doc" MD "$(VIM_INSTALL_DIR)\doc"
	IF NOT EXIST "$(VIM_INSTALL_DIR)\tutor" MD "$(VIM_INSTALL_DIR)\tutor"
	cd "$(LANGJA_DIR)"
	make test
	-COPY src\po\ja.mo "$(VIM_INSTALL_DIR)\lang\ja\LC_MESSAGES\vim.mo"
	-COPY src\po\ja.euc-jp.mo "$(VIM_INSTALL_DIR)\lang\ja.euc-jp\LC_MESSAGES\vim.mo"
	-COPY src\po\ja.sjis.mo "$(VIM_INSTALL_DIR)\lang\ja.sjis\LC_MESSAGES\vim.mo"
	-$(COPY) "runtime\lang" "$(VIM_INSTALL_DIR)\lang" menu_ja*.vim
	-$(COPY) "runtime\doc" "$(VIM_INSTALL_DIR)\doc" *.UTF-8.1
	-$(COPY) "runtime\tutor" "$(VIM_INSTALL_DIR)\tutor" tutor.ja.*
	cd "$(BUILD_DIR)"

### VIM

vim-build:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak
	cd "$(BUILD_DIR)"

vim-test: vim-build
	cd "$(VIM_DIR)\src\testdir"
	nmake /NOLOGO /F Make_dos.mak clean
	nmake /NOLOGO /F Make_dos.mak win32
	cd "$(BUILD_DIR)"

vim-test-clean:
	cd "$(VIM_DIR)\src\testdir"
	nmake /NOLOGO /F Make_dos.mak clean
	cd "$(BUILD_DIR)"

vim-clean:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak clean
	- if exist vim.lib del vim.lib
	cd "$(BUILD_DIR)"

vimd-build:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak DEBUG=yes
	cd "$(BUILD_DIR)"

vimd-clean:
	cd "$(VIM_DIR)\src"
	nmake /NOLOGO /F $(BUILD_DIR)\vim.mak DEBUG=yes clean
	- if exist vimd.lib del vimd.lib
	cd "$(BUILD_DIR)"

vim-install: vim-build
	-$(COPY) "$(VIM_DIR)\src" "$(INSTALL_DIR)\bin" \
		vim.exe gvim.exe $(VIMDLL) vimrun.exe
	-$(COPY) "$(VIM_DIR)\src\xxd" "$(INSTALL_DIR)\bin" xxd.exe
	-$(COPY) "$(VIM_DIR)\src\tee" "$(INSTALL_DIR)\bin" tee.exe

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

### PDB

PDB_DIST_NAME	= vim$(DIST_VER)-pdb
PDB_DIST_ZIP	= vim$(DIST_VER)-$(VIM_VER)-$(PATCHSET_VER)-pdb.zip
PDB_DIST_DIR	= $(OUTPUT_DIR)\$(PDB_DIST_NAME)

pdb-build: $(VIM_DIR)\src\$(VIMDLL_BASE).pdb

pdb-install: $(INSTALL_DIR)\bin\$(VIMDLL_BASE).pdb

pdb-distdir: $(PDB_DIST_DIR)\$(VIMDLL_BASE).pdb

pdb-archive: $(OUTPUT_DIR)\$(PDB_DIST_ZIP)

$(VIM_DIR)\src\vim.pdb $(VIM_DIR)\src\gvim.pdb:
	$(MAKE) vim-build

$(VIM_DIR)\src\$(VIMDLL_BASE).pdb:
	$(MAKE) vim-build

$(PDB_DIST_DIR):
	IF NOT EXIST "$(PDB_DIST_DIR)" MKDIR "$(PDB_DIST_DIR)"

$(INSTALL_DIR)\bin\vim.pdb: $(VIM_DIR)\src\vim.pdb
	-$(COPY) "$(VIM_DIR)\src" "$(INSTALL_DIR)\bin" vim.pdb

$(INSTALL_DIR)\bin\gvim.pdb: $(VIM_DIR)\src\gvim.pdb
	-$(COPY) "$(VIM_DIR)\src" "$(INSTALL_DIR)\bin" gvim.pdb

$(PDB_DIST_DIR)\vim.pdb: $(INSTALL_DIR)\bin\vim.pdb
	$(MAKE) $(PDB_DIST_DIR)
	-$(COPY) "$(INSTALL_DIR)\bin" "$(PDB_DIST_DIR)" vim.pdb

$(PDB_DIST_DIR)\gvim.pdb: $(INSTALL_DIR)\bin\gvim.pdb
	$(MAKE) $(PDB_DIST_DIR)
	-$(COPY) "$(INSTALL_DIR)\bin" "$(PDB_DIST_DIR)" gvim.pdb

$(INSTALL_DIR)\bin\$(VIMDLL_BASE).pdb: $(VIM_DIR)\src\$(VIMDLL_BASE).pdb
	-$(COPY) "$(VIM_DIR)\src" "$(INSTALL_DIR)\bin" $(VIMDLL_BASE).pdb

$(PDB_DIST_DIR)\$(VIMDLL_BASE).pdb: $(INSTALL_DIR)\bin\$(VIMDLL_BASE).pdb
	$(MAKE) $(PDB_DIST_DIR)
	-$(COPY) "$(INSTALL_DIR)\bin" "$(PDB_DIST_DIR)" $(VIMDLL_BASE).pdb

$(OUTPUT_DIR)\$(PDB_DIST_ZIP): $(PDB_DIST_DIR)\$(VIMDLL_BASE).pdb
	cd "$(OUTPUT_DIR)"
	zip -r9q $(PDB_DIST_ZIP) $(PDB_DIST_NAME)
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
	-"$(INSTALL_DIR)\bin\vim.exe" -nes -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\plugins\vimdoc-ja\doc" -c quit
# Plugin - autofmt
	-$(COPY) /E "$(CONTRIB_DIR)\autofmt" "$(VIM_DIST_DIR)\plugins\autofmt" /XD .git /XF .git*
	-"$(INSTALL_DIR)\bin\vim.exe" -nes -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\plugins\autofmt\doc" -c quit
# Plugin - vimproc
	-$(COPY) /E "$(CONTRIB_DIR)\vimproc\doc" \
		"$(VIM_DIST_DIR)\plugins\vimproc\doc"
	-"$(INSTALL_DIR)\bin\vim.exe" -nes -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\plugins\vimproc\doc" -c quit
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
		vim.exe gvim.exe $(VIMDLL) vimrun.exe xxd.exe tee.exe \
		iconv.dll intl.dll luajit.exe lua51.dll \
		winpty.dll winpty-agent.exe
	-$(COPY) /E "$(VIM_DIR)\runtime" "$(VIM_DIST_DIR)\$(RTDIR_NAME)"
	-$(COPY) /E "$(VIM_INSTALL_DIR)" "$(VIM_DIST_DIR)\$(RTDIR_NAME)"
	-"$(INSTALL_DIR)\bin\vim.exe" -nes -u NONE -U NONE --noplugin \
		-c "helptags $(VIM_DIST_DIR)\$(RTDIR_NAME)\doc" -c quit
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
	zip -r9q vim$(DIST_VER)-$(VIM_VER)-$(PATCHSET_VER).zip vim$(DIST_VER)
	cd "$(BUILD_DIR)"

clean-dist:
	-RD /S /Q "$(VIM_DIST_DIR)"

build-release-pre:
	$(MAKE) "$(INSTALL_DIR)\bin\iconv.dll"
	$(MAKE) "$(INSTALL_DIR)\bin\intl.dll"
	$(MAKE) "$(INSTALL_DIR)\lib\libXpm.lib"
	$(MAKE) "$(INSTALL_DIR)\bin\$(VIMPROC_DLL)"
	$(MAKE) "$(INSTALL_DIR)\bin\lua51.dll"
	$(MAKE) "$(INSTALL_DIR)\bin\winpty-agent.exe"
	$(MAKE) vim-clean
	$(MAKE) vim-install vim-mo-install vim-patch-install
	$(MAKE) langja-install
	$(MAKE) build-dist
	$(MAKE) pdb-distdir

build-release-core:
	$(MAKE) zip-dist
	$(MAKE) pdb-archive

build-release-post:
	$(MAKE) vim-clean

snapshot: snapshot-build snapshot-install snapshot-archive

snapshot-pre: snapshot-install snapshot-archive

snapshot-build:
	$(MAKE) vim-clean vim-build

snapshot-install:
	IF NOT EXIST "$(SNAPSHOT_DIR)" MD "$(SNAPSHOT_DIR)"
	-$(COPY) "$(VIM_DIR)\src" "$(SNAPSHOT_DIR)" vim.exe gvim.exe $(VIMDLL)

snapshot-archive:
	cd "$(OUTPUT_DIR)"
	zip -r9q vim$(DIST_VER)-snapshot-$(PATCHSET_VER).zip vim$(DIST_VER)-snapshot
	cd "$(BUILD_DIR)"


.PHONY:	archive archive-pre contrib build install clean distclean \
	iconv-build iconv-install iconv-clean iconv-distclean \
	gettext-build gettext-install gettext-clean gettext-distclean \
	xpm-build xpm-install xpm-clean xpm-distclean \
	vimproc-build vimproc-install vimproc-clean vimproc-distclean \
	luajit-build luajit-install luajit-clean luajit-distclean \
	winpty-install \
	langja-install \
	vim-build vim-clean vimd-build vimd-clean \
	vim-install vim-mo-install vim-patch-install \
	pdb-build pdb-install pdb-distdir pdb-archive \
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

"$(INSTALL_DIR)\bin\winpty-agent.exe":
	$(MAKE) winpty-install

"$(INSTALL_DIR)\bin\vim.exe":
	$(MAKE) vim-clean vim-install vim-mo-install vim-clean
