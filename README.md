WinPE-Installer
==============

A set of scripts that produce a bootable WinPE disc capable of installing a wide variety of Windows versions/SKUs.

These scripts make a lot of assumptions about local paths that are probably wrong on your computer.

It requires many files to create the bootable disc:
* [Windows 11 ADK](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit) needs to be installed, along with the Windows PE add-on.
* Windows .isos, available from MSDN with a subscription.
* The latest Cumulative Updates for Windows 11, available from [here](https://support.microsoft.com/en-us/topic/windows-11-version-24h2-update-history-0929c747-1815-4543-8461-0160d16f15e5).
* The latest Cumulative Updates for Windows Server 2025, available from [here](https://support.microsoft.com/en-us/topic/windows-server-2025-update-history-10f58da7-e57b-4a9d-9c16-9f1dcd72d7d7). These are the same as the updates for Windows 11, 24H2.
* The required Servicing Stack Updates for Windows, as noted on the individual cumulative update pages
* Surface drivers, available from [here](https://www.microsoft.com/surface/en-us/support/install-update-activate/download-drivers-and-firmware-for-surface?os=windows-10&=undefined).
* Foxconn NIC drivers from [here](https://knowledgebase.frame.work/en_us/framework-laptop-13-bios-and-driver-releases-amd-ryzen-ai-300-series-r1wqKAs1e). From the .exe, extract the appropriate folder to `"$env:DISC_PATH\Drivers\Foxconn_WiFI"`.
* Intel NIC drivers from [here](https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html?wapkw=i226).
* Marvell NIC drivers from [here](https://www.marvell.com/support/downloads.html). Search for "Marvell Public Drivers", "Windows", "AQC107".
From the .zip, extract the `20221028_Marvell_AQtion_x64_Win_v3.1.7\Win11\` folder to `$env:DISC_PATH\Drivers\MarvellACQ`.
* Intel Rapid Storage Drivers should be downloaded from [here](https://downloadcenter.intel.com/product/55005/Intel-Rapid-Storage-Technology-Intel-RST-) and extracted to `$env:DISC_PATH\Drivers\IRST64` for better compatibility in WinPE.
* [7-Zip](http://www.7-zip.org/) needs to be installed.

To produce the installer, run Setup-Drivers.ps1 followed by Setup-WinPE.ps1 from an Administrator Deployment and Imaging Tools Environment.

To copy the resulting files to a new USB key (128 GB minimum), run the following commands as an administrator:
* `diskpart`
* `LIST DISK`
* `SELECT DISK n` where `n` is the disk number of your USB key. Make sure to get this right!
* `CONVERT MBR` This command may fail with "The specified drive is not convertible". This is fine.
* `CLEAN`
* `CREATE PARTITION PRIMARY SIZE=13312`
* `FORMAT FS=FAT32 LABEL="WINPE" QUICK`
* `ACTIVE`
* `ASSIGN`
* `CREATE PARTITION PRIMARY`
* `FORMAT FS=EXFAT LABEL="DRIVERS" QUICK`
* `ASSIGN`
* `EXIT`

Then copy the contents onto the newly created drives with `robocopy`:
* `robocopy X:\WinPE_amd64\media Y: /MIR /FFT /DST` where X: is your local drive with a generated installed and Y: is the newly created "WINPE" partition.
* `robocopy X:\WinPE_amd64_drivers\media Z: /MIR /FFT /DST` where X: is your local drive with a generated installed and Z: is the newly created "DRIVERS" partition.

To update an existing drive, just run the two `robocopy` commands above.
