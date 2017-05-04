@ECHO OFF

FOR /F "usebackq tokens=1,2 delims==	 " %%i IN ("..\..\VERSION") do SET %%i=%%j

SET PREFIX=vim%VIM_VER_SHORT%
SET SUFFIX=%VIM_VER%-%PATCHSET_VER%

SET RELZIP_W32=%PREFIX%-kaoriya-win32-%SUFFIX%.zip
SET RELZIP_W64=%PREFIX%-kaoriya-win64-%SUFFIX%.zip
SET PDBZIP_W32=%PREFIX%-kaoriya-win32-%SUFFIX%-pdb.zip
SET PDBZIP_W64=%PREFIX%-kaoriya-win64-%SUFFIX%-pdb.zip

SET CURDIR=%~dp0
SET VIMDIR=%~dp0..\..\vim

REM Apply all patches.
CD "%VIMDIR%"
git checkout guilt/master
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CD "%CURDIR%"

REM Clear previous releases.
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win32"
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win64"
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win32-pdb"
RD /S /Q "target\vim%VIM_VER_SHORT%-kaoriya-win64-pdb"
DEL /F "target\%RELZIP_W32%"
DEL /F "target\%RELZIP_W64%"
DEL /F "target\%PDBZIP_W32%"
DEL /F "target\%PDBZIP_W64%"

REM Build releases.
CMD /C "tools\msvc-nmake.bat" x86 build-release-pre
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE
CMD /C "tools\msvc-nmake.bat" amd64 build-release-pre
IF %ERRORLEVEL% NEQ 0 GOTO :FAILURE

REM Build release archives.
START CMD /C "tools\msvc-nmake.bat" x86 build-release-core build-release-post
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
