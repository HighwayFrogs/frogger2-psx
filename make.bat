@echo OFF
SET COUNTRY_CODE=%1%

:country_select
if "%COUNTRY_CODE%"=="E" goto country_ok
if "%COUNTRY_CODE%"=="A" goto country_ok

echo Please choose which version you'd like to build.
echo.
echo A) NTSC (USA)
echo E) PAL (EUR)
echo.

set /p COUNTRY_CODE=
goto country_select

:country_ok

REM Calling PSPATHS.BAT will replace your %PATH% with one which has access to the SDK executables for this session only.
REM Unfortunately, we can't keep the existing path, we must delete it. This is because Borland make doesn't handle paths above a certain size, and will give the error "Command arguments too long".
CALL SDK\PSPATHS.BAT

REM Setup temp directory with copied code.
if not exist BUILD md BUILD
if not exist BUILD\TEMP md BUILD\TEMP
if not exist BUILD\Burn md BUILD\Burn
del BUILD\TEMP /Q
del BUILD\burn\SLUS_011.72
del BUILD\burn\SLES_028.53
copy FroggerProject\Common BUILD\TEMP
copy FroggerProject\psx BUILD\TEMP

:: Move to working folder.
cd BUILD\TEMP

:: Update linker file.
if "%COUNTRY_CODE%"=="A" replace_line frogger.lnk frogger.lnk "%%LIBCRYPT_CONDITIONAL_INCLUDE%%" "inclib\t""libcrypt.lib"""
if "%COUNTRY_CODE%"=="E" replace_line frogger.lnk frogger.lnk "%%LIBCRYPT_CONDITIONAL_INCLUDE%%" "; Skipping libcrypt due to PAL build."

:: Update cam.c
:: This is here purely to allow for a perfectly (byte for byte) matching executable.
:: The PAL version removes the #include menus.h line, but the NTSC version has it.
:: Normally for differences we use compiler flags. However, line numbers are used in allocation error messages.
:: We can't use compiler flags to spoof line numbers, and I figured since it only happens once, the simplest solution would be to do this.
:: If you plan to to modifications to the code, this might as well be removed.
:: It's here exclusively to make matching byte-for-byte PAL builds.
if "%COUNTRY_CODE%"=="A" replace_line cam.c cam.c "%%PLACEHOLDER_LINE_MATCHER%%\n" "#include ""menus.h""\n"
if "%COUNTRY_CODE%"=="E" replace_line cam.c cam.c "%%PLACEHOLDER_LINE_MATCHER%%\n" ""

:: Setup makefile.
copy makefile.txt makefile.mak
depend *.c >>makefile.mak

:: Make Frogger 2 executable.
if "%COUNTRY_CODE%"=="A" make -B -DMASTER=1 -DPAL=0
if "%COUNTRY_CODE%"=="E" make -B -DMASTER=1 -DPAL=1

:: Verify Frogger 2 executable was made.
if errorlevel 1 goto error
if NOT EXIST frogger.cpe goto error

:: Convert Frogger 2 executable to PSX-EXE.
cpe2exe frogger.cpe %COUNTRY_CODE% 0x801ffff0
if NOT EXIST frogger.exe goto error

:: Move output to burn folder.
cd ..\
if "%COUNTRY_CODE%"=="A"  move TEMP\frogger.exe burn\SLUS_011.72
if "%COUNTRY_CODE%"=="E"  move TEMP\frogger.exe burn\SLES_028.53
copy TEMP\frogger.map burn
copy TEMP\frogger.sym burn

if "%COUNTRY_CODE%"=="A"  copy sys_a.cnf burn\system.cnf
if "%COUNTRY_CODE%"=="E"  copy sys_e.cnf burn\system.cnf

:: CREATE DAT FILE
if EXIST burn\frogger.dat del burn\frogger.dat
copy TEMP\*.bin Files
cd Files

datstak /r ..\burn\frogger.dat
if errorlevel 1 goto error
cd ..\

:: Create .bin/.cue CD image.
if not exist CD md CD
if exist CD\FROGGER2.bin del CD\FROGGER2.bin
if exist CD\FROGGER2.cue del CD\FROGGER2.cue
mkpsxiso --output CD\FROGGER2.bin --cuefile CD\FROGGER2.cue Burn/Disc-%COUNTRY_CODE%.xml
if errorlevel 1 goto error

goto okay

:error
echo *** There Were Errors ***
PAUSE
goto :EOF

:okay
echo Success
PAUSE