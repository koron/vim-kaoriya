@ECHO OFF
SETLOCAL

CALL tools\command-common.bat

SET YEAR=%DATE:~-10,4%

ECHO Uploading to https://files.kaoriya.net/vim/%YEAR%/
ECHO - https://files.kaoriya.net/vim/%YEAR%/%RELZIP_W64%
ECHO - https://files.kaoriya.net/vim/%YEAR%/%PDBZIP_W64%

rsync -v target/%RELZIP_W64% target/%PDBZIP_W64% "koron@files.kaoriya.net:htdocs/files.kaoriya.net/vim/%YEAR%"

PAUSE
EXIT /B 0
