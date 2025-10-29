@echo off
echo Searching for your APK file...
echo.

cd /d "%~dp0"

echo Checking location 1: android\app\build\outputs\apk\release
if exist "android\app\build\outputs\apk\release\app-release.apk" (
    echo FOUND! Opening folder...
    start "" "android\app\build\outputs\apk\release"
    goto :found
)

echo Not found there. Checking location 2: build\app\outputs\flutter-apk
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo FOUND! Opening folder...
    start "" "build\app\outputs\flutter-apk"
    goto :found
)

echo.
echo APK not found in expected locations.
echo Searching entire project folder...
echo This may take a moment...
dir /s /b *.apk 2>nul

goto :end

:found
echo.
echo Your APK file: app-release.apk
echo.

:end
pause

