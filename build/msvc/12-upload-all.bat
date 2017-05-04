@ECHO OFF

FOR /F "usebackq tokens=1,2 delims==	 " %%i IN ("..\..\VERSION") do SET %%i=%%j

SET PREFIX=vim%VIM_VER_SHORT%
SET SUFFIX=%VIM_VER%-%PATCHSET_VER%

SET RELZIP_W32=%PREFIX%-kaoriya-win32-%SUFFIX%.zip
SET RELZIP_W64=%PREFIX%-kaoriya-win64-%SUFFIX%.zip
SET PDBZIP_W32=%PREFIX%-kaoriya-win32-%SUFFIX%-pdb.zip
SET PDBZIP_W64=%PREFIX%-kaoriya-win64-%SUFFIX%-pdb.zip

REM Uplaod release files to server.

ECHO Uploading...
rsync -v target/%RELZIP_W32% target/%RELZIP_W64% target/%PDBZIP_W32% target/%PDBZIP_W64% "koron@files.kaoriya.net:htdocs/files.kaoriya.net/vim"
PAUSE
