@ECHO OFF

SET DATE_VER=%date:~-10,4%%date:~-5,2%%date:~-2,2%
SET CURDIR=%~dp0
SET VIMDIR=%~dp0..\..\vim

SET SNAPZIP_W32=vim74-kaoriya-win32-snapshot-%DATE_VER%.zip
SET SNAPZIP_W64=vim74-kaoriya-win64-snapshot-%DATE_VER%.zip

REM Apply all patches.
CD "%VIMDIR%"
git checkout guilt/master
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CD "%CURDIR%"

REM Clear previous releases.
RD /S /Q "target\vim74-kaoriya-win32"
RD /S /Q "target\vim74-kaoriya-win64"
DEL /F "target\vim74-kaoriya-win32-%DATE_VER%.zip"
DEL /F "target\vim74-kaoriya-win64-%DATE_VER%.zip"

REM Clear previous snapshots.
RD /S /Q "target\vim74-kaoriya-win32-snapshot"
RD /S /Q "target\vim74-kaoriya-win64-snapshot"
DEL /F "target\vim74-kaoriya-win32-snapshot-*.zip"
DEL /F "target\vim74-kaoriya-win64-snapshot-*.zip"

REM Build releases and snapshots.
CMD /C "tools\msvc-nmake.bat" x86 build-release-pre snapshot-pre
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CMD /C "tools\msvc-nmake.bat" amd64 build-release-pre snapshot-pre
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Update snapshot information.
DEL /F "target\latest.json"
go run genjson.go "target\latest.json" "target\%SNAPZIP_W32%" "vim74w32" "http://files.kaoriya.net/vim/snapshots/%SNAPZIP_W32%" "target\%SNAPZIP_W64%" "vim74w64" "http://files.kaoriya.net/vim/snapshots/%SNAPZIP_W64%"
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Build release archives.
START CMD /C "tools\msvc-nmake.bat" x86 build-release-core
START CMD /C "tools\msvc-nmake.bat" amd64 build-release-core

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
