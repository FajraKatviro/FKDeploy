@echo off
if "%~2"=="" (
	echo Usage: winDeploy.bat buildConfigFile targetPath
	exit /b
)

set buildConfigFile=%1
set targetPath=%2
if not exist %buildConfigFile% (
	echo Config file not found
	exit /b
)

echo Build install package for %1 in %2

if not exist %targetPath% (
	echo Create folder %targetPath% 
	mkdir %targetPath%
)
if not exist %targetPath% (
	echo Failed
	exit /b
)

for /f "delims== tokens=1,2" %%G in (%buildConfigFile%) do @set %%G=%%H

(for /f "delims=" %%i in (Install.wxs) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:{NAME}=%NAME%!"
    set "line=!line:{FOLDER}=%FOLDER%!"
    set "line=!line:{VERSION}=%VERSION%!"
    set "line=!line:{ICON}=%APP_ICON%!"
    set "line=!line:{COMPANY}=%COMPANY%!"
    set "line=!line:{LICENSE}=%LICENSE%!"
    echo(!line!
    endlocal
))>%targetPath%\%APP_NAME%.wxs

%WIX%\candle %targetPath%\%APP_NAME%.wxs
%WIX%\light %targetPath%\%APP_NAME%.wixobj