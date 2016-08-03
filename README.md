WinPE-Installer
==============

A set of scripts that produce a bootable WinPE disc capable of installing a wide variety of Windows versions/SKUs.

These scripts make a lot of assumptions about local paths that are probably wrong on your computer.

It requires .isos for Windows, available from MSDN with subscription. It also requires Surface drivers, available from
https://technet.microsoft.com/en-us/library/mt210833.aspx. Running these scripts also requires 7-zip to be installed (http://www.7-zip.org/)
and the Windows 10 ADK, version 1511 (https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit).

To produce the installer, run Setup-WinPE from an Administrator Deployment and Imaging Tools Environment.
