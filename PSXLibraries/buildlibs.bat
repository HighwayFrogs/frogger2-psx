@echo OFF

:: Assembler is 1998-05
SET ASSEMBLER=ASPSX
SET LIB_LINKER=psylib2

REM Calling PSPATHS.BAT will replace your %PATH% with one which has access to the SDK executables for this session only.
REM Unfortunately, we can't keep the existing path, we must delete it. This is because Borland make doesn't handle paths above a certain size, and will give the error "Command arguments too long".
CALL ..\SDK\PSPATHS.BAT


CD Src\

:: Build ISLXA...
cd ISLXa\
del *.obj
%ASSEMBLER% islxa.s -o islxa.obj
IF NOT EXIST Release MD Release
IF EXIST Release\islxa.lib DEL Release\islxa.lib

%LIB_LINKER% /a Release\islxa.lib islxa.obj
:: copy /Y Release\islxa.lib ..\..\Lib\Release
cd ..\

:: Build ISLSfx2...
cd ISLSfx2\
del *.obj
%ASSEMBLER% islsfx2.s -o islsfx2.obj
IF NOT EXIST Release MD Release
IF EXIST Release\islsfx2.lib DEL Release\islsfx2.lib

%LIB_LINKER% /a Release\islsfx2.lib islsfx2.obj
copy /Y Release\islsfx2.lib ..\..\Lib\Release
cd ..\


:: DONE
PAUSE
