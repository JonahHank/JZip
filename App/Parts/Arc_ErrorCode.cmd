
for %%A in (
	255/"用户中断。"
	11/"密码错误。"
	10/"没有找到与指定的掩码和选项匹配的文件。"
	9/"文件创建错误。"
	8/"内存不足。"
	7/"错误命令行选项。"
	6/"文件打开错误。"
	5/"写入错误。"
	4/"不可修改已锁定的压缩文件。"
	3/"无效校验和，数据损坏。"
	2/"发生一般错误。"
	1/"发生严重错误。"
) do for /f "tokens=1-2 delims=/" %%a in ("%%A") do (
	if errorlevel %%a call "%dir.jzip%\Function\VbsBox" msgbox "%%~b"
)
goto :EOF