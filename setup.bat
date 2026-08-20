@echo off
REM Travel Reservation System - Quick Setup Script for Windows

echo.
echo ============================================
echo Travel Reservation Backend Setup
echo ============================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js is not installed!
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)

echo ✓ Node.js found
echo.

REM Check if MySQL is running
(for /f %%A in ('tasklist ^| find /i "mysqld"') do set mysql_running=true) >nul 2>&1
if not defined mysql_running (
    echo ⚠ WARNING: MySQL service may not be running
    echo Please start MySQL before running this script
    echo.
)

REM Navigate to backend folder
cd backend

echo.
echo Installing dependencies...
echo.
call npm install

echo.
echo.
echo ============================================
echo Setup Complete!
echo ============================================
echo.
echo Next steps:
echo 1. Edit backend/.env with your MySQL credentials
echo 2. Import database schema:
echo    mysql -u root -p < database.sql
echo 3. Start backend server:
echo    npm run dev
echo 4. Open frontend with Live Server
echo.
echo Frontend pages to use:
echo - login-api.html
echo - register-api.html
echo - search-api.html
echo - booking-api.html
echo - my-bookings-api.html
echo - admin-api.html
echo.

pause
