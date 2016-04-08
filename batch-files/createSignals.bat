@ECHO OFF

REM SKRIPT ZUM ERSTELLEN VON SIGNALDATEIEN

FOR /f "DELIMS=" %%a IN ('dir *.zip /b /s') DO (
	
	copy NUL "%%~dp$PATH:a%%~na%%~xa.signal"
	REM ECHO Fully Qualified Path : %%~fa
	REM ECHO Located on Drive     : %%~da
	REM ECHO Location in the PATH : %%~dp$PATH:a
)
