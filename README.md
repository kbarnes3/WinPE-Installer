WinPE-Installer
==============

A set of scripts that produce a bootable WinPE disc capable of installing a wide variety of Windows versions/SKUs.

These scripts make a lot of assumptions about local paths that are probably wrong on your computer.

It requires many files to create the bootable disc:
* [Windows 10 ADK, version 1809](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit) needs to be installed
* Windows .isos, available from MSDN with a subscription
* The latest Cumulative Updates for Windows, available from [here](https://support.microsoft.com/en-us/help/4099479)
* The required Servicing Stack Updates for Windows, as noted on the individual cumulative update pages.
* Surface drivers, available from [here](https://www.microsoft.com/surface/en-us/support/install-update-activate/download-drivers-and-firmware-for-surface?os=windows-10&=undefined)
* Intel Rapid Storage Drivers should be downloaded from [here](https://downloadcenter.intel.com/product/55005/Intel-Rapid-Storage-Technology-Intel-RST-) and extracted for better compatibility in WinPE.
* [7-Zip](http://www.7-zip.org/) needs to be installed

To produce the installer, run Setup-WinPE.ps1 from an Administrator Deployment and Imaging Tools Environment.
