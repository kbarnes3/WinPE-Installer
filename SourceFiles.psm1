function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en_windows_10_consumer_editions_version_1903_x64_dvd_b980e68c.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en_windows_10_business_editions_version_1903_x64_dvd_37200948.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en_windows_server_2019_x64_dvd_4cb967d8.iso"
}

function Get-RS5ServicingStackUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2019-07 Servicing Stack Update for Windows Server 2019 for x64-based Systems (KB4512937)\windows10.0-kb4512937-x64_2a065a9ecfee76e3e457f3c596550e821358971c.msu"
}

function Get-RS5CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2019-07 Cumulative Update for Windows Server 2019 for x64-based Systems (KB4505658)\windows10.0-kb4505658-x64_cb660f3191eba56217694635b48d50d36883c3f2.msu"
}

function Get-ServicingStackUpdatePath19H1 {
    return "$env:DISC_PATH\Cumulative Updates\2019-07 Servicing Stack Update for Windows 10 Version 1903 for x64-based Systems (KB4508433)\windows10.0-kb4508433-x64_c4d6ffb6ee72a39da6c6c7e15a47d6e1520030e4.msu"
}

function Get-CumulativeUpdatePath19H1 {
    return "$env:DISC_PATH\Cumulative Updates\2019-07 Cumulative Update for Windows 10 Version 1903 for x64-based Systems (KB4505903)\windows10.0-kb4505903-x64_af8c6ab868423055a750797b6d52c1bd67e15a95.msu"
}

function Get-SurfaceProDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro_Win10_150723_0.zip"
}

function Get-SurfacePro2Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro2_Win10_160501_2.zip"
}

function Get-Surface3Drivers {
    return "$env:DISC_PATH\Drivers\Surface3_WiFi_Win10_18362_1902003_0.msi"
}

function Get-SurfacePro3Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro3_Win10_18362_1902002_0.msi"
}

function Get-SurfacePro4Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro4_Win10_18362_1902001_0.msi"
}

function Get-SurfaceBookDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook_Win10_18362_1902000_0.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio_Win10_18362_1902006_0.msi"
}

function Get-SurfacePro2017Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro_Win10_18362_1902007_1.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop_Win10_18362_1902008_0.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_18362_1902009_0.msi"
}

function Get-SurfaceGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo_Win10_17763_1902010_WiFi_1.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_1902008_0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_18362_1902007_0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_18362_1901010_0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
