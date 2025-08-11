@echo off
REM ==========================================================
REM Move to the project root directory
REM "%~dp0" : Path to this batch file's directory
REM "\.."   : Go one level up from the script folder
REM /d      : Allows changing drive letters as well
REM ==========================================================
cd /d "%~dp0\.."
echo Current directory is: %CD%

REM ==========================================================
REM Launch a new minimized command prompt window
REM Run the Tcl script "waves/run.tcl" using tclsh
REM start /min  : Open minimized window
REM cmd /c      : Execute command and then close window
REM ==========================================================
start /min cmd /c "tclsh waves/run.tcl"