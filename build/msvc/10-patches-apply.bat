@ECHO OFF

SET GUILTCMD=sh /usr/local/bin/guilt

SET CURDIR=%~dp0
SET VIMDIR=%~dp0..\..\vim

CD "%VIMDIR%"
%GUILTCMD% pop -a
%GUILTCMD% push -a
CD "%CURDIR%"

PAUSE
EXIT /B 0
