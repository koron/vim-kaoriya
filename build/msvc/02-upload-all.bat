@ECHO OFF

SET DATE_VER=%date:~-10,4%%date:~-5,2%%date:~-2,2%

SET RELZIP_W32=vim74-kaoriya-win32-%DATE_VER%.zip
SET RELZIP_W64=vim74-kaoriya-win64-%DATE_VER%.zip
SET SNAPZIP_W32=vim74-kaoriya-win32-snapshot-%DATE_VER%.zip
SET SNAPZIP_W64=vim74-kaoriya-win64-snapshot-%DATE_VER%.zip

REM Uplaod release files to server.

ECHO Uploading...
rsync -v target/%RELZIP_W32% target/%RELZIP_W64% "koron@files.kaoriya.net:htdocs/files.kaoriya.net/vim"
rsync -v target/%SNAPZIP_W32% target/%SNAPZIP_W64% target/latest.json "koron@files.kaoriya.net:htdocs/files.kaoriya.net/vim/snapshots"
PAUSE
