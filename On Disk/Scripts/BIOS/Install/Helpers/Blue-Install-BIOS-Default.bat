rem === Apply the image to the Windows partition =============================
dism /Apply-Image /ImageFile:\Images\Blue.swm /SWMFile:\Images\Blue*.swm /Name:%1 /ApplyDir:W:\

rem === Copy the Windows RE Tools to the system partition ====================
md S:\Recovery\WindowsRE
xcopy /h W:\Windows\System32\Recovery\winre.wim S:\Recovery\WindowsRE

rem === Copy boot files from the Windows partition to the System partition ===
bcdboot W:\Windows

rem === In the System partition, set the location of the WinRE tools =========
W:\Windows\System32\reagentc /setreimage /path S:\Recovery\WindowsRE /target W:\Windows

echo Windows is installed! Run 'wpeutil shutdown' to shut down.
