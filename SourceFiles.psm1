function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en_windows_10_consumer_edition_version_1809_updated_sept_2018_x64_dvd_491ea967.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en_windows_10_business_edition_version_1809_updated_sept_2018_x64_dvd_f0b7dc68.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en_windows_server_2019_x64_dvd_4cb967d8.iso"
}

function Get-RS5ServicingStackUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2018-11 Update for Windows 10 Version 1809 for x64-based Systems (KB4465664)\windows10.0-kb4465664-x64_1999cce27d8eb316441ee21e411d23c693aaf411.msu"
}

function Get-RS5CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2018-11 Cumulative Update for Windows 10 Version 1809 for x64-based Systems (KB4467708)\windows10.0-kb4467708-x64_7727ab0085a8a32730d35272c7f6f0e616bd23ad.msu"
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
    return "$env:DISC_PATH\SurfacePro3_Win10_16299_1803002_0.msi"
}

function Get-SurfacePro4Drivers {
    return "$env:DISC_PATH\SurfacePro4_Win10_16299_1803001_0.msi"
}

function Get-SurfaceBookDrivers {
    return "$env:DISC_PATH\SurfaceBook_Win10_16299_1802300_1.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\SurfaceStudio_Win10_17134_1803506_3.msi"
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
