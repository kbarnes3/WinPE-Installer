@ECHO OFF

SET DriveLetter=unknown
for /f "tokens=2,*" %%a in ('reg query HKLM\system\currentcontrolset\control /v PEBootRamDiskSourceDrive ^| find /i "PEBootRamDiskSourceDrive"') do set DriveLetter=%%b

ECHO Boot drive is %DriveLetter%

if "%DriveLetter%"=="unknown" GOTO :Unknown
GOTO :Known

:Unknown
Call List-Volume.bat
GOTO :EOF

:Known
Call %DriveLetter%Scripts\Start.bat
GOTO :EOF

:EOF
