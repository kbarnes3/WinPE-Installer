
function Get-WinPEDriverDir {
    return "D:\WinPE_amd64_drivers"
}

function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en-us_windows_10_consumer_editions_version_21h1_updated_aug_2021_x64_dvd_00b6a9c2.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en-us_windows_10_business_editions_version_21h1_updated_aug_2021_x64_dvd_43d18505.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en-us_windows_server_2022_x64_dvd_620d7eac.iso"
}

# function Get-ServicingStackUpdatePathVb {
#     return "$env:DISC_PATH\Cumulative Updates\2021-05 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems (KB5003173)\windows10.0-kb5003173-x64_4e3b4345ad6e3bf44183d6f25879a0c5ca1b7ef9.msu"
# }

function Get-CumulativeUpdatePathVb {
    return "$env:DISC_PATH\Cumulative Updates\2021-09 Cumulative Update for Windows 10 Version 21H1 for x64-based Systems (KB5005565)\windows10.0-kb5005565-x64_5b36501e18065cb2ef54d4bb02b0e2b27cd683d0.msu"
}

# function Get-ServicingStackUpdatePathFe {
#     return ""
# }

function Get-CumulativeUpdatePathFe {
    return "$env:DISC_PATH\Cumulative Updates\2021-09 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems (KB5005575)\windows10.0-kb5005575-x64_3a3260bcbb501fe3a5f6db2df6d0dbf7798e3f6d.msu"
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
    return "$env:DISC_PATH\Drivers\SurfacePro4_Win10_18362_21.061.12819.0.msi"
}

function Get-SurfaceBookDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook_Win10_18362_21.062.17202.0.msi"
}

function Get-SurfaceStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio_Win10_18362_21.052.24295.0.msi"
}

function Get-SurfacePro2017Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro_Win10_18362_21.063.33116.0.msi"
}

function Get-SurfaceLaptopDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop_Win10_18362_21.062.23115.0.msi"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_18362_21.064.42912.0.msi"
}

function Get-SurfaceGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo_Win10_18362_21.063.23730_WiFi_0.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_21.051.13955.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_18362_21.063.33434.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_18362_21.052.24297.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win10_18362_21.081.13091.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win10_18362_21.073.31619.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win10_18362_21.071.8492.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win10_18362_21.080.4195.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_18362_21.091.03540_0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win10_18363_21.081.13390.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win10_18363_21.051.9899.0.msi"
}
function Get-SurfaceLaptop4IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_intel_Win10_18363_21.062.24023.0.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_amd_Win10_18363_21.041.12784.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
