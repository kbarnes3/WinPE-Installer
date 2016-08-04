@ECHO OFF
pushd %~dp0
wpeutil UpdateBootInfo
for /f "tokens=2* delims=	 " %%A in ('reg query HKLM\System\CurrentControlSet\Control /v PEFirmwareType') DO SET Firmware=%%B
:: Note: delims is a TAB followed by a space.
if %Firmware%==0x1 echo The PC is booted in BIOS mode.
if %Firmware%==0x1 set MODE=BIOS
if %Firmware%==0x2 echo The PC is booted in UEFI mode.
if %Firmware%==0x2 set MODE=UEFI
cd %MODE%\Partition
diskpart /s \DiskPart\List-Disk.txt
echo To partition your disk run either:
echo     RS1-Partition-%MODE%.bat n // For Windows 10 Version 1607
echo     Blue-Partition-%MODE%-Default.bat n // For Server 2012 R2
echo Where n is the number of the appropriate disk listed above
echo WARNING: Everything on the selected drive will be erased!
