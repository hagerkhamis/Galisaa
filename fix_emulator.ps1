# Android Emulator Fix Script
# Run this script as Administrator if needed

Write-Host "=== Android Emulator Fix ===" -ForegroundColor Cyan
Write-Host ""

# Step 1: Kill all emulator processes
Write-Host "[1/6] Stopping emulator processes..." -ForegroundColor Yellow
adb kill-server 2>$null
taskkill /F /IM qemu-system-x86_64.exe 2>$null
taskkill /F /IM emulator.exe 2>$null
Start-Sleep -Seconds 2
Write-Host "OK - Processes stopped" -ForegroundColor Green

# Step 2: Check Android SDK
Write-Host "[2/6] Checking Android SDK..." -ForegroundColor Yellow
$env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk"
if (-not (Test-Path $env:ANDROID_HOME)) {
    Write-Host "ERROR - Android SDK not found at: $env:ANDROID_HOME" -ForegroundColor Red
    Write-Host "  Please install Android Studio first" -ForegroundColor Red
    exit 1
}
Write-Host "OK - Android SDK found at: $env:ANDROID_HOME" -ForegroundColor Green

# Step 3: Check cmdline-tools
Write-Host "[3/6] Checking cmdline-tools..." -ForegroundColor Yellow
$cmdlineTools = "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat"
if (-not (Test-Path $cmdlineTools)) {
    Write-Host "ERROR - cmdline-tools is MISSING!" -ForegroundColor Red
    Write-Host "  Install it from Android Studio:" -ForegroundColor Yellow
    Write-Host "  Tools -> SDK Manager -> SDK Tools -> Android SDK Command-line Tools" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Or download from: https://developer.android.com/studio#command-line-tools-only" -ForegroundColor Yellow
} else {
    Write-Host "OK - cmdline-tools found" -ForegroundColor Green
}

# Step 4: Check Emulator
Write-Host "[4/6] Checking Emulator..." -ForegroundColor Yellow
$emulatorPath = "$env:ANDROID_HOME\emulator\emulator.exe"
if (Test-Path $emulatorPath) {
    Write-Host "OK - Emulator found" -ForegroundColor Green
} else {
    Write-Host "ERROR - Emulator not found!" -ForegroundColor Red
}

# Step 5: Try to accept licenses (if cmdline-tools exists)
if (Test-Path $cmdlineTools) {
    Write-Host "[5/6] Attempting to accept Android licenses..." -ForegroundColor Yellow
    Write-Host "  Run manually: flutter doctor --android-licenses" -ForegroundColor Yellow
} else {
    Write-Host "[5/6] Skipping license acceptance (cmdline-tools missing)" -ForegroundColor Yellow
}

# Step 6: Clean old emulator files
Write-Host "[6/6] Checking for old emulator files..." -ForegroundColor Yellow
$avdPaths = @(
    "$env:ANDROID_HOME\.android\avd",
    "$env:USERPROFILE\.android\avd"
)

$foundAVD = $false
foreach ($avdPath in $avdPaths) {
    if (Test-Path "$avdPath\Pixel_5.avd") {
        Write-Host "  Found AVD at: $avdPath" -ForegroundColor Cyan
        $foundAVD = $true
    }
}

if (-not $foundAVD) {
    Write-Host "  No old AVD files found" -ForegroundColor Gray
}

Write-Host ""
Write-Host "=== Next Steps ===" -ForegroundColor Cyan
Write-Host "1. If cmdline-tools is missing, install it from Android Studio" -ForegroundColor White
Write-Host "2. Run: flutter doctor --android-licenses" -ForegroundColor White
Write-Host "3. If needed, delete and recreate the emulator:" -ForegroundColor White
Write-Host "   flutter emulators --delete Pixel_5" -ForegroundColor Yellow
Write-Host "   flutter emulators --create --name Pixel_5" -ForegroundColor Yellow
Write-Host "4. Run: flutter doctor -v to verify setup" -ForegroundColor White
Write-Host "5. Launch emulator: flutter emulators --launch Pixel_5" -ForegroundColor White
Write-Host ""
