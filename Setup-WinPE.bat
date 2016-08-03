@set PATH=%PATH%;"C:\Program Files\7-Zip\"

@set CLIENTISO="D:\Big Stuff\Discs\en_windows_10_multiple_editions_version_1511_x64_dvd_7223712.iso"
@set ENTERPRISEISO="D:\Big Stuff\Discs\en_windows_10_enterprise_version_1511_x64_dvd_7224901.iso"
@set SERVERISO="D:\Big Stuff\Discs\en_windows_server_2012_r2_with_update_x64_dvd_4065220.iso"

@set CLIENTWIM=temp\Client.wim
@set ENTERPRISEWIM=temp\Enterprise.wim
@set SERVERWIM=temp\Server.wim

@set TH2WIM=temp\TH2.wim
@set BLUEWIM=temp\Blue.wim

@set SURFACE3ZIP="D:\Big Stuff\Discs\Surface3_WiFi_Win10_160850_0.zip"
@set SURFACEPRO3ZIP="D:\Big Stuff\Discs\SurfacePro3_Win10_160420_0.zip"
@set SURFACEPRO4ZIP="D:\Big Stuff\Discs\SurfacePro4_Win10_161101_0.zip"
@set SURFACEBOOKZIP="D:\Big Stuff\Discs\SurfaceBook_Win10_161000_0.zip"

@set SURFACE3DRIVERS=temp\Surface3
@set SURFACEPRO3DRIVERS=temp\SurfacePro3
@set SURFACEPRO4DRIVERS=temp\SurfacePro4
@set SURFACEBOOKDRIVERS=temp\SurfaceBook
@set IRSTDRIVERS="D:\Big Stuff\Discs\IRST64"

@set HOMESOURCENAME="Windows 10 Technical Preview"
@set PROSOURCENAME="Windows 10 Pro Technical Preview"
@set ENTERPRISESOURCENAME="Windows 10 Enterprise Technical Preview"
@set SERVERSTANDARDSOURCENAME="Windows Server 2012 R2 SERVERSTANDARD"

@set HOMEDESTNAME="Windows 10 Home"
@set HOMESURFACE3DESTNAME="Windows 10 Home Surface 3"
@set PRODESTNAME="Windows 10 Pro"
@set PROSURFACE3DESTNAME="Windows 10 Pro Surface 3"
@set PROSURFACEPRO3DESTNAME="Windows 10 Pro Surface Pro 3"
@set PROSURFACEPRO4DESTNAME="Windows 10 Pro Surface Pro 4"
@set PROSURFACEBOOKDESTNAME="Windows 10 Pro Surface Book"
@set ENTERPRISEDESTNAME="Windows 10 Enterprise"
@set ENTERPRISESURFACE3DESTNAME="Windows 10 Enterprise Surface 3"
@set ENTERPRISESURFACEPRO3DESTNAME="Windows 10 Enterprise Surface Pro 3"
@set ENTERPRISESURFACEPRO4DESTNAME="Windows 10 Enterprise Surface Pro 4"
@set ENTERPRISESURFACEBOOKDESTNAME="Windows 10 Enterprise Surface Book"
@set SERVERSTANDARDDESTNAME=%SERVERSTANDARDSOURCENAME%

@set MOUNTDIR=C:\WinPE_mount

if not exist "%CLIENTISO%" exit /b 1
if not exist "%ENTERPRISEISO%" exit /b 1
if not exist "%SERVERISO%" exit /b 1
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
mkdir %MOUNTDIR%

mkdir temp
7z x %SURFACE3ZIP% -o%SURFACE3DRIVERS%
7z x %SURFACEPRO3ZIP% -o%SURFACEPRO3DRIVERS%
7z x %SURFACEPRO4ZIP% -o%SURFACEPRO4DRIVERS%
7z x %SURFACEBOOKZIP% -o%SURFACEBOOKDRIVERS%

dism /Mount-Image /ImageFile:media\sources\boot.wim /Index:1 /MountDir:%MOUNTDIR%
robocopy /S /XX "%CODEROOT%\Scripts\Scripts\WinPE\In Image" %MOUNTDIR%
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

robocopy /S /XX "%CODEROOT%\Scripts\Scripts\WinPE\On Disk" media
cmd /c %~dp0Make-Deployment-Scripts.bat "media\Scripts"
mkdir media\Images

cmd /c %~dp0Extract-Wim.bat %CLIENTISO% %CLIENTWIM%
cmd /c %~dp0Copy-Image.bat %CLIENTWIM% %HOMESOURCENAME% %TH2WIM% %HOMEDESTNAME%
cmd /c %~dp0Copy-Image.bat %CLIENTWIM% %PROSOURCENAME% %TH2WIM% %PRODESTNAME%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %HOMEDESTNAME% %HOMESURFACE3DESTNAME% %SURFACE3DRIVERS%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %PRODESTNAME% %PROSURFACE3DESTNAME% %SURFACE3DRIVERS%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %PRODESTNAME% %PROSURFACEPRO3DESTNAME% %SURFACEPRO3DRIVERS%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %PRODESTNAME% %PROSURFACEPRO4DESTNAME% %SURFACEPRO4DRIVERS%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %PRODESTNAME% %PROSURFACEBOOKDESTNAME% %SURFACEBOOKDRIVERS%
del %CLIENTWIM%

cmd /c %~dp0Extract-Wim.bat %ENTERPRISEISO% %ENTERPRISEWIM%
cmd /c %~dp0Copy-Image.bat %ENTERPRISEWIM% %ENTERPRISESOURCENAME% %TH2WIM% %ENTERPRISEDESTNAME%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %ENTERPRISEDESTNAME% %ENTERPRISESURFACE3DESTNAME% %SURFACE3DRIVERS%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %ENTERPRISEDESTNAME% %ENTERPRISESURFACEPRO3DESTNAME% %SURFACEPRO3DRIVERS%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %ENTERPRISEDESTNAME% %ENTERPRISESURFACEPRO4DESTNAME% %SURFACEPRO4DRIVERS%
cmd /c %~dp0Create-Variant.bat %TH2WIM% %ENTERPRISEDESTNAME% %ENTERPRISESURFACEBOOKDESTNAME% %SURFACEBOOKDRIVERS%
del %ENTERPRISEWIM%

cmd /c %~dp0Extract-Wim.bat %SERVERISO% %SERVERWIM%
cmd /c %~dp0Copy-Image.bat %SERVERWIM% %SERVERSTANDARDSOURCENAME% %BLUEWIM% %SERVERSTANDARDDESTNAME%
del %SERVERWIM%

dism /Split-Image /ImageFile:%TH2WIM% /SWMFile:media\Images\TH2.swm /FileSize:2048
dism /Split-Image /ImageFile:%BLUEWIM% /SWMFile:media\Images\Blue.swm /FileSize:2048

cmd /c MakeWinPEMedia /ISO . winpe.iso
robocopy /MIR R:\WinPE_amd64 D:\WinPE_amd64 /XD temp
cd /d D:\WinPE_amd64

@echo All done!
@echo To make a bootable USB drive, run:
@echo MakeWinPEMedia /UFD D:\WinPE_amd64 X:
@echo Where X: is the drive letter of your USB drive

:EOF
