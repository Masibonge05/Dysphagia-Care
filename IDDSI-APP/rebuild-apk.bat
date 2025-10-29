@echo off
echo =============================================
echo Rebuilding APK with Fixed Signing
echo =============================================
echo.

cd /d "%~dp0"

echo Step 1: Cleaning...
call flutter clean
echo.

echo Step 2: Getting dependencies...
call flutter pub get
echo.

echo Step 3: Building APK with proper signing...
echo This will take several minutes...
echo.
cd android
call gradlew.bat clean assembleRelease
cd ..

echo.
echo =============================================
echo BUILD COMPLETE!
echo =============================================
echo.

REM Check custom build location
set BUILD_DIR=C:\Dysphagia-Care\build

if exist "%BUILD_DIR%\app\outputs\apk\release\app-release.apk" (
    echo APK found at: %BUILD_DIR%\app\outputs\apk\release\app-release.apk
    echo.
    echo Opening folder...
    start "" explorer "%BUILD_DIR%\app\outputs\apk\release"
) else (
    echo Checking alternate location...
    if exist "android\app\build\outputs\apk\release\app-release.apk" (
        echo APK found at: android\app\build\outputs\apk\release\app-release.apk
        start "" explorer "android\app\build\outputs\apk\release"
    ) else (
        echo Searching for APK...
        dir /s /b *.apk 2>nul
    )
)

echo.
pause

