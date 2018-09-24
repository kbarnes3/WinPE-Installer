function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en_windows_10_consumer_editions_version_1803_updated_march_2018_x64_dvd_12063379.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en_windows_10_business_editions_version_1803_updated_march_2018_x64_dvd_12063333.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en_windows_server_2016_x64_dvd_9327751.iso"
}

function Get-RS1ServicingStackUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2018-05 Update for Windows Server 2016 for x64-based Systems (KB4132216)\windows10.0-kb4132216-x64_9cbeb1024166bdeceff90cd564714e1dcd01296e.msu"
}

function Get-RS1CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2018-09 Cumulative Update for Windows Server 2016 for x64-based Systems (KB4457127)\windows10.0-kb4457127-x64_53e4351d1e0233b3e55ed7fd70b6dca54b0ab878.msu"
}

function Get-RS4ServicingStackUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2018-09 Update for Windows 10 Version 1803 for x64-based Systems (KB4456655)\windows10.0-kb4456655-x64_fca3f0c885da48efc6f9699b0c1eaf424e779434.msu"
}

function Get-RS4CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2018-09 Cumulative Update for Windows 10 Version 1803 for x64-based Systems (KB4458469)\windows10.0-kb4458469-x64_22139e5b137440eac5526d4c5c85762fcbe80030.msu"
}

function Get-SurfaceProDrivers {
    return "$env:DISC_PATH\SurfacePro_Win10_150723_0.zip"
}

function Get-SurfacePro2Drivers {
    return "$env:DISC_PATH\SurfacePro2_Win10_160501_2.zip"
}

function Get-Surface3Drivers {
    return "$env:DISC_PATH\Surface3_WiFi_Win10_17134_1801703_3.msi"
}

function Get-SurfacePro3Drivers {
    return "$env:DISC_PATH\SurfacePro3_Win10_15063_1802002_0.msi"
}

function Get-SurfacePro4Drivers {
    return "$env:DISC_PATH\SurfacePro4_Win10_16299_1803001_0.msi"
}

function Get-SurfaceBookDrivers {
    return "$env:DISC_PATH\SurfaceBook_Win10_16299_1802300_1.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\SurfaceStudio_Win10_17134_1802206_0.msi"
}

function Get-SurfacePro2017Drivers {
    return "$env:DISC_PATH\SurfacePro_Win10_16299_1806007_3.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\SurfaceLaptop_Win10_16299_1803508_1.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\SurfaceBook2_Win10_16299_1802809_0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\IRST64"
}

Export-ModuleMember *
