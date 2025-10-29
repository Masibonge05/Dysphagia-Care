@echo off
echo =========================================
echo Opening APK Location
echo =========================================
echo.

REM Check the custom build directory
set BUILD_DIR=C:\Dysphagia-Care\build

if exist "%BUILD_DIR%" (
    echo APK should be in: %BUILD_DIR%
    echo.
    echo Opening folder...
    start "" explorer "%BUILD_DIR%"
    
    echo.
    echo Look for folders like:
    echo - app\outputs\apk\release
    echo - intermediates\apk\release
    echo.
) else (
    echo Build directory not found at: %BUILD_DIR%
)

pause

