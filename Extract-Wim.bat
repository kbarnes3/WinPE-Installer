@SETLOCAL

@SET ISO=%1
@SET WIM=%2

7z e %ISO% -otemp\ sources\install.wim
move temp\install.wim %WIM%
