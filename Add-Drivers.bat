@ECHO OFF
SETLOCAL

SET SCRIPTDESTINATION=%~1
SET DRIVERSROOT=%~2
SET NAME=%~3
SET SOURCEZIP=%~4

SET DRIVERSDEST=%DRIVERSROOT%\%NAME%
SET DRIVERSMOUNTPATH=\Drivers\%NAME%

7z x "%SOURCEZIP%" -o%DRIVERSDEST%
ECHO mkdir W:\DismScratch > %SCRIPTDESTINATION%\%NAME%.bat
ECHO dism /Add-Driver /Image:W:\ /Driver:%DRIVERSMOUNTPATH% /Recurse /ScratchDir:W:\DismScratch >> %SCRIPTDESTINATION%\%NAME%.bat
ECHO rmdir /s /q W:\DismScratch >> %SCRIPTDESTINATION%\%NAME%.bat
ECHO @ECHO %NAME% drivers added. Run 'wpeutil shutdown' or 'wpeutil reboot' >> %SCRIPTDESTINATION%\%NAME%.bat
