@ECHO OFF

SET DATE_VER=%date:~-10,4%%date:~-5,2%%date:~-2,2%
SET CURDIR=%~dp0
SET VIMDIR=%~dp0..\..\vim

SET SNAPZIP_W32=vim74-kaoriya-win32-snapshot-%DATE_VER%.zip
SET SNAPZIP_W64=vim74-kaoriya-win64-snapshot-%DATE_VER%.zip

REM Update vim sourse and apply all patches.
CD "%VIMDIR%"
hg qpop -a
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
hg pull -u
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
hg qpush -a
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CD "%CURDIR%"

REM Build binaries.
RD /S /Q "target\vim74-kaoriya-win32-snapshot"
RD /S /Q "target\vim74-kaoriya-win64-snapshot"
DEL /F "target\vim74-kaoriya-win32-snapshot-*.zip"
DEL /F "target\vim74-kaoriya-win64-snapshot-*.zip"
CMD /C "tools\msvc-nmake.bat" x86 snapshot
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CMD /C "tools\msvc-nmake.bat" amd64 snapshot
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Update snapshot information.
DEL /F "target\latest.json"
go run genjson.go "target\latest.json" "target\%SNAPZIP_W32%" "vim74w32" "http://files.kaoriya.net/vim/snapshots/%SNAPZIP_W32%" "target\%SNAPZIP_W64%" "vim74w64" "http://files.kaoriya.net/vim/snapshots/%SNAPZIP_W64%"
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Revert all patches.
CD "%VIMDIR%"
hg qpop -a
CD "%CURDIR%"

REM Upload zip files.
rsync -v target/vim74-kaoriya-win*-snapshot-*.zip target/latest.json "koron@files.kaoriya.net:htdocs/files.kaoriya.net/vim/snapshots"
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM TODO: remove old snapshot files from the server.

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
