@echo off
setlocal disableDelayedExpansion
for /f "delims=" %%F in ('dir /b /s *.sgm.transformiert.xml') do (
  set "old=%%F"
  set "new=%%~nF"
  setlocal enableDelayedExpansion
  REM -18 ist die Länge des weggekürzten TEILS! bei Bedarf anpassen!
  ren "!old!" "!new:~0,-18!.xml"
  endlocal
)