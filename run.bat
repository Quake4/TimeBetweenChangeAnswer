@echo off
cd /D "%~dp0"
powershell -version 5.0 -executionpolicy bypass -noprofile -command "&.\Run.ps1 %1 %2"
pause