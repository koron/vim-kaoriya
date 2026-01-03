@ECHO OFF

CALL tools\command-common.bat

SET ABSZIP_W32=vim-kaoriya-win32-develop.zip
SET ABSZIP_W64=vim-kaoriya-win64-develop.zip

ECHO Update DEVELOP
ssh "%REMOTE_HOST%" "cd %REMOTE_WORKDIR%; ln -fv %RELZIP_W32% %ABSZIP_W32%; ln -fv %RELZIP_W64% %ABSZIP_W64%"

PAUSE
EXIT /B 0
