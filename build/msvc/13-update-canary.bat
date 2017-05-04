@ECHO OFF

CALL tools\command-common.bat

SET ABSZIP_W32=vim-kaoriya-win32-canary.zip
SET ABSZIP_W64=vim-kaoriya-win64-canary.zip

ECHO Update CANARY
ssh "%REMOTE_HOST%" "cd %REMOTE_WORKDIR%; ln -fv %RELZIP_W32% %ABSZIP_W32%; ln -fv %RELZIP_W64% %ABSZIP_W64%"

PAUSE
EXIT /B 0
