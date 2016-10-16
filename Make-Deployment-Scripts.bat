@ECHO OFF
SETLOCAL

SET DESTINATION=%~1

mkdir %DESTINATION%\BIOS\Install\RS1
mkdir %DESTINATION%\UEFI\Install\RS1

cmd /c %~dp0\Make-SKU-Deployments.bat RS1 "%DESTINATION%" Home %HOMENAME%
cmd /c %~dp0\Make-SKU-Deployments.bat RS1 "%DESTINATION%" Pro %PRONAME%
cmd /c %~dp0\Make-SKU-Deployments.bat RS1 "%DESTINATION%" Enterprise %ENTERPRISENAME%
cmd /c %~dp0\Make-SKU-Deployments.bat RS1SERVER "%DESTINATION%" Server-Standard-Core %SERVERSTANDARDCORENAME%
cmd /c %~dp0\Make-SKU-Deployments.bat RS1SERVER "%DESTINATION%" Server-Standard-Desktop %SERVERSTANDARDDESKTOPNAME%
cmd /c %~dp0\Make-SKU-Deployments.bat RS1SERVER "%DESTINATION%" Server-Datacenter-Core %SERVERDATACENTERCORENAME%
cmd /c %~dp0\Make-SKU-Deployments.bat RS1SERVER "%DESTINATION%" Server-Datacenter-Desktop %SERVERDATACENTERDESKTOPNAME%
