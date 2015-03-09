@echo on
@echo Cloning Delphi Project Manager
@echo off
git clone git://github.com/Ruscigno/Delphi-Project-Manager.git delphi-project-manager
cd Delphi-Project-Manager
git submodule update --init

pause