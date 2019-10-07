WinPE-Installer
==============

A set of scripts that produce a bootable WinPE disc capable of installing a wide variety of Windows versions/SKUs.

These scripts make a lot of assumptions about local paths that are probably wrong on your computer.

It requires many files to create the bootable disc:
* [Windows 10 ADK, version 1903](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit) needs to be installed
* Windows .isos, available from MSDN with a subscription
* The latest Cumulative Updates for Windows, available from [here](https://support.microsoft.com/en-us/help/4498140)
* The required Servicing Stack Updates for Windows, as noted on the individual cumulative update pages.
* Surface drivers, available from [here](https://www.microsoft.com/surface/en-us/support/install-update-activate/download-drivers-and-firmware-for-surface?os=windows-10&=undefined)
* Intel Rapid Storage Drivers should be downloaded from [here](https://downloadcenter.intel.com/product/55005/Intel-Rapid-Storage-Technology-Intel-RST-) and extracted for better compatibility in WinPE.
* [7-Zip](http://www.7-zip.org/) needs to be installed

To produce the installer, run Setup-WinPE.ps1 from an Administrator Deployment and Imaging Tools Environment.

To copy the resulting files to a new USB key (64 GB minimum), run the following commands as an administrator:
* `diskpart`
* `LIST DISK`
* `SELECT DISK n` where `n` is the disk number of your USB key. Make sure to get this right!
* `CONVERT MBR` This command may fail with "The specified drive is not convertible". This is fine.
* `CLEAN`
* `CREATE PARTITION PRIMARY SIZE=16384`
* `FORMAT FS=FAT32 LABEL="WINPE" QUICK`
* `ACTIVE`
* `ASSIGN`
* `CREATE PARTITION PRIMARY`
* `FORMAT FS=EXFAT LABEL="DRIVERS" QUICK`
* `ASSIGN`
* `EXIT`

Then copy the contents onto the newly created drives with `robocoopy`:
* `robocopy X:\WinPE_amd64\media Y: /MIR /FFT /DST` where X: is your local drive with a generated installed and Y: is the newly created "WINPE" partition.
* `robocopy X:\WinPE_amd64\drivers-media Z: /MIR /FFT /DST` where X: is your local drive with a generated installed and Z: is the newly created "DRIVERS" partition.

To update an existing drive, just run the two `robocopy` commands above.
