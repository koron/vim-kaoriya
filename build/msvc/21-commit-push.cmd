@ECHO OFF

CALL tools\command-common.bat

REM Make sure we are on the "main" branch

FOR /F "delims=" %%b IN ('git rev-parse --abbrev-ref HEAD 2^>nul') DO (
  SET "current_branch=%%b"
)
if NOT "%current_branch%"=="main" (
  ECHO Error: not a "main" branch: %current_branch%
  PAUSE
  EXIT /B 1
)

REM Verify that ../../VERSION and ../../vim have been changed

git status -s --untracked-files=no ..\..\VERSION | FINDSTR /B /C:" M ../../VERSION" > NUL
if %ERRORLEVEL% NEQ 0 (
  ECHO Error: no changes on ..\..\VERSION
  PAUSE
  EXIT /B 1
)
git status -s --untracked-files=no ..\..\vim | FINDSTR /B /C:" M ../../vim" > NUL
if %ERRORLEVEL% NEQ 0 (
  ECHO Error: no changes on ..\..\vim
  PAUSE
  EXIT /B 1
)

ECHO Detected changes on ..\..\vim, and ..\..\VERSION

git add ..\..\VERSION ..\..\vim

ECHO Committing...

git commit -m "Catch up Vim %VIM_VER%"

ECHO Pushing...

git push

PAUSE
EXIT /B 0
