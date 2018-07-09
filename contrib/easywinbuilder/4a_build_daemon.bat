@call set_vars.bat
@bash patch_files.sh
@echo Building Hantripchain daemon...
@rem todo: rewrite this with ^ line wrapping
@set PARAMS=BOOST_SUFFIX=%BOOSTSUFFIX%
@set PARAMS=%PARAMS% INCLUDEPATHS="
@rem set PARAMS=%PARAMS%-I'../src'
@set PARAMS=%PARAMS% -I'C:/%EWBLIBS%/%BOOST%'
@set PARAMS=%PARAMS% -I'C:/%EWBLIBS%/%OPENSSL%/include'
@set PARAMS=%PARAMS% -I'C:/%EWBLIBS%/%BERKELEYDB%/build_unix'
@set PARAMS=%PARAMS% -I'C:/%EWBLIBS%/%MINIUPNPC%'
@set PARAMS=%PARAMS% -I'C:/%EWBLIBS%/libpng-1.6.9'
@set PARAMS=%PARAMS% -I'C:/%EWBLIBS%/qrencode-3.4.3-mgw'
@set PARAMS=%PARAMS%"
@set PARAMS=%PARAMS% LIBPATHS="
@rem set PARAMS=%PARAMS%-L'../src/leveldb'
@set PARAMS=%PARAMS% -L'C:/%EWBLIBS%/%BOOST%/stage/lib'
@set PARAMS=%PARAMS% -L'C:/%EWBLIBS%/%OPENSSL%'
@set PARAMS=%PARAMS% -L'C:/%EWBLIBS%/%BERKELEYDB%/build_unix'
@set PARAMS=%PARAMS% -L'C:/%EWBLIBS%/%MINIUPNPC%'
@set PARAMS=%PARAMS% -L'C:/%EWBLIBS%/libpng-1.6.9/.libs'
@set PARAMS=%PARAMS% -L'C:/%EWBLIBS%/qrencode-3.4.3-mgw/.libs'
@set PARAMS=%PARAMS%"
@set PARAMS=%PARAMS% ADDITIONALCCFLAGS="%ADDITIONALCCFLAGS%"
@set PARAMS=%PARAMS:\=/%
@echo PARAMS: %PARAMS%

@set PARAMS=%PARAMS% USE_UPNP=1
@rem remove "rem " from the next line to deactivate upnp
@rem set PARAMS=%PARAMS% USE_UPNP=-

@cd %ROOTPATH%\src
@mingw32-make -f makefile.mingw %PARAMS%
@if errorlevel 1 goto error
@echo.
@echo.
@strip %COINNAME%d.exe
@if errorlevel 1 goto error
@echo !!!!!!! %COINNAME% daemon DONE: Find %COINNAME%d.exe in ./src :)
@echo.
@echo.
@if not "%RUNALL%"=="1" pause
@goto end

:error
@echo.
@echo.
@echo !!!!!! Error! Build daemon failed.
@pause
:end
@cd ..\%EWBPATH%
