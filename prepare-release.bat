rem Source cmake path
call /tools/doomsh.cmd

rem Set these variables to your liking
set BUILDDIR=vsbuild
set SOLUTION=dgm-level-editor.sln
set RELDIR=RELEASE
set PROJECT_NAME=DGM-Level-Editor

@echo off

echo Phase 1 - Purging
rd /s /q %BUILDDIR%

echo Phase 2 - Configuring
mkdir %BUILDDIR%
cd %BUILDDIR%
cmake.exe ..
cd ..

echo Phase 3 - Building
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat"
cd %BUILDDIR%
devenv %SOLUTION% /Build Release
cd ..

echo Phase 4 - Release filesys
set /p version=<VERSION
mkdir %RELDIR%
mkdir %RELDIR%\%PROJECT_NAME%-%version%
mkdir %RELDIR%\%PROJECT_NAME%-%version%\bin
mkdir %RELDIR%\%PROJECT_NAME%-%version%\resources
mkdir %RELDIR%\%PROJECT_NAME%-%version%\sample-project

echo Phase 5 - Copying data
copy changelog.txt %RELDIR%\%PROJECT_NAME%-%version%
copy Readme.md %RELDIR%\%PROJECT_NAME%-%version%
copy config.json %RELDIR%\%PROJECT_NAME%-%version%
copy %BUILDDIR%\Release\*.exe %RELDIR%\%PROJECT_NAME%-%version%\bin
robocopy 3rdParty\SFML\bin %RELDIR%\%PROJECT_NAME%-%version%\bin openal32.dll sfml-audio-2.dll sfml-graphics-2.dll sfml-system-2.dll sfml-window-2.dll
robocopy 3rdParty\TGUI\bin %RELDIR%\%PROJECT_NAME%-%version%\bin tgui.dll
robocopy /S resources %RELDIR%\%PROJECT_NAME%-%version%\resources
robocopy /S sample-project %RELDIR%\%PROJECT_NAME%-%version%\sample-project

echo Done!

pause

@echo on