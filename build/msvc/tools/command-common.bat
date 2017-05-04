@ECHO OFF

SET REMOTE_HOST=koron@files.kaoriya.net
SET REMOTE_WORKDIR=/home/htdocs/files.kaoriya.net/vim/

SET CURDIR=%~dp0..
SET VIMDIR=%~dp0..\..\..\vim

SET GUILTCMD=sh /usr/local/bin/guilt

FOR /F "usebackq tokens=1,2 delims==	 " %%i IN ("..\..\VERSION") do SET %%i=%%j

SET _VIM_PREFIX=vim%VIM_VER_SHORT%
SET _VIM_SUFFIX=%VIM_VER%-%PATCHSET_VER%

SET RELZIP_W32=%_VIM_PREFIX%-kaoriya-win32-%_VIM_SUFFIX%.zip
SET RELZIP_W64=%_VIM_PREFIX%-kaoriya-win64-%_VIM_SUFFIX%.zip
SET PDBZIP_W32=%_VIM_PREFIX%-kaoriya-win32-%_VIM_SUFFIX%-pdb.zip
SET PDBZIP_W64=%_VIM_PREFIX%-kaoriya-win64-%_VIM_SUFFIX%-pdb.zip

SET _VIM_SUFFIX=
SET _VIM_PREFIX=

EXIT /B 0
