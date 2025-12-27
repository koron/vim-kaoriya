@ECHO OFF
REM
REM Experimental command to apply patches without using guilt
REM
SETLOCAL

CD vim
SET PATCH_DIR=..\patches\master
git switch -C apply-patches

FOR /F "delims=" %%l IN (%PATCH_DIR%\series) DO (
	ECHO Applying patch: %%l
	git apply -p 1 "%PATCH_DIR%\%%l"
	IF ERRORLEVEL 1 EXIT /B 1
)
