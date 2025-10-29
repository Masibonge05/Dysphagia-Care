# Navigate to the Flutter project directory (using symlink to avoid spaces)
cd C:\Dysphagia-Care\IDDSI-APP

# Clean the project
Write-Host "Cleaning Flutter project..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get

# Build the APK
Write-Host "Building APK..." -ForegroundColor Yellow
flutter build apk --release

Write-Host "`nAPK build completed! APK location: build/app/outputs/flutter-apk/app-release.apk" -ForegroundColor Green

