@ECHO OFF

SET REMOTE_HOST=koron@files.kaoriya.net
REM Update release-downloadable shortcut to a most recent file.

ssh "%REMOTE_HOST%" "htdocs/bin/files.kaoriya.net/vim/update-release.pl"

REM Update redirect table.

SET DATE_VER=%date:~-10,4%%date:~-5,2%%date:~-2,2%
SET REMOTE_DIR=htdocs/files.kaoriya.net/goto
SET REMOTE_NAME=.htaccess
SET LOCAL_NAME=htaccess.txt

DEL /F %LOCAL_NAME% %LOCAL_NAME%.old
scp "%REMOTE_HOST%:%REMOTE_DIR%/%REMOTE_NAME%" "%LOCAL_NAME%"
sed -e "s/\(vim74-kaoriya-win..-\).*\(\.zip\)/\1%DATE_VER%\2/" "%LOCAL_NAME%" -i.old
chmod 0644 "%LOCAL_NAME%"
scp "%LOCAL_NAME%" "%REMOTE_HOST%:%REMOTE_DIR%/%REMOTE_NAME%"
DEL /F %LOCAL_NAME% %LOCAL_NAME%.old

PAUSE
