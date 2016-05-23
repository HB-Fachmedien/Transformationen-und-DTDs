@echo off

set FILELIST=C:\temp\list.txt
set FILESPATH=Z:\Duesseldorf\Fachverlag\Fachbereiche\EP\Maibücher\Datenlieferung\AR_2004-15-Maerz-hbfm-format
set DESTPATH=C:\Users\maibuecher\Desktop\temp\ar\noch-keine-gerichtsdaten


for /f %%X in (%FILELIST%) do call :COPY_FILES "%%X"
goto :eof

:COPY_FILES
for /r %FILESPATH% %%I in (%~1) do xcopy /qv "%%I" "%DESTPATH%%%~pnxI"