# PowerShell Script to Move Flutter Project to Clean Path
# Run this script as Administrator

$oldPath = "C:\Users\Njabulo Sibambo 2\OneDrive - University of Johannesburg\Desktop\Dysphagia-Care\IDDSI-APP"
$newPath = "C:\FlutterProjects\DysphagiaCare\IDDSI-APP"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Flutter Project Mover" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will move your project from:" -ForegroundColor Yellow
Write-Host "  $oldPath" -ForegroundColor White
Write-Host ""
Write-Host "To:" -ForegroundColor Yellow
Write-Host "  $newPath" -ForegroundColor White
Write-Host ""

# Create parent directory if it doesn't exist
$parentDir = Split-Path -Parent $newPath
if (!(Test-Path $parentDir)) {
    Write-Host "Creating directory: $parentDir" -ForegroundColor Green
    New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
}

# Check if old path exists
if (!(Test-Path $oldPath)) {
    Write-Host "ERROR: Source path not found!" -ForegroundColor Red
    Write-Host "Please update the script with your correct path." -ForegroundColor Yellow
    pause
    exit
}

# Check if new path already exists
if (Test-Path $newPath) {
    Write-Host "WARNING: Destination already exists!" -ForegroundColor Red
    $response = Read-Host "Delete existing and continue? (yes/no)"
    if ($response -ne "yes") {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
        pause
        exit
    }
    Remove-Item -Path $newPath -Recurse -Force
}

# Copy the project
Write-Host ""
Write-Host "Copying project files..." -ForegroundColor Green
Copy-Item -Path $oldPath -Destination $newPath -Recurse -Force

# Clean build artifacts in new location
Write-Host "Cleaning build artifacts..." -ForegroundColor Green
$buildFolders = @(
    "$newPath\build",
    "$newPath\android\.gradle",
    "$newPath\android\app\build"
)

foreach ($folder in $buildFolders) {
    if (Test-Path $folder) {
        Remove-Item -Path $folder -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "SUCCESS! Project moved successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "New location: $newPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Open VS Code in the new location:" -ForegroundColor White
Write-Host "   cd $newPath" -ForegroundColor Gray
Write-Host "   code ." -ForegroundColor Gray
Write-Host ""
Write-Host "2. Run these commands:" -ForegroundColor White
Write-Host "   flutter clean" -ForegroundColor Gray
Write-Host "   flutter pub get" -ForegroundColor Gray
Write-Host "   flutter build apk --release" -ForegroundColor Gray
Write-Host ""
pause

