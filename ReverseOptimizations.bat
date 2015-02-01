@echo off
set MYPATH=%EPOCROOT%OptimiseEmulator\
set PATH=%MYPATH%;%EPOCROOT%epoc32\tools;%PATH%


if not exist %MYPATH%backup_files.zip (
echo Cannot find backup_files.zip
exit 1
)


cd %EPOCROOT%
unzip -o %MYPATH%backup_files.zip

:end
cd %MYPATH%
