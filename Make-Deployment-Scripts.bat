@ECHO OFF
SETLOCAL

SET DESTINATION=%~1

mkdir %DESTINATION%\BIOS\Install\Blue
mkdir %DESTINATION%\BIOS\Install\RS1
mkdir %DESTINATION%\UEFI\Install\Blue
mkdir %DESTINATION%\UEFI\Install\RS1

cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Home %HOMEDESTNAME%
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-3-Home %HOMESURFACE3DESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Pro %PRODESTNAME%
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-3-Pro %PROSURFACE3DESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-Pro-3-Pro %PROSURFACEPRO3DESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-Pro-4-Pro %PROSURFACEPRO4DESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-Book-Pro %PROSURFACEBOOKDESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Enterprise %ENTERPRISEDESTNAME%
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-3-Enterprise %ENTERPRISESURFACE3DESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-Pro-3-Enterprise %ENTERPRISESURFACEPRO3DESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-Pro-4-Enterprise %ENTERPRISESURFACEPRO4DESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /RS1 "%DESTINATION%" Surface-Book-Enterprise %ENTERPRISESURFACEBOOKDESTNAME% /NOBIOS
cmd /c %~dp0\Make-SKU-Deployments.bat /BLUE "%DESTINATION%" Server %SERVERSTANDARDDESTNAME%
