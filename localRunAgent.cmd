@echo off
REM Pull Basic IOC information locally using this script
REM James.Davidson[AT]scissecurity.com

REM Network activities
net view \\127.0.0.1 >> c:\ioc_pull.log
net session >> c:\ioc_pull.log
net use >> c:\ioc_pull.log
nbtstat -S >> c:\ioc_pull.log
netstat -anob >> c:\ioc_pull.log
netsh firewall show config >> c:\ioc_pull.log

REM Grab processes
tasklist /v >> c:\ioc_pull.log
wmic process list full >> c:\ioc_pull.log

REM Grab services
net start >> c:\ioc_pull.log
sc query >> c:\ioc_pull.log

REM Services to Process Grab
tasklist /svc >> c:\ioc_pull.log

REM Look at startup registry entries
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" >> c:\ioc_pull.log
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Runonce" >> c:\ioc_pull.log
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\RunonceEx" >> c:\ioc_pull.log

REM Grab scheduled tasks
schtasks >> c:\ioc_pull.log

REM Other Startup Objects
wmic startup list full >> c:\ioc_pull.log

REM Local user details
net user >> c:\ioc_pull.log
net localgroup Administrators >> c:\ioc_pull.log

REM Grab Last 25 Entries from each primary log
wevtutil.exe qe Security /count:25 /rd:true /format:text >> c:\ioc_pull.log
wevtutil.exe qe System /count:25 /rd:true /format:text >> c:\ioc_pull.log
wevtutil.exe qe Application /count:25 /rd:true /format:text >> c:\ioc_pull.log