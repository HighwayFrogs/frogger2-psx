# Blitz PSX Libraries

These are usable to build Frogger 2.  
Unfortunately, PSYLIB.EXE is a 16-bit program and does not run on modern Windows.  
Instead, PSYLIB2.EXE has been used instead. This means the output .lib files do not match the original byte for byte.  
If you want to build the libraries in a way which more closely matches the original .lib files, use something which can support 16 bit programs, and modify buildlibs.bat to call psylib instead of psylib2 such as DOSBox.  
