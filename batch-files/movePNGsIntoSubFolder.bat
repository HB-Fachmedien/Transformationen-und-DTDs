@ECHO OFF
FOR /f %%a IN ('dir *.png /b /s') DO (
	md "%%~paimg"
	MOVE %%a "%%~paimg"
)

REM Batch, welches die Ordnerstruktur nach PDF Dateien durchsucht und diese in einen generierten Unterordner verschiebt