@echo off
setlocal enabledelayedexpansion

rem ✅ קבלת פרמטרים
set "ITEM_NAME=%~1"
set "PRICE_BEFORE_TAX=%~2"

rem ✅ אתחול משתנים
set "HAS_ERRORS=0"
set "ERROR_MESSAGE="

rem ✅ הצגת דיבאג
echo [DEBUG] ITEM_NAME=%ITEM_NAME%
echo [DEBUG] PRICE_BEFORE_TAX=%PRICE_BEFORE_TAX%

rem ✅ בדיקת שם המוצר - רק אותיות ורווחים מותרים
echo %ITEM_NAME% | findstr /R "^[A-Za-z ]*$" >nul || (
    echo [ERROR] Invalid item name: Only letters and spaces are allowed.
    set "ERROR_MESSAGE=!ERROR_MESSAGE!<li>Invalid item name: Only letters and spaces allowed.</li>"
    set "HAS_ERRORS=1"
)

rem ✅ בדיקת מחיר - לוודא שהוא מספר בלבד
set /a "TEST_NUM=%PRICE_BEFORE_TAX%" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Invalid price: Price must be a numeric value.
    set "ERROR_MESSAGE=!ERROR_MESSAGE!<li>Invalid price: Must be a numeric value.</li>"
    set "HAS_ERRORS=1"
)

rem ✅ הדפסת דיבאג אחרי הבדיקות
echo [DEBUG] ITEM_NAME=%ITEM_NAME%, PRICE_BEFORE_TAX=%PRICE_BEFORE_TAX%

rem ✅ אם אין שגיאות – חישוב מחיר כולל מע"מ
if "%HAS_ERRORS%"=="0" (
    set /a "VAT_AMOUNT=(PRICE_BEFORE_TAX * 18) / 100"
    set /a "FINAL_PRICE=PRICE_BEFORE_TAX + VAT_AMOUNT"
)

rem ✅ יצירת דוח HTML
(
echo ^<html^>
echo ^<head^>
echo ^<meta charset="UTF-8"^>
echo ^<style^>
echo body { font-family: Arial, sans-serif; margin: 40px; }
echo h1 { color: #333; }
echo .price { font-weight: bold; color: #0066cc; }
echo .error { color: #ff0000; font-weight: bold; }
echo .success { color: #008000; }
echo ul.error-list { list-style-type: disc; padding-left: 20px; }
echo ul.error-list li { margin: 5px 0; }
echo ^</style^>
echo ^</head^>
echo ^<body^>
echo ^<h1^>Price Calculation Report^</h1^>

if "%HAS_ERRORS%"=="1" (
    echo ^<div class="error"^>
    echo ^<h2^>Errors Detected:</h2^>
    echo ^<ul class="error-list"^>!ERROR_MESSAGE!^</ul^>
    echo ^</div^>
) else (
    echo ^<p^>Item Name: %ITEM_NAME%^</p^>
    echo ^<p^>Price Before VAT: %PRICE_BEFORE_TAX% NIS^</p^>
    echo ^<p^>VAT ^(18%%^): %VAT_AMOUNT% NIS^</p^>
    echo ^<p class="price success"^>Final Price: %FINAL_PRICE% NIS^</p^>
)

echo ^</body^>
echo ^</html^>
) > output.html

rem ✅ פלט מסוף ברור
if "%HAS_ERRORS%"=="1" (
    echo [WARNING] Validation errors detected. Check the HTML report for details.
    exit /b 1
) else (
    echo [SUCCESS] Price calculation completed successfully!
    exit /b 0
)
