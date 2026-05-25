@ECHO OFF
SETLOCAL

CALL "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64
CALL tools\command-common.bat

nmake /NOLOGO build-release-clean

PAUSE
EXIT /B 0
