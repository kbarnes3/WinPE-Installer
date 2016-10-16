@ECHO OFF
SETLOCAL

SET MOUNTDIR=%1
SET WIMFILE=%2
SET INDEX=%3
SET UPDATEFILE=%4

dism /Mount-Image /ImageFile:%WIMFILE% /Index:%INDEX% /MountDir:%MOUNTDIR%
dism /Add-Package /Image:%MOUNTDIR% /PackagePath:%UPDATEFILE%
dism /Cleanup-Image /Image:%MOUNTDIR% /StartComponentCleanup /ResetBase
dism /Unmount-Image /MountDir:%MOUNTDIR% /Commit
