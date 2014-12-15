@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
::cls
::=================================================================================::
::                          Deployment Tool                                     ::
::                              R4Z0R49                                            ::
::=================================================================================::
if exist BuildConfig.cfg (
	for /f "delims=" %%x in (BuildConfig.cfg) do (set "%%x")
)

if not exist BuildConfig.cfg goto NoConfig

::=================================================================================::
::  STOP EDITING HERE                                                              ::
::=================================================================================::

TITLE %ModName% Deploy tool %version%%build%

:menuLOOP
cls
if not exist %deploy% ( mkdir %deploy% )
if not exist %deploy%\addons ( mkdir %deploy%\addons )

IF "%time:~0,1%" LSS "1" (
   SET DATETIME=%date:~6,4%%date:~3,2%%date:~0,2%0%time:~1,1%%time:~3,2%%time:~6,2%
) ELSE (
   SET DATETIME=%date:~6,4%%date:~3,2%%date:~0,2%%time:~0,2%%time:~3,2%%time:~6,2%
)

TITLE %ModName% Deploy tool %version%%build%
::cls
echo.
echo.= Menu =================================================
echo.
echo %testing%
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
set choice=
echo.&set /p choice=Make a choice or hit ENTER to quit: ||GOTO:EOF
echo.&call:menu_%choice%

GOTO:menuLOOP

::-----------------------------------------------------------
:: menu functions follow below here
::-----------------------------------------------------------

:menu_c Cleanup
RMDIR /S /Q %Deploy%
TIMEOUT /T 5
GOTO:menuLOOP

:menu_1 code
mkdir %Deploy%
mkdir %deploy%\Addons

echo (%date%) (%time%) ATTENTION: Creating Client side .PBO's 
%tools%\cpbo.exe -y -p %home%\code %Deploy%\Addons\code.pbo

cd %Deploy%
del "%Deploy%\addons\*.log"

::cls
echo (%date%) (%time%) ATTENTION: checking send to gamefolder
if defined Arma3GameLocation (
	xcopy Addons %Arma3GameLocation%\%ModName%\addons\ /Y/V
)

if defined Winrar (
	%Winrar%\rar.exe a -r code.rar Addons
)

echo (%date%) (%time%) ATTENTION: Clean @Deploy

if exist %Deploy% (
	attrib +r +s *.rar
	del * /S /Q
	attrib -r -s *.rar
	FOR /D  %%G in (*) DO RD /s /q %%G
)

cd %home%
TIMEOUT /T 2
GOTO:menuLOOP

:menu_2 functions
mkdir %Deploy%
mkdir %deploy%\Addons

echo (%date%) (%time%) ATTENTION: Creating Client side .PBO's 
%tools%\cpbo.exe -y -p %home%\functions %Deploy%\Addons\functions.pbo


cd %Deploy%
del "%Deploy%\addons\*.log"

::cls
echo (%date%) (%time%) ATTENTION: checking send to gamefolder
if defined Arma3GameLocation (
	xcopy /Y Addons %Arma3GameLocation%\%ModName%\addons\
)

if defined Winrar (
	%Winrar%\rar.exe a -r functions.rar Addons
)
echo (%date%) (%time%) ATTENTION: Clean @Deploy

if exist %Deploy% (
	attrib +r +s *.rar
	del * /S /Q
	attrib -r -s *.rar
	FOR /D  %%G in (*) DO RD /s /q %%G
)

cd %home%
TIMEOUT /T 2
GOTO:menuLOOP

:menu_9 server
mkdir %Deploy%
mkdir %deploy%\%ServerName%
mkdir %deploy%\%ServerName%\Addons
mkdir %deploy%\%ServerProfile%

xcopy /Y %Binaries%\Database.dll %Deploy%\
xcopy /Y %Binaries%\tbb.dll %Deploy%\
xcopy /Y %Binaries%\tbbmalloc.dll %Deploy%\
xcopy /Y %Binaries%\DatabaseMySql.dll %Deploy%\
xcopy /Y %Binaries%\DatabasePostgre.dll %Deploy%\
xcopy /Y %Binaries%\HiveEXT.dll %Deploy%\%ServerName%
xcopy /Y %Binaries%\HiveEXT.ini %Deploy%\%ServerProfile%\

echo (%date%) (%time%) ATTENTION: Creating Client side .PBO's 
%tools%\cpbo.exe -y -p %home%\server %Deploy%\%ServerName%\Addons\server.pbo

cd %Deploy%
del "%Deploy%\%ServerName%\addons\*.log"

::cls
echo (%date%) (%time%) ATTENTION: checking send to gamefolder
if defined Arma3GameLocation (
	xcopy /Y /E %ServerName% %Arma3GameLocation%\%ServerName%\
)

%Winrar%\rar.exe a -r server.rar %ServerName% %ServerProfile% DatabaseMySql.dll DatabasePostgre.dll Database.dll tbb.dll tbbmalloc.dll

echo (%date%) (%time%) ATTENTION: Clean @Deploy

if exist %Deploy% (
	attrib +r +s *.rar
	del * /S /Q
	attrib -r -s *.rar
	FOR /D  %%G in (*) DO RD /s /q %%G
)

cd %home%
TIMEOUT /T 2
GOTO:menuLOOP

:menu_o Open Deploy
%SystemRoot%\explorer.exe "%deploy%"
TIMEOUT /T 3
GOTO:menuLOOP

:menu_q Quit
cd %home%
TIMEOUT /T 3
exit

:NoConfig
echo your missing the config file please look for issue number #153 in github.
TIMEOUT /T 5
exit

GOTO:menuLOOP


