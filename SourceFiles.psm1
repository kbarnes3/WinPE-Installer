function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en_windows_10_consumer_editions_version_1909_x64_dvd_be09950e.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en_windows_10_business_editions_version_1909_x64_dvd_ada535d0.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en_windows_server_2019_x64_dvd_4cb967d8.iso"
}

function Get-RS5ServicingStackUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2020-03 Servicing Stack Update for Windows Server 2019 for x64-based Systems (KB4539571)\windows10.0-kb4539571-x64_24d9621cc81434610770c25f5ba38082f8d12065.msu"
}

function Get-RS5CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2020-03 Cumulative Update for Windows Server 2019 for x64-based Systems (KB4541331)\windows10.0-kb4541331-x64_c57d95475748cefb92ebe257fd0a7a367804fb94.msu"
}

function Get-ServicingStackUpdatePath19H2 {
    return "$env:DISC_PATH\Cumulative Updates\2020-03 Servicing Stack Update for Windows 10 Version 1909 for x64-based Systems (KB4541338)\windows10.0-kb4541338-x64_5db6cfc57a8bda4d13107ad24b3fe8fd790219cf.msu"
}

function Get-CumulativeUpdatePath19H2 {
    return "$env:DISC_PATH\Cumulative Updates\2020-03 Cumulative Update for Windows 10 Version 1909 for x64-based Systems (KB4551762)\windows10.0-kb4551762-x64_dacef156c781f2018d94d5a5286076610ba97279.msu"
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
    return "$env:DISC_PATH\Drivers\SurfacePro4_Win10_18362_19.100.2166.0.msi"
}

function Get-SurfaceBookDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook_Win10_18362_20.013.31713.0.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio_Win10_18362_19.122.25017.0.msi"
}

function Get-SurfacePro2017Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro_Win10_18362_19.092.25297.0.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop_Win10_18362_19.100.3933.0.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_19.100.3934.0.msi"
}

function Get-SurfaceGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo_Win10_17763_1902010_WiFi_2.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_19.100.3934.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_18362_19.092.25300.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_18362_19.122.25411.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win10_18362_20.014.39957.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win10_18362_20.010.3582.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win10_18362_20.014.40255.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
