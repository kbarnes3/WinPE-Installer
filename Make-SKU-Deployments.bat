@ECHO OFF
SETLOCAL

SET VERSION=%~1
SET DESTINATION=%~2
SET PREFIX=%~3
SET IMAGENAME=%~4
SET NOBIOS=%~5

IF "%VERSION%"=="/TH2" IF NOT "%NOBIOS%"=="/NOBIOS" ECHO ..\Helpers\TH2-Install-BIOS.bat "%IMAGENAME%" > "%DESTINATION%\BIOS\Install\%VERSION%\%PREFIX%-BIOS-Default.bat"
IF "%VERSION%"=="/TH2" IF NOT "%NOBIOS%"=="/NOBIOS" ECHO ..\Helpers\TH2-Install-BIOS.bat "%IMAGENAME%" /Compact > "%DESTINATION%\BIOS\Install\%VERSION%\%PREFIX%-BIOS-Compact.bat"
IF "%VERSION%"=="/TH2" ECHO ..\Helpers\TH2-Install-UEFI.bat "%IMAGENAME%" > "%DESTINATION%\UEFI\Install\%VERSION%\%PREFIX%-UEFI-Default.bat"
IF "%VERSION%"=="/TH2" ECHO ..\Helpers\TH2-Install-UEFI.bat "%IMAGENAME%" /Compact > "%DESTINATION%\UEFI\Install\%VERSION%\%PREFIX%-UEFI-Compact.bat"

IF "%VERSION%"=="/BLUE" IF NOT "%NOBIOS%"=="/NOBIOS" ECHO ..\Helpers\Blue-Install-BIOS-Default.bat "%IMAGENAME%" > "%DESTINATION%\BIOS\Install\%VERSION%\%PREFIX%-BIOS-Default.bat"
IF "%VERSION%"=="/BLUE" ECHO ..\Helpers\Blue-Install-UEFI-Default.bat "%IMAGENAME%" > "%DESTINATION%\UEFI\Install\%VERSION%\%PREFIX%-UEFI-Default.bat"

ECHO %PREFIX% deployment scripts created
