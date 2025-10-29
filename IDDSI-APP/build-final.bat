@echo off
echo =============================================
echo Flutter APK Builder (No Shrinking)
echo =============================================
echo.

cd /d "%~dp0"

echo Step 1: Cleaning old build files...
echo.
call flutter clean
if errorlevel 1 (
    echo ERROR: Flutter clean failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Getting dependencies...
echo.
call flutter pub get
if errorlevel 1 (
    echo ERROR: Flutter pub get failed!
    pause
    exit /b 1
)

echo.
echo Step 3: Building APK using Gradle...
echo This will take several minutes - please wait!
echo.
cd android
call gradlew.bat clean
call gradlew.bat assembleRelease
set BUILD_RESULT=%errorlevel%
cd ..

if %BUILD_RESULT% neq 0 (
    echo.
    echo =============================================
    echo ERROR: Build failed with error code %BUILD_RESULT%
    echo =============================================
    echo.
    pause
    exit /b %BUILD_RESULT%
)

echo.
echo =============================================
echo BUILD COMPLETED!
echo =============================================
echo.

REM Check for APK in multiple locations
set APK_FOUND=0

if exist "android\app\build\outputs\apk\release\app-release.apk" (
    echo APK Found at: android\app\build\outputs\apk\release\app-release.apk
    start "" "android\app\build\outputs\apk\release"
    set APK_FOUND=1
)

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo APK Found at: build\app\outputs\flutter-apk\app-release.apk
    start "" "build\app\outputs\flutter-apk"
    set APK_FOUND=1
)

if %APK_FOUND%==0 (
    echo.
    echo WARNING: Build completed but APK not found in expected locations!
    echo Searching for APK files...
    dir /s /b *.apk
    echo.
)

echo.
pause

