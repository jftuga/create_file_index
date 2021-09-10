@echo off
setlocal EnableDelayedExpansion

@REM create_file_index.bat
@REM -John Taylor
@REM Sep-10-2021
@REM version 1.0

@REM Makes searching for file meta-data very easy

@REM Creates two files:
@REM 1) a simple list of files and directories with their full pathname
@REM 2) a table of including file name with complete path, modification date, size, and type

@REM How to view file list:
@REM xz -dc dir_list.txt.xz | less

@REM How to search for files:
@REM xz -dc dir_stat.txt.xz | rg datafile.csv
@REM (or use the built-in findstr command)
@REM xz -dc dir_stat.txt.xz | findstr /i "datafile"

@REM Required Dependencies:
@REM     xz.exe  https://tukaani.org/xz/
@REM  fstat.exe  https://github.com/jftuga/fstat/
@REM timeit.exe  https://github.com/jftuga/timeit/

@REM Optional Dependencies:
@REM   rg.exe  https://github.com/BurntSushi/ripgrep
@REM less.exe  https://github.com/jftuga/less-Windows

@REM space delimited list of drive letters to index
set DRIVES=c d k

@REM number of threads that xz will use for compression
set CPU=4

for %%z in (%DRIVES%) do (
    for /f "usebackq tokens=1,2,3,4,5,6,7 delims=/:. " %%a in (`echo %DATE% %TIME%`) do if %%e lss 10 (set NOW=%%d-%%b-%%c 0%%e:%%f:%%g) else (set NOW=%%d-%%b-%%c %%e:%%f:%%g)
    @echo.
    @echo [!NOW!] drive %%z:
    cd /d %%z:
    timeit _start
    set F=%%z:\dir_list.txt
    set G=%%z:\dir_stat.txt.xz
    @echo index file: !F!
    dir /s/b %%z:\ > !F!
    @echo fstat file: !G!
    fstat -c -ed -long -q -t !F! | xz -9 -T%CPU% -v > !G!
    @echo compressing index to: !F!.xz
    @echo using %CPU% compression threads
    xz -9 -T%CPU% -v !F!
    timeit _end
    @echo.
)

for /f "usebackq tokens=1,2,3,4,5,6,7 delims=/:. " %%a in (`echo %DATE% %TIME%`) do if %%e lss 10 (set NOW=%%d-%%b-%%c 0%%e:%%f:%%g) else (set NOW=%%d-%%b-%%c %%e:%%f:%%g)
@echo [!NOW!] finished
@echo.
