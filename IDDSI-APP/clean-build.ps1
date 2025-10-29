# Clean build directories safely
# This script removes build artifacts without errors if directories don't exist

Write-Host "Cleaning build directories..." -ForegroundColor Cyan

# Get the script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Clean Android build directories
$androidPath = Join-Path $scriptPath "android"
if (Test-Path $androidPath) {
    Write-Host "Checking Android build directories..." -ForegroundColor Yellow
    
    $buildDirs = @(
        (Join-Path $androidPath ".gradle"),
        (Join-Path $androidPath "build"),
        (Join-Path $androidPath "app\build")
    )
    
    foreach ($dir in $buildDirs) {
        if (Test-Path $dir) {
            Write-Host "Removing: $dir" -ForegroundColor Green
            Remove-Item -Recurse -Force $dir -ErrorAction SilentlyContinue
        } else {
            Write-Host "Skipping (not found): $dir" -ForegroundColor DarkGray
        }
    }
} else {
    Write-Host "Android directory not found" -ForegroundColor Yellow
}

# Clean Flutter build directory
$flutterBuildPath = Join-Path $scriptPath "build"
if (Test-Path $flutterBuildPath) {
    Write-Host "Removing Flutter build directory..." -ForegroundColor Green
    Remove-Item -Recurse -Force $flutterBuildPath -ErrorAction SilentlyContinue
} else {
    Write-Host "Flutter build directory not found" -ForegroundColor DarkGray
}

Write-Host "`nClean completed!" -ForegroundColor Cyan

