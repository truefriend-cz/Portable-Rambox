@echo off

set "ThisDir=%~dp0"
set "ThisDir=%ThisDir:~0,-1%"


for %%I in ("%ThisDir%\..") do set "ThisDir=%%~fI"
pushd %ThisDir%


set "path_B=%appdata%\Rambox"
del "%path_B%\*" /F /Q
for /d %%p in ("%path_B%\*") do rd /Q /S "%%p"
rd /Q /S "%path_B%"

mkdir "%appdata%\Rambox"
mkdir "%ThisDir%\Backup"

xcopy "%ThisDir%\Backup\*" "%appdata%\Rambox\" /E

"%ThisDir%\Bin\Rambox\Rambox.exe"

%windir%\System32\taskkill.exe /f /im Rambox.exe

set "path_A=%ThisDir%\Backup"
del "%path_A%\*" /F /Q
for /d %%p in ("%path_A%\*") do rd /Q /S "%%p"
rd /Q /S "%path_A%"

rem Clean caches

pushd "%appdata%\Rambox"
for /F "delims=*" %%R in ('dir *cache* /b /a:d /s') do (
	echo Cleaning in: %%R, please wait...
	del /s /q /f "%%R\*.*" > nul 2>&1
	for /d %%p in ("%%R\*.*") do rmdir "%%p" /s /q > nul 2>&1
	echo. 
)
popd

mkdir "%ThisDir%\Backup"
xcopy "%appdata%\Rambox\*" "%ThisDir%\Backup\" /E

set "path_B=%appdata%\Rambox"
del "%path_B%\*" /F /Q
for /d %%p in ("%path_B%\*") do rd /Q /S "%%p"
rd /Q /S "%path_B%"


popd
exit