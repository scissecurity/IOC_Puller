@echo off
REM Pull Basic IOC information remotely with psexec wrapper
REM Complement script: localRunAgent.cmd
REM James.Davidson[AT]scissecurity.com
REM Usage: Run this script with correct elevated admin privs and follow prompts
REM .
REM Can't get %~dp0 method to work for whatever reason
REM This method comes up as \\null when tested locally at least
REM @setlocal enableextensions
REM @cd /d "%~dp0"
REM . 

echo Pull basic IOC information remotely with this psexec wrapper
 
set /p rhost="Enter Remote Host Name or IP:"
echo You entered %rhost%
set /p username="Enter admin name DOMAIN\foo:"
echo You entered %username%
set /p password="Enter admin password:"
set /p srcdir="Enter directory where localRunAgent.cmd is:"
echo You entered %srcdir%

echo Pushing localRunAgent.cmd to host and outputting to \\%rhost%\C$\ioc_pull.log
psexec.exe \\%rhost% -h -u %username% -p %password% -c %srcdir%\localRunAgent.cmd --accepteula -nobanner

echo Copying back ioc_pull.log to current directory
echo You will have to enter your password again for RunAs Robocopy to work
RunAs.exe /user:%username% "robocopy.exe \\%rhost%\c$ "%srcdir%" ioc_pull.log" 

echo Cleaning up ioc_pull.log from %rhost%
psexec.exe \\%rhost% -h -u %username% -p %password% cmd.exe /c rm "c:\ioc_pull.log"

echo Done. Review ioc_pull.log in %srcdir%
echo Press any key to exit.
pause