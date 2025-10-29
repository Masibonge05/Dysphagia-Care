@echo off
echo Building Release APK without shrinking...
echo.

cd /d "%~dp0android"
call gradlew.bat assembleRelease

echo.
echo Build complete!
echo.
echo Opening APK location...
start "" "%~dp0android\app\build\outputs\apk\release"

echo.
echo APK should be at:
echo %~dp0android\app\build\outputs\apk\release\app-release.apk
echo.

pause
