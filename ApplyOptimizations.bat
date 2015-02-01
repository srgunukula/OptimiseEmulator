@echo off
set MYPATH=%EPOCROOT%OptimiseEmulator\
set PATH=%MYPATH%;%EPOCROOT%epoc32\tools;%PATH%

echo 10.1 2010 wk016 emulator environment patch

if not exist "%MYPATH%\backup_files.zip" (
echo Creating backup...
cd %EPOCROOT%
type %MYPATH%\backup_files.lst | zip -o -q -1 %MYPATH%\backup_files.zip -@
echo Backup created %MYPATH%backup_files.zip 
echo run ReverseOptimizations.bat to restore original files
) else (
echo Backup exists, skiping backing up..
)

cd %MYPATH%

echo Patching evironment

echo *** Patching components that use lots of memory ***
echo *** None ***
echo *** Patching components with miscellaneous problems ***


echo Fixing Sensor Server startup memory leak dialog
cd %EPOCROOT%sf\os\devicesrv\sensorservices\sensorserver\group
copy %EPOCROOT%OptimiseEmulator\src\sensrvpluginproxy.cpp ..\src\server
call sbs -p sensrvserver.mmp -c winscw

echo Fixing defect ou1cimx1#367405 (instability in the emulator)
cd %EPOCROOT%sf\os\graphics\windowing\windowserver\group\restricted
copy %EPOCROOT%OptimiseEmulator\src\CLIENT.CPP ..\..\nga\server\restricted
call sbs -p WServ_nga.MMP -c winscw


rem Reduce emulator heaps
cd %EPOCROOT%epoc32\release\winscw\udeb

REM editbin /stack:0x80000 epoc.exe
REM editbin /heap:0x100000 efile.exe
REM editbin /heap:0x1000000 hsapplication.exe
REM editbin /heap:0x100000 widgetregistry.exe

rem Reduce emulator heaps
cd %EPOCROOT%epoc32\release\winscw\urel

REM editbin /stack:0x80000 epoc.exe
REM editbin /heap:0x100000 efile.exe
REM editbin /heap:0x1000000 hsapplication.exe
REM editbin /heap:0x100000 widgetregistry.exe




echo Patching startup problem (TRON-7V2B3P), removing fonts...
cd %EPOCROOT%
rmdir %EPOCROOT%epoc32\release\winscw\udeb\z\resource\fonts /s /q
rmdir %EPOCROOT%epoc32\release\winscw\urel\z\resource\fonts /s /q
unzip -o %EPOCROOT%OptimiseEmulator\fonts.zip
			


echo.
echo *** NEW: Minimal startup list!!! ***
echo.
echo *** Check the wiki page, section "Reduced starter list"
echo.


:end

cd %MYPATH%
