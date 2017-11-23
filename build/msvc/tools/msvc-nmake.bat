@ECHO OFF

REM Use SDK 8.1 for missing headers.
SET "INCLUDE=C:\Program Files (x86)\Windows Kits\8.1\include\shared;C:\Program Files (x86)\Windows Kits\8.1\include\um;C:\Program Files (x86)\Windows Kits\8.1\include\winrt"

CALL "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" %1
nmake %2 %3 %4 %5 %6 %7 %8 %9
