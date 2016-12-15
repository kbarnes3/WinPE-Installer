@SETLOCAL

@SET SOURCEWIM=%1
@SET SOURCENAME=%2
@SET DESTWIM=%3
@SET DESTNAME=%4

@echo Adding %DESTNAME%
dism /Export-Image /SourceImageFile:%SOURCEWIM% /SourceName:%SOURCENAME% /DestinationImageFile:%DESTWIM% /DestinationName:%DESTNAME% /Compress:max /ScratchDir:%DISMSCRATCHDIR%

