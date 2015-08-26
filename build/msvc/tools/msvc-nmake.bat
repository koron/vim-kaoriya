@ECHO OFF

CALL "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" %1
nmake %2 %3 %4 %5 %6 %7 %8 %9
