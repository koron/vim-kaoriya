@ECHO OFF
SETLOCAL

CALL tools\command-common.bat

REM Pool release files to pooling server.
ECHO Pooling...
SET YEAR=%date:~-10,4%
rsync -v target/%RELZIP_W32% target/%RELZIP_W64% target/%PDBZIP_W32% target/%PDBZIP_W64% "koron@ixeris.kaoriya.net:pool/vim-jp/released/%YEAR%"

PAUSE
EXIT /B 0
