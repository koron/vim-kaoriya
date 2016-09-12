@ECHO OFF

FOR /F "usebackq tokens=1,2 delims==	 " %%i IN ("..\..\VERSION") do SET %%i=%%j
SET RELZIP_W32=vim%VIM_VER_SHORT%-kaoriya-win32-%VIM_VER%-%PATCHSET_VER%.zip
SET RELZIP_W64=vim%VIM_VER_SHORT%-kaoriya-win64-%VIM_VER%-%PATCHSET_VER%.zip

REM Uplaod release files to server.

ECHO Uploading...
rsync -v target/%RELZIP_W32% target/%RELZIP_W64% "koron@files.kaoriya.net:htdocs/files.kaoriya.net/vim"
PAUSE
