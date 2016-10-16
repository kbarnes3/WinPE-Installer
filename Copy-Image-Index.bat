@SETLOCAL

@SET SOURCEWIM=%1
@SET SOURCEINDEX=%2
@SET DESTWIM=%3
@SET DESTNAME=%4

@echo Adding %DESTNAME%
dism /Export-Image /SourceImageFile:%SOURCEWIM% /SourceIndex:%SOURCEINDEX% /DestinationImageFile:%DESTWIM% /DestinationName:%DESTNAME% /Compress:max

