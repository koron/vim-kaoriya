@ECHO OFF

CALL tools\command-common.bat

REM Apply all patches.
CD "%VIMDIR%"
git checkout guilt/master
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CD "%CURDIR%"

REM Clear previous releases.
REM RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win32"
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win64"
REM RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win32-pdb"
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win64-pdb"
REM DEL /F "target\%RELZIP_W32%"
DEL /F "target\%RELZIP_W64%"
REM DEL /F "target\%PDBZIP_W32%"
DEL /F "target\%PDBZIP_W64%"

REM Build releases.
REM CMD /C "tools\msvc-nmake.bat" x86 build-release-pre
REM IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CMD /C "tools\msvc-nmake.bat" amd64 build-release-pre
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Build release archives.
REM START CMD /C "tools\msvc-nmake.bat" x86 build-release-core build-release-post
START CMD /C "tools\msvc-nmake.bat" amd64 build-release-core build-release-post

REM Revert all patches.
CD "%VIMDIR%"
REM git checkout master
CD "%CURDIR%"

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
