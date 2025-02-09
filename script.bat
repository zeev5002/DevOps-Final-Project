@echo off
setlocal enabledelayedexpansion

:: ???? ??????? ????? ??????
set NAME=%~1
set TODAY_DATE=%~2
set BIRTH_DATE=%~3

:: ????? ????? ??????? ????????? ??????? ????
echo INFO: Received NAME: %NAME%
echo INFO: Received TODAY_DATE: %TODAY_DATE%
echo INFO: Received BIRTH_DATE: %BIRTH_DATE%

:: ????? ????? ?????? ????? ?? ??
set ERROR_MESSAGE=

:: ??????? ?? ?????? (DD-MM-YYYY)
set FORMAT_CHECK=^[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]$
echo %TODAY_DATE% | findstr /R %FORMAT_CHECK% >nul || set ERROR_MESSAGE=%ERROR_MESSAGE% WARNING: TODAY_DATE format is incorrect. Expected DD-MM-YYYY.^&
echo %BIRTH_DATE% | findstr /R %FORMAT_CHECK% >nul || set ERROR_MESSAGE=%ERROR_MESSAGE% WARNING: BIRTH_DATE format is incorrect. Expected DD-MM-YYYY.^&

:: ????? ??????? ?????? DD-MM-YYYY
for /f "tokens=1-3 delims=-" %%a in ("%TODAY_DATE%") do (
    set TODAY_DAY=%%a
    set TODAY_MONTH=%%b
    set TODAY_YEAR=%%c
)

for /f "tokens=1-3 delims=-" %%a in ("%BIRTH_DATE%") do (
    set BIRTH_DAY=%%a
    set BIRTH_MONTH=%%b
    set BIRTH_YEAR=%%c
)

:: ????? ???????? ???? ??????
echo INFO: Parsed TODAY: Day=%TODAY_DAY%, Month=%TODAY_MONTH%, Year=%TODAY_YEAR%
echo INFO: Parsed BIRTH: Day=%BIRTH_DAY%, Month=%BIRTH_MONTH%, Year=%BIRTH_YEAR%

:: ????? ????????? ???? ????? (?????? Invalid number)
if "%TODAY_DAY%"=="" set TODAY_DAY=0
if "%TODAY_MONTH%"=="" set TODAY_MONTH=0
if "%TODAY_YEAR%"=="" set TODAY_YEAR=0
if "%BIRTH_DAY%"=="" set BIRTH_DAY=0
if "%BIRTH_MONTH%"=="" set BIRTH_MONTH=0
if "%BIRTH_YEAR%"=="" set BIRTH_YEAR=0

:: ????? ???? (????, ??????, ????) ?? ?? ??? ?????? ???????
if not "%ERROR_MESSAGE%"=="" (
    echo.
    echo WARNING: **Validation Warnings:**
    echo %ERROR_MESSAGE%
    echo WARNING: **The script will continue running, but please review the warnings above.**
) else (
    set /a YEARS=%TODAY_YEAR% - %BIRTH_YEAR%
    set /a MONTHS=%TODAY_MONTH% - %BIRTH_MONTH%
    set /a DAYS=%TODAY_DAY% - %BIRTH_DAY%

    :: ????? ????? ?? ????? ???????
    if %DAYS% lss 0 (
        set /a DAYS+=30
        set /a MONTHS-=1
    )

    if %MONTHS% lss 0 (
        set /a MONTHS+=12
        set /a YEARS-=1
    )

    :: ????? ???? ?????
    echo INFO: Calculated Age: %YEARS% years, %MONTHS% months, %DAYS% days
)

:: ????? ???? HTML
(
echo ^<html^>
echo ^<body^>
echo ^<h1^>Age Calculation Result^</h1^>
echo ^<p^>Name: %NAME%^</p^>
echo ^<p^>Today: %TODAY_DATE%^</p^>
echo ^<p^>Birth Date: %BIRTH_DATE%^</p^>
if not "%ERROR_MESSAGE%"=="" (
    echo ^<p style="color:red;"^>WARNING: Validation Warnings: %ERROR_MESSAGE%^</p^>
) else (
    echo ^<p^>Age: %YEARS% years, %MONTHS% months, %DAYS% days^</p^>
)
echo ^</body^>
echo ^</html^>
) > output.html

echo SUCCESS: HTML report generated successfully!
