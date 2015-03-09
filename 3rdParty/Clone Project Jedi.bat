@echo on
@echo Cloning JCL
@echo off
git clone git://github.com/project-jedi/jcl.git project-jedi\jcl
cd .\project-jedi\jcl
git submodule update --init

cd ..\..
@echo on
@echo Cloning JVCL
@echo off
git clone git://github.com/project-jedi/jvcl.git project-jedi\jvcl
cd .\project-jedi\jvcl
git submodule update --init

pause