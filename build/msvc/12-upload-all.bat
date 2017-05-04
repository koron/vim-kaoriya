@ECHO OFF

CALL tools\command-common.bat

REM Uplaod release files to server.

ECHO Uploading...
rsync -v target/%RELZIP_W32% target/%RELZIP_W64% target/%PDBZIP_W32% target/%PDBZIP_W64% "koron@files.kaoriya.net:htdocs/files.kaoriya.net/vim"
PAUSE
EXIT /B 0
