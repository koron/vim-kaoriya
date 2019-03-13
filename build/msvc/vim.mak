USERNAME=koron.kaoriya
USERDOMAIN=gmail.com

FEATURES=HUGE
MBYTE=YES
USE_MSVCRT=yes
MIGEMO=yes
MAP=no

# DirectWrite support.
DIRECTX=yes

# Terminal support.
TERMINAL=yes

# Perl settings
!if !defined(DISABLE_IF) && !defined(DISABLE_PERL)
DYNAMIC_PERL=yes
PERL_VER=528
!if "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
PERL = D:\Perl\strawberry-perl-5.28.1.1-64bit\perl
!else
PERL = D:\Perl\strawberry-perl-5.28.1.1-32bit\perl
!endif
!endif

# Python settings
!if !defined(DISABLE_IF) && !defined(DISABLE_PYTHON)
DYNAMIC_PYTHON=yes
PYTHON_VER=27
DYNAMIC_PYTHON3=yes
PYTHON3_VER=35
!if "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
PYTHON  = D:\Python\Python27
PYTHON3 = D:\Python\Python35
!else
PYTHON  = D:\Python\Python27-x86
PYTHON3 = D:\Python\Python35-32
!endif
!endif

# Lua settings
!if !defined(DISABLE_IF) && !defined(DISABLE_LUA)
DYNAMIC_LUA=yes
LUA_VER=51
!if "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
LUA= ..\..\build\msvc\target\install-x64\include\lua
!else
LUA= ..\..\build\msvc\target\install-x32\include\lua
!endif
!endif

# Ruby�̐ݒ�.
!if !defined(DISABLE_IF) && !defined(DISABLE_RUBY)
RUBY_VER=23
RUBY_API_VER_LONG=2.3.0
DYNAMIC_RUBY=yes
!if "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
RUBY = D:\Ruby\ruby-2.3.1-x64-mswin64
RUBY_PLATFORM=x64-mswin64_100
RUBY_INSTALL_NAME=x64-msvcrt-ruby230
!else
RUBY = D:\Ruby\ruby-2.3.1-i386-mswin32
RUBY_PLATFORM=i386-mswin32_100
RUBY_INSTALL_NAME=msvcrt-ruby230
!endif
!endif

# XPM�̐ݒ�
!if !defined(DISABLE_XPM)
!if "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
XPM=..\..\build\msvc\target\install-x64
!else
XPM=..\..\build\msvc\target\install-x32
!endif
!endif

# +channel feature for non-GUI
CHANNEL=yes

!ifndef DEBUG
DEBUG=no
!endif

!IF "$(_NMAKE_VER)" >= "9." && "$(_NMAKE_VER)" < "@."
MSCVER=9.0
MSVCRT_DLL=msvcr90.dll
!ELSEIF "$(_NMAKE_VER)" >= "10." && "$(_NMAKE_VER)" < "11."
MSCVER=10.0
MSVCRT_DLL=msvcr100.dll
!ELSEIF "$(_NMAKE_VER)" >= "11." && "$(_NMAKE_VER)" < "12."
MSCVER=11.0
MSVCRT_DLL=msvcr110.dll
!ELSEIF "$(_NMAKE_VER)" >= "12." && "$(_NMAKE_VER)" < "13."
MSCVER=12.0
MSVCRT_DLL=msvcr120.dll
!ELSEIF "$(_NMAKE_VER)" >= "14." && "$(_NMAKE_VER)" < "15."
MSCVER=14.0
MSVCRT_FILES=vcruntime140.dll
!ELSE
!ERROR Unknown MSVC version: $(_NMAKE_VER)
!ENDIF


!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
DEFINES_ARCH =
!ELSE
DEFINES_ARCH = /D_USE_32BIT_TIME_T=1
!ENDIF

DEFINES= /DMODIFIED_BY=\"$(USERNAME)@$(USERDOMAIN)\" \
		/DDYNAMIC_MSVCRT_DLL=\"$(MSVCRT_DLL)\" \
		/DGETTEXT_DLL=\"intl.dll\" \
		/DGETTEXT_DLL_ALT=\"intl.dll\" \
		/D_BIND_TO_CURRENT_VCLIBS_VERSION=1 \
		$(DEFINES_ARCH)

!include Make_mvc.mak
