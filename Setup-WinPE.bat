if not defined WinPERoot echo Setup-WinPE must be run from a Deployment and Imaging Tools Environment && GOTO :EOF

@set PATH=%PATH%;"C:\Program Files\7-Zip\"

@set CLIENTISO="D:\Big Stuff\Discs\en_windows_10_multiple_editions_version_1607_updated_jul_2016_x64_dvd_9058187.iso"
@set ENTERPRISEISO="D:\Big Stuff\Discs\en_windows_10_enterprise_version_1607_updated_jul_2016_x64_dvd_9054264.iso"
@set SERVERISO="D:\Big Stuff\Discs\en_windows_server_2016_x64_dvd_9327751.iso"
@set CUMULATIVEUPDATESOURCE="D:\Big Stuff\Discs\Cumulative Updates\Cumulative Update for Windows 10 Version 1607 for x64-based Systems (KB3200970)\windows10.0-kb3200970-x64_3fa1daafc46a83ed5d0ecbd0a811e1421b7fad5a.msu"

@set CLIENTWIM=temp\Client.wim
@set ENTERPRISEWIM=temp\Enterprise.wim
@set SERVERWIM=temp\Server.wim
@set CUMULATIVEUPDATE=temp\CumulativeUpdate.msu

@set RS1WIM=temp\RS1.wim

@set SURFACEPROZIP="D:\Big Stuff\Discs\SurfacePro_Win10_150723_0.zip"
@set SURFACEPRO2ZIP="D:\Big Stuff\Discs\SurfacePro2_Win10_160501_2.zip"
@set SURFACE3ZIP="D:\Big Stuff\Discs\Surface3_WiFi_Win10_161250_0.zip"
@set SURFACEPRO3ZIP="D:\Big Stuff\Discs\SurfacePro3_Win10_161330_0.zip"
@set SURFACEPRO4ZIP="D:\Big Stuff\Discs\SurfacePro4_Win10_161201_0.zip"
@set SURFACEBOOKZIP="D:\Big Stuff\Discs\SurfaceBook_Win10_161200_0.zip"

@set DRIVERSSCRIPTS=media\Scripts\Drivers
@set DRIVERSROOT=media\Drivers
@set IRSTDRIVERS="D:\Big Stuff\Discs\IRST64"

@set HOMENAME="Windows 10 Home"
@set PRONAME="Windows 10 Pro"
@set ENTERPRISENAME="Windows 10 Enterprise"
@set SERVERSTANDARDCOREINDEX=1
@set SERVERSTANDARDCORENAME="Windows Server 2016 Standard"
@set SERVERSTANDARDDESKTOPINDEX=2
@set SERVERSTANDARDDESKTOPNAME="Windows Server 2016 Standard (Desktop Experience)"
@set SERVERDATACENTERCOREINDEX=3
@set SERVERDATACENTERCORENAME="Windows Server 2016 Datacenter"
@set SERVERDATACENTERDESKTOPINDEX=4
@set SERVERDATACENTERDESKTOPNAME="Windows Server 2016 Datacenter (Desktop Experience)"

@set MOUNTDIR=C:\WinPE_mount

if not exist "%CLIENTISO%" exit /b 1
if not exist "%ENTERPRISEISO%" exit /b 1
if not exist "%SERVERISO%" exit /b 1
if not exist "%CUMULATIVEUPDATESOURCE%" exit /b 1
if not exist "%SURFACEPROZIP%" exit /b 1
if not exist "%SURFACEPRO2ZIP%" exit /b 1
if not exist "%SURFACE3ZIP%" exit /b 1
if not exist "%SURFACEPRO3ZIP%" exit /b 1
if not exist "%SURFACEPRO4ZIP%" exit /b 1
if not exist "%SURFACEBOOKZIP%" exit /b 1
if not exist "%IRSTDRIVERS%" exit /b 1
@echo All patches exist!

rmdir /s /q R:\WinPE_amd64
if exist R:\WinPE_amd64 echo Deleting R:\WinPE_amd64 failed && GOTO :EOF
cmd /c copype amd64 R:\WinPE_amd64
pushd R:\WinPE_amd64

rmdir /s /q %MOUNTDIR%
if exist %MOUNTDIR% echo Deleting %MOUNTDIR% failed && GOTO :EOF
mkdir %MOUNTDIR%

mkdir temp

mkdir %DRIVERSSCRIPTS%
mkdir %DRIVERSROOT%
cmd /c %~dp0Add-Drivers.bat %DRIVERSSCRIPTS% %DRIVERSROOT% SurfacePro %SURFACEPROZIP%
cmd /c %~dp0Add-Drivers.bat %DRIVERSSCRIPTS% %DRIVERSROOT% SurfacePro2 %SURFACEPRO2ZIP%
cmd /c %~dp0Add-Drivers.bat %DRIVERSSCRIPTS% %DRIVERSROOT% Surface3 %SURFACE3ZIP%
cmd /c %~dp0Add-Drivers.bat %DRIVERSSCRIPTS% %DRIVERSROOT% SurfacePro3 %SURFACEPRO3ZIP%
cmd /c %~dp0Add-Drivers.bat %DRIVERSSCRIPTS% %DRIVERSROOT% SurfacePro4 %SURFACEPRO4ZIP%
cmd /c %~dp0Add-Drivers.bat %DRIVERSSCRIPTS% %DRIVERSROOT% SurfaceBook %SURFACEBOOKZIP%

