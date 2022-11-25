xcopy /D /U ..\..\*.c c:
xcopy /D /U ..\..\*.h c:
xcopy /D /U ..\*.* c:
xcopy /D /U ..\..\common\*.* c:
copy makefile.txt makefile.mak
depend *.c >>makefile.mak

del t.txt

make -DMASTER=0 -DPAL=1

