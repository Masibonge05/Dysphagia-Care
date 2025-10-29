# Complete APK Build Script
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Building Your APK - Do Not Cancel!" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to build directory
Write-Host "Changing to build directory..." -ForegroundColor Yellow
Set-Location "C:\build-temp\IDDSI-APP"

# Copy updated files first
Write-Host "Copying updated files..." -ForegroundColor Yellow
Copy-Item -Path "C:\Users\Njabulo Sibambo 2\OneDrive - University of Johannesburg\Desktop\Dysphagia-Care\IDDSI-APP\lib" -Destination "C:\build-temp\IDDSI-APP\lib" -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item -Path "C:\Users\Njabulo Sibambo 2\OneDrive - University of Johannesburg\Desktop\Dysphagia-Care\IDDSI-APP\pubspec.yaml" -Destination "C:\build-temp\IDDSI-APP\pubspec.yaml" -Force
Copy-Item -Path "C:\Users\Njabulo Sibambo 2\OneDrive - University of Johannesburg\Desktop\Dysphagia-Care\IDDSI-APP\android\app\build.gradle" -Destination "C:\build-temp\IDDSI-APP\android\app\build.gradle" -Force
Copy-Item -Path "C:\Users\Njabulo Sibambo 2\OneDrive - University of Johannesburg\Desktop\Dysphagia-Care\IDDSI-APP\android\app\google-services.json" -Destination "C:\build-temp\IDDSI-APP\android\app\google-services.json" -Force

# Clean
Write-Host "Cleaning Flutter project..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get

# Build APK
Write-Host "Building APK (this will take 5-15 minutes)..." -ForegroundColor Yellow
Write-Host "DO NOT CANCEL THIS PROCESS!" -ForegroundColor Red
flutter build apk --release

# Check if APK was created
$apkPath = "C:\build-temp\IDDSI-APP\build\app\outputs\flutter-apk\app-release.apk"
if (Test-Path $apkPath) {
    Write-Host ""
    Write-Host "===============================================" -ForegroundColor Green
    Write-Host "✅ SUCCESS! APK BUILD COMPLETED!" -ForegroundColor Green
    Write-Host "===============================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your APK is located at:" -ForegroundColor Cyan
    Write-Host $apkPath -ForegroundColor White
    Write-Host ""
    
    # Open the folder
    explorer "C:\build-temp\IDDSI-APP\build\app\outputs\flutter-apk"
} else {
    Write-Host ""
    Write-Host "❌ Build failed or APK not found at expected location" -ForegroundColor Red
}

Write-Host ""
Write-Host "Build process completed." -ForegroundColor Yellow

