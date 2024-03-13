@echo off

setlocal enabledelayedexpansion

for /f "tokens=*" %%a in (chinalist.txt) do (
    ping -n 1 %%a | findstr /i /c:"Ping request" > nul && (echo %%a is resolved && color 0A) || (echo %%a is not resolved && color 0C)
)

endlocal
