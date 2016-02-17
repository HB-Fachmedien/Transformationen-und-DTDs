@ECHO OFF
FOR /f %%a IN ('dir *.pdf /b /s') DO (
	md "%%~papdf"
	MOVE %%a "%%~papdf"
)

REM Batch, welches die Ordnerstruktur nach PDF Dateien durchsucht und diese in einen generierten Unterordner verschiebt