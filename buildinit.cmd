if "%1"=="2013" goto vs2013
if "%1"=="2014" goto vs2014
if "%1"=="2015" goto vs2015

@echo Need to specify either 2013 or 2015
goto done

:vs2013
set DepsPath=%HOMEDRIVE%%HOMEPATH%/Library/obs-studio-dependencies/win64/include
set QTDIR=C:/Qt/5.7/msvc2013_64
set cmgen="Visual Studio 12 2013 Win64"
goto common

:vs2014
goto nosuch

:vs2015
goto nosuch
set DepsPath=%HOMEDRIVE%%HOMEPATH%/Library/obs-studio-dependencies/2015/include
set cmgen="Visual Studio 14 2015 Win64"
goto common

:nosuch
@echo No such compiler
goto done

:common
if not exist build64 goto common1
rd/s/q build64
if not exist build64 goto common1
@echo build64 still exists
goto done

:common1
mkdir build64
cd build64
cmake -DCMAKE_INSTALL_PREFIX:PATH="F:/Program Files/OBS Studio" -G %cmgen% ..
cd ..
goto done

:done

