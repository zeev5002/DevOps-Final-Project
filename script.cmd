@echo off
setlocal enabledelayedexpansion

rem ✅ קבלת פרמטרים
set "USER_INPUT=%~1"

rem ✅ בדיקת קלט - לוודא שהוא מספר בלבד
echo %USER_INPUT% | findstr /R "^[0-9][0-9]*$" >nul || (
    echo [ERROR] Invalid input. Please enter a positive integer.
    (
        echo ^<html^>
        echo ^<head^>
        echo ^<meta charset="UTF-8"^>
        echo ^</head^>
        echo ^<body^>
        echo ^<h1^>Fibonacci Check Result^</h1^>
        echo ^<p style="color:red;"^>❌ Invalid input. Please enter a positive integer.^</p^>
        echo ^</body^>
        echo ^</html^>
    ) > output.html
    exit /b 1
)

rem ✅ בדיקת אם המספר שייך לרצף פיבונאצ'י
call :is_fibonacci %USER_INPUT%
set "IS_FIBONACCI=%errorlevel%"

if "%IS_FIBONACCI%"=="0" (
    echo %USER_INPUT% is a Fibonacci number.
    call :find_fibonacci_index %USER_INPUT%
    set "FIB_INDEX=!FIBONACCI_INDEX!"
) else (
    echo %USER_INPUT% is NOT a Fibonacci number.
    set "FIB_INDEX=-1"
)

rem ✅ יצירת דוח HTML
(
    echo ^<html^>
    echo ^<head^>
    echo ^<meta charset="UTF-8"^>
    echo ^</head^>
    echo ^<body^>
    echo ^<h1^>Fibonacci Check Result^</h1^>
    echo ^<p^>Input Number: %USER_INPUT%^</p^>
    if "%IS_FIBONACCI%"=="0" (
        echo ^<p style="color:green;"^>✅ %USER_INPUT% is a Fibonacci number.^</p^>
        echo ^<p^>Index in Fibonacci Sequence: %FIB_INDEX%^</p^>
    ) else (
        echo ^<p style="color:red;"^>❌ %USER_INPUT% is NOT a Fibonacci number.^</p^>
    )
    echo ^</body^>
    echo ^</html^>
) > output.html

exit /b 0

rem ✅ פונקציה לבדוק אם מספר שייך לפיבונאצ'י
:is_fibonacci
set /a "a=0, b=1, index=0"
:loop
if "%a%"=="%1" exit /b 0
if "%a%" gtr "%1" exit /b 1
set /a "temp=a, a=b, b=temp+b, index+=1"
goto loop

rem ✅ פונקציה למציאת אינדקס של מספר בפיבונאצ'י
:find_fibonacci_index
set /a "a=0, b=1, FIBONACCI_INDEX=0"
:index_loop
if "%a%"=="%1" exit /b 0
if "%a%" gtr "%1" exit /b 1
set /a "temp=a, a=b, b=temp+b, FIBONACCI_INDEX+=1"
goto index_loop
