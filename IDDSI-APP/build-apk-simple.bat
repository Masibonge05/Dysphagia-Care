@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Building Flutter Release APK
echo ========================================
echo.

cd /d "%~dp0"

echo [1/3] Cleaning previous builds...
call flutter clean

echo.
echo [2/3] Getting dependencies...
call flutter pub get

echo.
echo [3/3] Building APK with Gradle (bypassing Flutter CLI)...
cd android
call gradlew.bat clean assembleRelease
cd ..

echo.
echo ========================================
echo Checking for APK...
echo ========================================

set APK_PATH=android\app\build\outputs\apk\release\app-release.apk

if exist "%APK_PATH%" (
    echo.
    echo SUCCESS! APK created at:
    echo %CD%\%APK_PATH%
    echo.
    echo Opening folder...
    start "" "android\app\build\outputs\apk\release"
) else (
    echo.
    echo ERROR: APK not found!
    echo Expected location: %CD%\%APK_PATH%
    echo.
    echo Please check the build output above for errors.
)

echo.
pause

