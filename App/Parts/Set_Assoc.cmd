::检测目前状态 
reg query "HKCR\JFsoft.Jzip" >nul 2>nul && (
	set "stat.FileAssoc=%txt_sym.cir.s%"
) || (
	set "stat.FileAssoc=%txt_sym.cir%"
)

::被调用 
if "%1"=="-on" if "!stat.FileAssoc!"=="%txt_sym.cir%" call :on
if "%1"=="-off" if "!stat.FileAssoc!"=="%txt_sym.cir.s%" call :off
if /i "%1"=="-reon" (
	if "%FileAssoc%"=="y" call :on
)
if "%1"=="-switch" (
	if "%stat.FileAssoc%"=="%txt_sym.cir.s%" call :off reg
	if "%stat.FileAssoc%"=="%txt_sym.cir%" call :on reg
)
goto :EOF


:on
1>"%dir.jzip.temp%\Assoc.cmd" (
	echo;for %%^%%a in ^(%jzip.spt.assoc%^) do 1^>nul assoc .%%^%%a=JFsoft.Jzip
	echo;1^>nul ftype JFsoft.Jzip="%path.jzip.launcher%" "%%%%1"
)
if "%1"=="reg" 1>>"%dir.jzip.temp%\Assoc.cmd" (
	echo;reg add "HKCU\Software\JFsoft.Jzip" /v "FileAssoc" /d "y" /f ^>nul
)
goto :Assoc


:off
1>"%dir.jzip.temp%\Assoc.cmd" (
	echo;for %%^%%a in ^(%jzip.spt.open%^) do 1^>nul assoc .%%^%%a=
	echo;1^>nul ftype JFsoft.Jzip=
	echo;reg delete "HKCR\JFsoft.Jzip" /f ^>nul
)
if "%1"=="reg" 1>>"%dir.jzip.temp%\Assoc.cmd" (
	echo;reg add "HKCU\Software\JFsoft.Jzip" /v "FileAssoc" /d "" /f ^>nul
)
goto :Assoc


:Assoc
net session >nul 2>nul && call "%dir.jzip.temp%\Assoc.cmd"
net session >nul 2>nul || (
	mshta vbscript:CreateObject^("Shell.Application"^).ShellExecute^("cmd.exe","/q /c call ""%dir.jzip.temp%\Assoc.cmd""","","runas",1^)^(window.close^)
	cls & ping localhost -n 2 >nul
)
del /q /f /s "%dir.jzip.temp%\Assoc.cmd" >nul
goto :EOF


