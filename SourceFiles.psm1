
function Get-WinPEDriverDir {
    return "D:\WinPE_amd64_drivers"
}

function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en-us_windows_11_consumer_editions_x64_dvd_bd3cf8df.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en-us_windows_11_business_editions_x64_dvd_3a304c08.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en-us_windows_server_2022_x64_dvd_620d7eac.iso"
}

# function Get-ServicingStackUpdatePathFe {
#     return ""
# }

function Get-CumulativeUpdatePathFe {
    return "$env:DISC_PATH\Cumulative Updates\2021-10 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems (KB5006699)\windows10.0-kb5006699-x64_82eb73425e814da5de836b32feacf1a4f7b32ac2.msu"
}

# function Get-ServicingStackUpdatePathCo {
#     return ""
# }

function Get-CumulativeUpdatePathCo {
    return "$env:DISC_PATH\Cumulative Updates\2021-10 Cumulative Update for Windows 11 for x64-based Systems (KB5006674)\windows10.0-kb5006674-x64_c71b094804f4f592fa810ee9c4484489297c5dfc.msu"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_18362_21.064.42912.0.msi"
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
