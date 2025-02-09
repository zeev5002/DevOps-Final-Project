@echo off
setlocal enabledelayedexpansion

:: הסרת מרכאות מהפרמטרים שהתקבלו
set NAME=%~1
set TODAY_DATE=%~2
set BIRTH_DATE=%~3

:: הדפסת קלטים לווידוא שהתאריכים מתקבלים נכון
echo 🔹 Received NAME: %NAME%
echo 🔹 Received TODAY_DATE: %TODAY_DATE%
echo 🔹 Received BIRTH_DATE: %BIRTH_DATE%

:: משתנה שמכיל הודעות שגיאה אם יש
set ERROR_MESSAGE=

:: ולידציה של הפורמט (DD-MM-YYYY)
set FORMAT_CHECK=^[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]$
echo %TODAY_DATE% | findstr /R %FORMAT_CHECK% >nul || set ERROR_MESSAGE=%ERROR_MESSAGE%⚠️ Warning: TODAY_DATE format is incorrect. Expected DD-MM-YYYY.^&
echo %BIRTH_DATE% | findstr /R %FORMAT_CHECK% >nul || set ERROR_MESSAGE=%ERROR_MESSAGE%⚠️ Warning: BIRTH_DATE format is incorrect. Expected DD-MM-YYYY.^&

:: פיצול תאריכים לפורמט DD-MM-YYYY (ללא מרכאות)
for /f "tokens=1-3 delims=-" %%a in (%TODAY_DATE%) do (
    set TODAY_DAY=%%a
    set TODAY_MONTH=%%b
    set TODAY_YEAR=%%c
)

for /f "tokens=1-3 delims=-" %%a in (%BIRTH_DATE%) do (
    set BIRTH_DAY=%%a
    set BIRTH_MONTH=%%b
    set BIRTH_YEAR=%%c
)

:: הדפסת התאריכים אחרי הפיצול
echo 🔹 Parsed TODAY: Day=%TODAY_DAY%, Month=%TODAY_MONTH%, Year=%TODAY_YEAR%
echo 🔹 Parsed BIRTH: Day=%BIRTH_DAY%, Month=%BIRTH_MONTH%, Year=%BIRTH_YEAR%

:: בדיקה שהתאריכים אינם ריקים (למניעת Invalid number)
if "%TODAY_DAY%"=="" set ERROR_MESSAGE=%ERROR_MESSAGE%❌ Error: TODAY_DAY is empty!^&
if "%TODAY_MONTH%"=="" set ERROR_MESSAGE=%ERROR_MESSAGE%❌ Error: TODAY_MONTH is empty!^&
if "%TODAY_YEAR%"=="" set ERROR_MESSAGE=%ERROR_MESSAGE%❌ Error: TODAY_YEAR is empty!^&
if "%BIRTH_DAY%"=="" set ERROR_MESSAGE=%ERROR_MESSAGE%❌ Error: BIRTH_DAY is empty!^&
if "%BIRTH_MONTH%"=="" set ERROR_MESSAGE=%ERROR_MESSAGE%❌ Error: BIRTH_MONTH is empty!^&
if "%BIRTH_YEAR%"=="" set ERROR_MESSAGE=%ERROR_MESSAGE%❌ Error: BIRTH_YEAR is empty!^&

:: חישוב הגיל (שנים, חודשים, ימים) רק אם אין שגיאות קריטיות
if not "%ERROR_MESSAGE%"=="" (
    echo.
    echo ⚠️ **Validation Warnings:**
    echo %ERROR_MESSAGE%
    echo ⚠️ **The script will continue running, but please review the warnings above.**
) else (
    set /a YEARS=%TODAY_YEAR% - %BIRTH_YEAR%
    set /a MONTHS=%TODAY_MONTH% - %BIRTH_MONTH%
    set /a DAYS=%TODAY_DAY% - %BIRTH_DAY%

    :: תיקון בעיות של ערכים שליליים
    if %DAYS% lss 0 (
        set /a DAYS+=30
        set /a MONTHS-=1
    )

    if %MONTHS% lss 0 (
        set /a MONTHS+=12
        set /a YEARS-=1
    )

    :: הדפסת הגיל שחושב
    echo 🔹 Calculated Age: %YEARS% years, %MONTHS% months, %DAYS% days
)

:: יצירת קובץ HTML
(
echo ^<html^>
echo ^<body^>
echo ^<h1^>Age Calculation Result^</h1^>
echo ^<p^>Name: %NAME%^</p^>
echo ^<p^>Today: %TODAY_DATE%^</p^>
echo ^<p^>Birth Date: %BIRTH_DATE%^</p^>
if not "%ERROR_MESSAGE%"=="" (
    echo ^<p style="color:red;"^>⚠️ Validation Warnings: %ERROR_MESSAGE%^</p^>
) else (
    echo ^<p^>Age: %YEARS% years, %MONTHS% months, %DAYS% days^</p^>
)
echo ^</body^>
echo ^</html^>
) > output.html

echo ✅ HTML report generated successfully!
