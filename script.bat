@echo off
setlocal enabledelayedexpansion

:: קבלת פרמטרים מ-Jenkins
set NAME=%1
set TODAY_DATE=%2
set BIRTH_DATE=%3

:: ולידציה בסיסית לתאריכים
set FORMAT_CHECK=^[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]$
echo %TODAY_DATE% | findstr /R %FORMAT_CHECK% >nul || echo ⚠️ Warning: TODAY_DATE format is incorrect. Expected DD-MM-YYYY.
echo %BIRTH_DATE% | findstr /R %FORMAT_CHECK% >nul || echo ⚠️ Warning: BIRTH_DATE format is incorrect. Expected DD-MM-YYYY.

:: פיצול תאריכים לפורמט DD-MM-YYYY
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

:: חישוב הגיל (שנים, חודשים, ימים)
set /a YEARS=%TODAY_YEAR% - %BIRTH_YEAR%
set /a MONTHS=%TODAY_MONTH% - %BIRTH_MONTH%
set /a DAYS=%TODAY_DAY% - %BIRTH_DAY%

if %DAYS% lss 0 (
    set /a DAYS+=30
    set /a MONTHS-=1
)

if %MONTHS% lss 0 (
    set /a MONTHS+=12
    set /a YEARS-=1
)

:: יצירת קובץ HTML
(
echo ^<html^>
echo ^<body^>
echo ^<h1^>Age Calculation Result^</h1^>
echo ^<p^>Name: %NAME%^</p^>
echo ^<p^>Today: %TODAY_DATE%^</p^>
echo ^<p^>Birth Date: %BIRTH_DATE%^</p^>
echo ^<p^>Age: %YEARS% years, %MONTHS% months, %DAYS% days^</p^>
echo ^</body^>
echo ^</html^>
) > output.html
