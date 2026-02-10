@ECHO OFF

CD
SET INSTALL_DIR=D:\Vim

CALL tools\command-common.bat
7za x -o"%INSTALL_DIR%" -y "target\%RELZIP_W64%"

PAUSE
EXIT /B 0
