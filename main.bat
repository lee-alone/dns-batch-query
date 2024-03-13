@echo off
setlocal EnableDelayedExpansion

set "filename=chinalist.txt"
set "outputfile=resolved.txt"

rem 删除已存在的 resolved.txt 文件
if exist "%outputfile%" del "%outputfile%"

for /f "usebackq delims=" %%a in ("%filename%") do (
    set "domain=%%a"
    echo.
    echo Resolving !domain!...
    nslookup !domain! >nul 2>nul
    if !errorlevel! equ 0 (
        echo !domain! resolved successfully.
        echo !domain!>>"%outputfile%"
    ) else (
        echo Failed to resolve !domain!
    )
)

echo.
echo Resolved domains are saved in %outputfile%.

endlocal
