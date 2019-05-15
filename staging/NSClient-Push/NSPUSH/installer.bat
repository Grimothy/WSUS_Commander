
set NSFolder="C:\Program Files\NSClient++"

IF EXIST %NSFolder% (
	exit
) Else (
	msiexec.exe /i "\\wsus3.trumark.org\NSPUSH\NSCP-0.5.0.62-x64.msi" /quiet
	net stop nscp
	ping 127.0.0.1 -n 10 > nul
	copy "\\wsus3.trumark.org\NSPUSH\nsclient.ini" "C:\Program Files\NSClient++" /Y
	net start nscp
)