@ECHO OFF

SET INSTALL_DIR=D:\Vim\daily

CALL "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64
CALL tools\command-common.bat

CD "%VIMDIR%"

REM Catcn up Vim's update
%GUILTCMD% pop -a
git fetch -p
git merge --ff-only "@{u}"

REM Update VIM_VER in ..\..\VERSION

SET TEMP_PATCH_NUM=%TEMP%\%RANDOM%_vim_patch_num.txt
sed -ne '/^static int included_patches/,/^\s*[0-9]\+,$/p' src/version.c | tail -1 | tr -cd 0123456789 | xargs printf '%%04d' > %TEMP_PATCH_NUM%
SET /P PATCH_NUM=<%TEMP_PATCH_NUM%
DEL /F %TEMP_PATCH_NUM%
sed -i -e 's/^\(VIM_VER\s*=\s*[0-9]\+\.[0-9]\+\.\)[0-9]\+/\1%PATCH_NUM%/' ..\VERSION

REM Apply patches with guilt
%GUILTCMD% push -a

CD "%CURDIR%"
REM load updated VIM_VER
CALL tools\command-common.bat

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
nmake /NOLOGO build-release-clean

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
