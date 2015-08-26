@ECHO OFF

SET DATE_VER=%date:~-10,4%%date:~-5,2%%date:~-2,2%
SET CURDIR=%~dp0
SET VIMDIR=%~dp0..\..\vim

REM Update vim sourse.
CD "%VIMDIR%"
hg qpop -a
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
hg pull -u
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CD "%CURDIR%"

REM Build and test pure vim.
CALL :TEST_RUN %CURDIR%target\test-%DATE_VER%-plain.log
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Apply kaoriya patches.
CD "%VIMDIR%"
hg qpush -a
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CD "%CURDIR%"

REM Build and test +kaoriya vim.
CALL :TEST_RUN %CURDIR%target\test-%DATE_VER%-kaoriya.log
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Revert kaoriya patches
CD "%VIMDIR%"
hg qpop -a
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CD "%CURDIR%"

REM Test end.

:SUCCESS
ECHO ----
ECHO SUCCEEDED: %~nx0
PAUSE
EXIT /B 0

:FAILURE
ECHO ----
ECHO FAILED: %~nx0
PAUSE
EXIT /B %ERRORLEVEL%

REM ========================================================================
REM SUB-ROUTINES

:TEST_RUN
SETLOCAL
CD "%CURDIR%"
CMD /C "%CURDIR%tools\msvc-nmake.bat" amd64 vim-clean vim-build
IF %ERRORLEVEL% NEQ 0 GOTO :TEST_FAILURE
CD "%VIMDIR%\src\testdir"
CMD /C "%CURDIR%tools\msvc-nmake.bat" amd64 -f Make_dos.mak clean win32
IF %ERRORLEVEL% NEQ 0 GOTO :TEST_FAILURE
CMD /C "%CURDIR%tools\msvc-nmake.bat" amd64 -f Make_dos.mak clean
:TEST_SUCCESS
CD "%CURDIR%"
EXIT /B 0
:TEST_FAILURE
SET SAVED_ERRORLEVEL=%ERRORLEVEL%
IF EXIST %VIMDIR%\src\testdir\test.log COPY %VIMDIR%\src\testdir\test.log %1
CD "%CURDIR%"
EXIT /B %SAVED_ERRORLEVEL%
