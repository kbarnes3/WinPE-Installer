
function Get-WinPEDriverDir {
    return "D:\WinPE_amd64_drivers"
}

function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en_windows_10_consumer_editions_version_20h2_x64_dvd_ab0e3e0a.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en_windows_10_business_editions_version_20h2_x64_dvd_4788fb7c.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en_windows_server_2019_x64_dvd_4cb967d8.iso"
}

function Get-RS5ServicingStackUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2021-04 Servicing Stack Update for Windows Server 2019 for x64-based Systems (KB5001404)\windows10.0-kb5001404-x64_9f03f10f91f3273357c6664de75c7f21e1ff474f.msu"
}

function Get-RS5CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2021-04 Cumulative Update for Windows Server 2019 for x64-based Systems (KB5001342)\windows10.0-kb5001342-x64_ddf38137b7616d101d9f82dcf7b9c6b2ae6be327.msu"
}

function Get-ServicingStackUpdatePathVb {
    return "$env:DISC_PATH\Cumulative Updates\2021-01 Servicing Stack Update for Windows 10 Version 20H2 for x64-based Systems (KB4598481)\windows10.0-kb4598481-x64_749fe79fd2e31b145de37c2f9ebf4f711d174dc2.msu"
}

function Get-CumulativeUpdatePathVb {
    return "$env:DISC_PATH\Cumulative Updates\2021-04 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems (KB5001330)\windows10.0-kb5001330-x64_48f2955cc5688bf56b32be1cca4cd1f02f1d36e2.msu"
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
    return "$env:DISC_PATH\Drivers\SurfacePro4_Win10_18362_20.034.43185.0.msi"
}

function Get-SurfaceBookDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook_Win10_18362_20.082.25857.0.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio_Win10_18362_20.112.20492.0.msi"
}

function Get-SurfacePro2017Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro_Win10_18362_21.012.27402.0.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop_Win10_18362_21.014.41485.0.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_18362_21.032.17273.0.msi"
}

function Get-SurfaceGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo_Win10_18362_21.015.38060_WiFi_0.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_21.021.11109.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_18362_20.121.14463.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_18362_20.121.12627.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win10_18362_20.122.27379.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win10_18362_20.121.13124.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win10_18362_20.121.11733.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win10_18362_21.011.15749.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_18362_21.015.36615_0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win10_18363_21.013.37543.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win10_19041_21.020.1624.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
