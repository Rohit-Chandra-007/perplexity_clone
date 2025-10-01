@echo off
echo ========================================
echo   Perplexity AI Clone - Dev Environment
echo ========================================
echo.

echo [1/4] Checking Flutter setup...
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Flutter not found. Please install Flutter first.
    pause
    exit /b 1
)
echo Flutter found!

echo.
echo [2/4] Starting Backend Server...
cd /d "%~dp0"
start "Backend Server" cmd /k "cd server & echo Starting FastAPI backend... & uv run python main.py"

echo [3/4] Waiting for backend to initialize...
timeout /t 3 /nobreak >nul

echo [4/4] Starting Flutter App...
start "Flutter App" cmd /k "echo Starting Flutter app... & flutter run -d chrome"

echo.
echo ========================================
echo   Services Started Successfully!
echo ========================================
echo.
echo Backend:  http://localhost:8000
echo Frontend: Will open in Chrome automatically
echo.
echo Expected Status:
echo - WebSocket: Connected
echo - Firebase: Local storage fallback (orange)
echo - Chat: Fully functional
echo.
echo Both services are running in separate windows.
echo Close those windows to stop the services.
echo.
echo Press any key to exit this window...
pause >nul