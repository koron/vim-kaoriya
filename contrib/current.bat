@ECHO OFF

SET BASE_DIR=%~dp0
SET DATE_VER=%date:~-10,4%-%date:~-5,2%-%date:~-2,2%
SET LOG_FILE=%BASE_DIR%current-%DATE_VER%.log

CALL :SHOW_REV autofmt %BASE_DIR%autofmt
CALL :SHOW_REV gettext %BASE_DIR%gettext
CALL :SHOW_REV lang-ja %BASE_DIR%lang-ja
CALL :SHOW_REV libiconv %BASE_DIR%libiconv2
CALL :SHOW_REV libXpm-win32 %BASE_DIR%libXpm-win32
CALL :SHOW_REV LuaJIT %BASE_DIR%luajit-2.0
CALL :SHOW_REV vimdoc-ja %BASE_DIR%vimdoc-ja

CD %BASE_DIR%
GOTO :SUCCESS

:SHOW_REV
CD %2
git log -n 1 --date=short --format="%1 (%%ad %%h)" >> %LOG_FILE%
EXIT /B 0

:SUCCESS
ECHO ========
ECHO SUCCEEDED: %~nx0
PAUSE
EXIT /B 0
