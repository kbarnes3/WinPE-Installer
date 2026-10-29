WinPE-Installer
==============

A set of scripts that produce a bootable WinPE disc capable of installing a wide variety of Windows versions/SKUs.

These scripts make a lot of assumptions about local paths that are probably wrong on your computer.

It requires many files to create the bootable disc:
* [Windows 11 ADK](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit) needs to be installed, along with the Windows PE add-on.
* Windows .isos, available from MSDN with a subscription. Set `$env:DISC_PATH` to the directory containing the Windows 11 26H2 base Consumer and Business x64 media and Windows Server 2025 updated x64 media. Client media filenames must match `en-us_windows_11_consumer_editions_version_26h2_x64_dvd_*.iso` and `en-us_windows_11_business_editions_version_26h2_x64_dvd_*.iso`; updated 26H2 client media is not selected. Keep exactly one matching ISO for each media type. Current client filenames are `en-us_windows_11_consumer_editions_version_26h2_x64_dvd_af326c9d.iso` and `en-us_windows_11_business_editions_version_26h2_x64_dvd_16357792.iso`.
* Intel NIC drivers from [here](https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html?wapkw=i226).
* Marvell NIC drivers from [here](https://www.marvell.com/support/downloads.html). Search for "Marvell Public Drivers", "Windows", "AQC107".
From the .zip, extract the `20221028_Marvell_AQtion_x64_Win_v3.1.7\Win11\` folder to `$env:DISC_PATH\Drivers\MarvellACQ`.
* Framework WIFI drivers from [here](https://knowledgebase.frame.work/en_us/framework-laptop-13-bios-and-driver-releases-amd-ryzen-ai-300-series-r1wqKAs1e). Download the "Wi-Fi driver for use during Windows installation" link. From the .zip, extract the contents to `$env:DISC_PATH\Drivers\Framework_W11_24H2_OOBE_Wifi_Driver_Package`
* Intel Rapid Storage Drivers should be downloaded from [here](https://downloadcenter.intel.com/product/55005/Intel-Rapid-Storage-Technology-Intel-RST-) and extracted to `$env:DISC_PATH\Drivers\IRST64` for better compatibility in WinPE.
* [7-Zip](http://www.7-zip.org/) needs to be installed.

To produce the installer, run Setup-Drivers.ps1 followed by Setup-WinPE.ps1 from an Administrator Deployment and Imaging Tools Environment.

To copy the resulting files to a new USB key (32 GB minimum), run the following commands as an administrator:
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

Then copy the contents onto the newly created drives with `robocopy`:
* `robocopy X:\WinPE_amd64\media Y: /MIR /FFT /DST` where X: is your local drive with a generated installed and Y: is the newly created "WINPE" partition.
* `robocopy X:\WinPE_amd64_drivers\media Z: /MIR /FFT /DST` where X: is your local drive with a generated installed and Z: is the newly created "DRIVERS" partition.

To update an existing drive, just run the two `robocopy` commands above.
