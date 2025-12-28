@ECHO OFF

SET INSTALL_DIR=D:\Vim\daily

CALL "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64
CALL tools\command-common.bat

CD "%VIMDIR%"

REM Apply patches with guilt
%GUILTCMD% pop -a
%GUILTCMD% push -a

CD "%CURDIR%"

REM Clear previous releases.
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win64"
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win64-pdb"
DEL /F "target\%RELZIP_W64%"
DEL /F "target\%PDBZIP_W64%"

REM Build Vim
nmake /NOLOGO build-release

REM Test
nmake /NOLOGO build-release-test

REM Create archives
nmake /NOLOGO build-release-archive

REM Install x64 binary to local
RD /S /Q "%INSTALL_DIR%\vim%VIM_VER_SHORT%-kaoriya-win64"
7za x -o"%INSTALL_DIR%" -y "target\%RELZIP_W64%"

REM Clean patches with guilt
CD "%VIMDIR%"
%GUILTCMD% pop -a
CD "%CURDIR%"

REM END
PAUSE
EXIT /B 0
