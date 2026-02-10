@ECHO OFF
SETLOCAL

REM REQUIRED VARIABLES
REM
REM   - INSTALL_DIR
REM   - OUTFILE

CALL tools\command-common.bat

SET TARGETDIR=%INSTALL_DIR%\vim%VIM_VER_SHORT%-kaoriya-win64
IF EXIST "%OUTFILE%" (
    DEL /F %OUTFILE%
)

"%TARGETDIR%\vim" -u tools\check.vim -U NONE --noplugin --not-a-term -c "f %OUTFILE%|wq"
IF NOT EXIST "%OUTFILE%" (
    ECHO ERROR: Failed on checking version
    PAUSE
    EIXT /B 1
)

FOR /f "usebackq eol=; tokens=1,* delims==" %%a in  ("%OUTFILE%") do (
    SET check_%%a=%%b
)
DEL /F %OUTFILE%

IF NOT "%check_version%"=="%VIM_VER%" (
    ECHO ERROR: unexpected version: want=%VIM_VER% got=%check_version%
    SET HAS_ERROR=1
)
IF %check_kaoriya% NEQ 1 (
    ECHO ERROR: without kaoriya patches
    SET HAS_ERROR=1
)
IF DEFINED HAS_ERROR (
    PAUSE
    EXIT /B 1
)

ECHO OK: %TARGETDIR% is %check_version% +kaoriya
PAUSE
EXIT /B 0

REM vim:set ts=8 sts=4 sw=4 tw=0 et:
