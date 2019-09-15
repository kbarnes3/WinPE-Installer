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
    return "$env:DISC_PATH\Cumulative Updates\2019-08 Cumulative Update for Windows Server 2019 for x64-based Systems (KB4512534)\windows10.0-kb4512534-x64_65e8f81eb12cbd70bf426d62f98e77b4cd2f4c28.msu"
}

function Get-ServicingStackUpdatePath19H1 {
    return "$env:DISC_PATH\Cumulative Updates\2019-09 Servicing Stack Update for Windows 10 Version 1903 for x64-based Systems (KB4515383)\windows10.0-kb4515383-x64_33a465dd17f198241e23e286ee7565c3c28b2f9d.msu"
}

function Get-CumulativeUpdatePath19H1 {
    return "$env:DISC_PATH\Cumulative Updates\2019-09 Cumulative Update for Windows 10 Version 1903 for x64-based Systems (KB4515384)\windows10.0-kb4515384-x64_d7e55a2589b1c603138c533b27b0d1222de975db.msu"
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
    return "$env:DISC_PATH\Drivers\SurfaceBook_Win10_18362_1903000_0.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio_Win10_18362_1902006_0.msi"
}

function Get-SurfacePro2017Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro_Win10_18362_1904007_0.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop_Win10_18362_1906008_0.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_18362_1904009_0.msi"
}

function Get-SurfaceGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo_Win10_17763_1902010_WiFi_2.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_1906008_0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_18362_19.083.29713.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_18362_1902010_0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
