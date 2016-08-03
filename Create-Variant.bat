@SETLOCAL

@SET WIM=%1
@SET SOURCENAME=%2
@SET DESTNAME=%3
@SET DRIVERS=%4

@echo Adding %DESTNAME%

dism /Export-Image /SourceImageFile:%WIM% /SourceName:%SOURCENAME% /DestinationImageFile:%WIM% /DestinationName:%DESTNAME% /Compress:max
dism /Mount-Image /ImageFile:%WIM% /Name:%DESTNAME% /MountDir:%MOUNTDIR%
dism /Add-Driver /Image:%MOUNTDIR% /Driver:%DRIVERS% /Recurse
dism /Unmount-Image /MountDir:%MOUNTDIR% /Commit

