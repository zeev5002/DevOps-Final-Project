@echo off
setlocal enabledelayedexpansion

:: קבלת פרמטרים
set ITEM_NAME=%~1
set PRICE_BEFORE_TAX=%~2
set ERROR_MESSAGE=

:: בדיקת אם הערכים ריקים
if "%ITEM_NAME%"=="" set ERROR_MESSAGE=!ERROR_MESSAGE! ERROR: Item name is missing.^&
if "%PRICE_BEFORE_TAX%"=="" set ERROR_MESSAGE=!ERROR_MESSAGE! ERROR: Price before VAT is missing.^&

:: בדיקת שם הפריט – רק אותיות ורווחים מותרים
echo %ITEM_NAME% | findstr /R "^[A-Za-z ]*$" >nul || (
    set ERROR_MESSAGE=!ERROR_MESSAGE! WARNING: Item name must contain only letters and spaces.^&
    set ITEM_NAME=Unknown
)

:: בדיקת מחיר – חייב להיות מספר בלבד
echo %PRICE_BEFORE_TAX% | findstr /R "^[0-9]*$" >nul || (
    set ERROR_MESSAGE=!ERROR_MESSAGE! ERROR: Price must be a valid number.^&
    set PRICE_BEFORE_TAX=0
)

:: המרת מספר לבדיקה
set /a CHECK_NUM=%PRICE_BEFORE_TAX% 2>nul || set PRICE_BEFORE_TAX=0

:: חישוב המע"מ (18%) ומחיר סופי
set /a VAT_AMOUNT=%PRICE_BEFORE_TAX% * 18 / 100
set /a FINAL_PRICE=%PRICE_BEFORE_TAX% + %VAT_AMOUNT%

:: יצירת קובץ HTML עם התוצאות
(
echo ^<html^>
echo ^<body^>
echo ^<h1^>Price Calculation Report^</h1^>
if not "!ERROR_MESSAGE!"=="" (
    echo ^<p style="color:red;"^>!ERROR_MESSAGE!^</p^>
)
echo ^<p^>Item Name: %ITEM_NAME%^</p^>
echo ^<p^>Price Before VAT: %PRICE_BEFORE_TAX% ₪^</p^>
echo ^<p^>VAT (18%%): %VAT_AMOUNT% ₪^</p^>
echo ^<p^><b>Final Price: %FINAL_PRICE% ₪</b>^</p^>
echo ^</body^>
echo ^</html^>
) > output.html

echo [SUCCESS] Price calculation completed successfully!
