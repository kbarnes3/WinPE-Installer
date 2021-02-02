
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
    return "$env:DISC_PATH\Cumulative Updates\2021-01 Servicing Stack Update for Windows Server 2019 for x64-based Systems (KB4598480)\windows10.0-kb4598480-x64_0b0c7a9e6fb982e698647a3c06068fc8a69ea8db.msu"
}

function Get-RS5CumulativeUpdatePath {
    return "$env:DISC_PATH\Cumulative Updates\2021-01 Cumulative Update for Windows Server 2019 for x64-based Systems (KB4598230)\windows10.0-kb4598230-x64_f69498ce0cac1307eb0e6701ca334ff332364289.msu"
}

function Get-ServicingStackUpdatePathVb {
    return "$env:DISC_PATH\Cumulative Updates\2021-01 Servicing Stack Update for Windows 10 Version 20H2 for x64-based Systems (KB4598481)\windows10.0-kb4598481-x64_749fe79fd2e31b145de37c2f9ebf4f711d174dc2.msu"
}

function Get-CumulativeUpdatePathVb {
    return "$env:DISC_PATH\Cumulative Updates\2021-01 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems (KB4598242)\windows10.0-kb4598242-x64_725aeed030bc68b2d07096503bd26918ac1fe488.msu"
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
    return "$env:DISC_PATH\Drivers\SurfacePro_Win10_18362_20.104.40137.0.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop_Win10_18362_20.104.38916.0.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_18362_20.092.24593.0.msi"
}

function Get-SurfaceGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo_Win10_18362_20.085.33990_WiFi_0.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_20.104.38921.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_18362_20.104.38942.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_18362_20.103.30227.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win10_18362_20.110.5488.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win10_18362_20.104.41471.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win10_18362_20.093.32773.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win10_18362_20.104.43234.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_18362_20.093.22500_0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win10_18362_20.091.14575.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win10_18362_20.122.24869.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
