@echo off

git describe > VERSION
set /p VERSION= < VERSION
del VERSION
set VERSION=%VERSION:-=                              %
set VERSION=%VERSION:~0,30%
set VERSION=%VERSION: =%

set OBS_INSTALL_PREFIX="F:/Program Files/OBS Studio/%VERSION%"

if exist %OBS_INSTALL_PREFIX% goto args
echo Directory "%OBS_INSTALL_PREFIX" does not exist.
echo Make sure you have OBS Studio %VERSION% installed.
goto done

:args

if "%1"=="2013" goto vs2013
if "%1"=="2015" goto vs2015

echo Need to specify either 2013 or 2015
goto done

:vs2013
set DepsPath=%HOMEDRIVE%%HOMEPATH%/Library/obs-studio-dependencies/win64/include
set QTDIR=C:/Qt/5.7/msvc2013_64
set cmgen="Visual Studio 12 2013 Win64"
goto common

:vs2015
set DepsPath=%HOMEDRIVE%%HOMEPATH%/Library/obs-studio-dependencies/2015/include
set QTDIR=c:/Qt/Qt5.7.0/5.7/msvc2015_64
set cmgen="Visual Studio 14 2015 Win64"
goto common

:common
echo Building for OBS Studio %VERSION%.

if not exist build64 goto common1
rd/s/q build64
if not exist build64 goto common1
echo build64 still exists
goto done

:common1
mkdir build64
cd build64
cmake -DCMAKE_INSTALL_PREFIX:PATH="%OBS_INSTALL_PREFIX%" -G %cmgen% ..
cd ..
goto done

:done

