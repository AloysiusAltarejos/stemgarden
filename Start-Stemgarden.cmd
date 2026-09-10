@echo off
setlocal
cd /d "%~dp0"
where node.exe >nul 2>nul
if errorlevel 1 (
  echo Install Node.js LTS from https://nodejs.org/ first, then double-click this file again.
  start "" "https://nodejs.org/"
  pause
  exit /b 1
)
node.exe scripts\launch.mjs
if errorlevel 1 pause
