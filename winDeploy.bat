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

(for /f "delims=" %%i in (%~dp0\Install.wxs) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:{NAME}=%NAME%!"
    set "line=!line:{VERSION}=%VERSION%!"
    set "line=!line:{ICON}=%ICON%!"
    set "line=!line:{COMPANY}=%COMPANY%!"
    set "line=!line:{LICENSE}=%LICENSE%!"
    echo(!line!
    endlocal
))>%targetPath%\%NAME%.wxs

"%WIX%\bin\heat" dir "%FOLDER%" -cg ProjectFiles -gg -scom -sreg -sfrag -srd -ke -dr INSTALLLOCATION -var var.ProductFolder -out "%targetPath%\%NAME%_files.wxs"
"%WIX%\bin\candle" -dProductFolder="%FOLDER%" -dUpgradeGuid="%UPGRADE_CODE%" "%targetPath%\%NAME%.wxs" "%targetPath%\%NAME%_files.wxs"
REM "%WIX%\bin\light" "%targetPath%\%NAME%.wixobj"