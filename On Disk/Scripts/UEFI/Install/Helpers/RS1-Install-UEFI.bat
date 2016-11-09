set SCRATCHDIR=W:\DismScratch
mkdir %SCRATCHDIR%

rem === Apply the image to the Windows partition =============================
dism /Apply-Image /ImageFile:\Images\RS1.swm /SWMFile:\Images\RS1*.swm /Name:%1 /ApplyDir:W:\ /ScratchDir:%SCRATCHDIR% %2

rem === Copy the Windows RE Tools to the Recovery partition ==========
md R:\Recovery\WindowsRE
xcopy /h W:\Windows\System32\Recovery\winre.wim R:\Recovery\WindowsRE

rem === Copy boot files from the Windows partition to the System partition ===
bcdboot W:\Windows

rem === In the System partition, set the location of the WinRE tools =========
W:\Windows\System32\reagentc /setreimage /path R:\Recovery\WindowsRE /target W:\Windows

rmdir /s /q %SCRATCHDIR%

pushd \Scripts\Drivers
dir

@echo Windows is installed! To install additional drivers,
@echo run the appropriate script listed above. Otherwise,
@echo run 'wpeutil shutdown' or 'wpeutil reboot'.
