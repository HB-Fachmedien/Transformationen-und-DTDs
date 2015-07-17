@ECHO OFF

REM For /R  %%G IN (*.sgm) do Echo  "%%G"
For /R  %%G IN (*.sgm) do sx.exe -xcdata temp.dtd  %%G > %%G.xml

For /R  %%G IN (*.sgm) do del %%G