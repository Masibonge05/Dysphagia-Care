@echo off
echo =========================================
echo Searching for APK in all possible locations...
echo =========================================
echo.

cd /d "%~dp0"

echo Checking android folder structure...
if exist "android\app\build\outputs" (
    echo Found outputs folder!
    dir /s /b "android\app\build\outputs\*.apk" 2>nul
)

echo.
echo Checking main build folder...
if exist "build" (
    echo Found build folder!
    dir /s /b "build\*.apk" 2>nul
)

echo.
echo Searching entire android directory for ANY apk...
dir /s /b "android\*.apk" 2>nul

echo.
echo =========================================
echo Search complete!
echo =========================================
echo.
echo If you see file paths above, those are your APK files!
echo If you see "File Not Found" - the APK wasn't created.
echo.

pause