copy %CUMULATIVEUPDATESOURCE% %CUMULATIVEUPDATE%

dism /Mount-Image /ImageFile:media\sources\boot.wim /Index:1 /MountDir:%MOUNTDIR%
robocopy /S /XX "%~dp0In Image" %MOUNTDIR%
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FMAPI.cab"
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureStartup.cab"
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-SecureStartup_en-us.cab"
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-EnhancedStorage.cab"
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-EnhancedStorage_en-us.cab"
dism /Add-Driver /Image:%MOUNTDIR% /Driver:%IRSTDRIVERS% /Recurse
dism /Cleanup-Image /Image:%MOUNTDIR% /StartComponentCleanup /ResetBase
dism /Unmount-Image /MountDir:%MOUNTDIR% /Commit
dism /Export-Image /SourceImageFile:media\sources\boot.wim /SourceIndex:1 /DestinationImageFile:media\sources\boot2.wim /Compress:max
del media\sources\boot.wim
move media\sources\boot2.wim media\sources\boot.wim

robocopy /S /XX "%~dp0On Disk" media
cmd /c %~dp0Make-Deployment-Scripts.bat "media\Scripts"
mkdir media\Images

cmd /c %~dp0Extract-Wim.bat %CLIENTISO% %CLIENTWIM%
cmd /c %~dp0Update-Image-Name.bat %MOUNTDIR% %CLIENTWIM% %HOMENAME% %CUMULATIVEUPDATE%
cmd /c %~dp0Copy-Image-Name.bat %CLIENTWIM% %HOMENAME% %RS1WIM% %HOMENAME%
cmd /c %~dp0Update-Image-Name.bat %MOUNTDIR% %CLIENTWIM% %PRONAME% %CUMULATIVEUPDATE%
cmd /c %~dp0Copy-Image-Name.bat %CLIENTWIM% %PRONAME% %RS1WIM% %PRONAME%
del %CLIENTWIM%

cmd /c %~dp0Extract-Wim.bat %ENTERPRISEISO% %ENTERPRISEWIM%
cmd /c %~dp0Update-Image-Name.bat %MOUNTDIR% %ENTERPRISEWIM% %ENTERPRISENAME% %CUMULATIVEUPDATE%
cmd /c %~dp0Copy-Image-Name.bat %ENTERPRISEWIM% %ENTERPRISENAME% %RS1WIM% %ENTERPRISENAME%
del %ENTERPRISEWIM%

cmd /c %~dp0Extract-Wim.bat %SERVERISO% %SERVERWIM%
cmd /c %~dp0Update-Image-Index.bat %MOUNTDIR% %SERVERWIM% %SERVERSTANDARDCOREINDEX% %CUMULATIVEUPDATE%
cmd /c %~dp0Copy-Image-Index.bat %SERVERWIM% %SERVERSTANDARDCOREINDEX% %RS1WIM% %SERVERSTANDARDCORENAME%
cmd /c %~dp0Update-Image-Index.bat %MOUNTDIR% %SERVERWIM% %SERVERSTANDARDDESKTOPINDEX% %CUMULATIVEUPDATE%
cmd /c %~dp0Copy-Image-Index.bat %SERVERWIM% %SERVERSTANDARDDESKTOPINDEX% %RS1WIM% %SERVERSTANDARDDESKTOPNAME%
cmd /c %~dp0Update-Image-Index.bat %MOUNTDIR% %SERVERWIM% %SERVERDATACENTERCOREINDEX% %CUMULATIVEUPDATE%
cmd /c %~dp0Copy-Image-Index.bat %SERVERWIM% %SERVERDATACENTERCOREINDEX% %RS1WIM% %SERVERDATACENTERCORENAME%
cmd /c %~dp0Update-Image-Index.bat %MOUNTDIR% %SERVERWIM% %SERVERDATACENTERDESKTOPINDEX% %CUMULATIVEUPDATE%
cmd /c %~dp0Copy-Image-Index.bat %SERVERWIM% %SERVERDATACENTERDESKTOPINDEX% %RS1WIM% %SERVERDATACENTERDESKTOPNAME%
del %SERVERWIM%

dism /Split-Image /ImageFile:%RS1WIM% /SWMFile:media\Images\RS1.swm /FileSize:2048
del %RS1WIM%

cmd /c MakeWinPEMedia /ISO . winpe.iso
robocopy /MIR R:\WinPE_amd64 D:\WinPE_amd64 /XD temp
cd /d D:\WinPE_amd64

@echo All done!
@echo To make a bootable USB drive, run:
@echo MakeWinPEMedia /UFD D:\WinPE_amd64 X:
@echo Where X: is the drive letter of your USB drive

:EOF
