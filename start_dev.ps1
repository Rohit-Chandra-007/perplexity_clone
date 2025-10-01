# Perplexity AI Clone - Development Environment Starter
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Perplexity AI Clone - Dev Environment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Flutter installation
Write-Host "[1/4] Checking Flutter setup..." -ForegroundColor Yellow
try {
    $flutterVersion = flutter --version 2>$null
    Write-Host "Flutter found!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Flutter not found. Please install Flutter first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Start Backend Server
Write-Host ""
Write-Host "[2/4] Starting Backend Server..." -ForegroundColor Yellow
$backendJob = Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd server; Write-Host 'Starting FastAPI backend...' -ForegroundColor Green; uv run python main.py" -PassThru

# Wait for backend to initialize
Write-Host "[3/4] Waiting for backend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# Start Flutter App
Write-Host "[4/4] Starting Flutter App..." -ForegroundColor Yellow
$frontendJob = Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'Starting Flutter app...' -ForegroundColor Green; flutter run -d chrome" -PassThru

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Services Started Successfully!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backend:  http://localhost:8000" -ForegroundColor Green
Write-Host "Frontend: Will open in Chrome automatically" -ForegroundColor Green
Write-Host ""
Write-Host "Expected Status:" -ForegroundColor Yellow
Write-Host "- WebSocket: Connected" -ForegroundColor White
Write-Host "- Firebase: Local storage fallback (orange)" -ForegroundColor White
Write-Host "- Chat: Fully functional" -ForegroundColor White
Write-Host ""
Write-Host "Both services are running in separate windows." -ForegroundColor Cyan
Write-Host "Close those windows to stop the services." -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit this window..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")