WinPE-Installer
==============

A set of scripts that produce a bootable WinPE disc capable of installing a wide variety of Windows versions/SKUs.

These scripts make a lot of assumptions about local paths that are probably wrong on your computer.

It requires .isos for Windows, available from MSDN with subscription. It also requires Surface drivers, available from
https://technet.microsoft.com/en-us/library/mt210833.aspx. These scripts can also install the latest Cumulative Update
for Windows, available from https://support.microsoft.com/en-us/help/12387/windows-10-update-history. For better
compatibility in WinPE, Intel Rapid Storage Drivers should be downloaded and extracted from
https://downloadcenter.intel.com/product/55005/Intel-Rapid-Storage-Technology-Intel-RST-.
Running these scripts also requires 7-zip to be installed (http://www.7-zip.org/)
and the Windows 10 ADK, version 1607 (https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit).

To produce the installer, run Setup-WinPE.ps1 from an Administrator Deployment and Imaging Tools Environment.
