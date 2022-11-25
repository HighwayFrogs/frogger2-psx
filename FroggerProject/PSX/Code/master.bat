rem 
rem DIRECTORY STRUCTURE NEEDED
rem 
rem c:\work\froggerproject\build
rem c:\work\froggerproject\build\cd
rem c:\work\froggerproject\build\burn
rem 
rem run from build directory
rem 

 
if "%1%"=="E" goto country_ok
if "%1%"=="A" goto country_ok

echo Unknown country
goto error

:country_ok

erase *.cpe
erase *.obj
erase *.sym
del burn\SLUS_011.72
del burn\SLES_028.53



rem get latest code into build directory

copy ..\..\common .
copy ..\..\psx .
copy makefile.txt makefile.mak
depend *.c >>makefile.mak



if %1==A make -B -DMASTER=1 -DPAL=0
if %1==E make -B -DMASTER=1 -DPAL=1

if errorlevel 1 goto error
if NOT EXIST frogger.cpe goto error

cpe2x /c%1 frogger.cpe
setsp frogger.exe 801fff00

rem ----- now with product codes -----
rem if %1==A  move frogger.exe burn\SLUS_000.00
rem if %1==E  move frogger.exe burn\SLES_000.00
if %1==A  move frogger.exe burn\SLUS_011.72
if %1==E  move frogger.exe burn\SLES_028.53
copy frogger.map burn
copy frogger.sym burn

if %1==A  copy sys_a.cnf burn\system.cnf
if %1==E  copy sys_e.cnf burn\system.cnf

rem CREATE DAT FILE
cd CD
del ..\burn\frogger.dat

copy ..\*.bin

datstak /r ..\frogger.dat
if errorlevel 1 goto error
move ..\frogger.dat ..\burn
cd ..\
goto okay

:error
echo *** There Were Errors ***
goto ending

:okay
echo All Done Okay


:ending
echo Goodbye.