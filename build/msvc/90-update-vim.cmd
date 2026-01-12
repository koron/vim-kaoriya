@ECHO OFF

CALL tools\command-common.bat

CD "%VIMDIR%"

REM Catcn up Vim's update
git switch master
git fetch -p
git merge --ff-only "@{u}"

REM Update VIM_VER in ..\..\VERSION
SET TEMP_PATCH_NUM=%TEMP%\%RANDOM%_vim_patch_num.txt
sed -ne '/^static int included_patches/,/^\s*[0-9]\+,$/p' src/version.c | tail -1 | tr -cd 0123456789 | xargs printf '%%04d' > %TEMP_PATCH_NUM%
SET /P PATCH_NUM=<%TEMP_PATCH_NUM%
DEL /F %TEMP_PATCH_NUM%
sed -i -e 's/^\(VIM_VER\s*=\s*[0-9]\+\.[0-9]\+\.\)[0-9]\+/\1%PATCH_NUM%/' ..\VERSION

TYPE ..\VERSION

REM END
PAUSE
EXIT /B 0
