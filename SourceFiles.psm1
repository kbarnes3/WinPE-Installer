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
    return "$env:DISC_PATH\Cumulative Updates\2018-08 Cumulative Update for Windows Server 2016 for x64-based Systems (KB4343887)\windows10.0-kb4343887-x64_b271ddc543d9dced2baef6af558e94726a549df3.msu"
}

function Get-RS4CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2018-08 Cumulative Update for Windows 10 Version 1803 for x64-based Systems (KB4343909)\windows10.0-kb4343909-x64_f931af6d56797388715fe3b0d97569af7aebdae6.msu"
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
    return "$env:DISC_PATH\SurfaceBook_Win10_16299_1801500_3.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\SurfaceStudio_Win10_17134_1802206_0.msi"
}

function Get-SurfacePro2017Drivers {
    return "$env:DISC_PATH\SurfacePro_Win10_16299_1805507_2.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\SurfaceLaptop_Win10_17134_1802808_0.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\SurfaceBook2_Win10_16299_1802809_0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\IRST64"
}

Export-ModuleMember *
