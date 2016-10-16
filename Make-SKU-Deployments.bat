@ECHO OFF
SETLOCAL

SET VERSION=%~1
SET DESTINATION=%~2
SET PREFIX=%~3
SET IMAGENAME=%~4
SET NOBIOS=%~5

IF "%VERSION%"=="RS1" IF NOT "%NOBIOS%"=="/NOBIOS" ECHO ..\Helpers\RS1-Install-BIOS.bat "%IMAGENAME%" > "%DESTINATION%\BIOS\Install\%VERSION%\%PREFIX%-BIOS-Default.bat"
IF "%VERSION%"=="RS1" IF NOT "%NOBIOS%"=="/NOBIOS" ECHO ..\Helpers\RS1-Install-BIOS.bat "%IMAGENAME%" /Compact > "%DESTINATION%\BIOS\Install\%VERSION%\%PREFIX%-BIOS-Compact.bat"
IF "%VERSION%"=="RS1" ECHO ..\Helpers\RS1-Install-UEFI.bat "%IMAGENAME%" > "%DESTINATION%\UEFI\Install\%VERSION%\%PREFIX%-UEFI-Default.bat"
IF "%VERSION%"=="RS1" ECHO ..\Helpers\RS1-Install-UEFI.bat "%IMAGENAME%" /Compact > "%DESTINATION%\UEFI\Install\%VERSION%\%PREFIX%-UEFI-Compact.bat"

IF "%VERSION%"=="RS1SERVER" IF NOT "%NOBIOS%"=="/NOBIOS" ECHO ..\Helpers\RS1-Install-BIOS.bat "%IMAGENAME%" > "%DESTINATION%\BIOS\Install\RS1\%PREFIX%-BIOS-Default.bat"
IF "%VERSION%"=="RS1SERVER" ECHO ..\Helpers\RS1-Install-UEFI.bat "%IMAGENAME%" > "%DESTINATION%\UEFI\Install\RS1\%PREFIX%-UEFI-Default.bat"

ECHO %PREFIX% deployment scripts created
