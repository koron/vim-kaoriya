@ECHO OFF

SET INSTALL_DIR=D:\Vim\daily

CALL "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64
CALL tools\command-common.bat

CD "%VIMDIR%"

REM Catcn up Vim's update
%GUILTCMD% pop -a
git fetch -p
git merge --ff-only @{u}

REM Apply patches with guilt
%GUILTCMD% push -a

CD "%CURDIR%"

REM Build Vim
nmake /NOLOGO build-release

REM Test
nmake /NOLOGO vim-test

REM Create archives
nmake /NOLOGO build-release-archive
nmake /NOLOGO build-release-clean

REM Install x64 binary to local
7za x -o"%INSTALL_DIR%" -y "target\%RELZIP_W64%"

REM Clean patches with guilt
CD "%VIMDIR%"
%GUILTCMD% pop -a
CD "%CURDIR%"

REM END
PAUSE
EXIT /B 0
