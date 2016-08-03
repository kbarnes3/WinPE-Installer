set SCRIPTNAME=TH2-UEFI
md X:\Temp
echo select disk %1 > X:\Temp\%SCRIPTNAME%.txt
type \DiskPart\%SCRIPTNAME%.txt >> X:\Temp\%SCRIPTNAME%.txt
diskpart /s X:\Temp\%SCRIPTNAME%.txt
cd ..\Install\TH2
dir
echo To install Windows, run the appropriate script listed above
