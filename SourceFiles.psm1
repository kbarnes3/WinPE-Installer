
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
    return "$env:DISC_PATH\Cumulative Updates\2022-03 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems (KB5011497)\windows10.0-kb5011497-x64_3e15453734e0a710394694477035bf367237687e.msu"
}

# function Get-ServicingStackUpdatePathCo {
#     return ""
# }

function Get-CumulativeUpdatePathCo {
    return "$env:DISC_PATH\Cumulative Updates\2022-03 Cumulative Update for Windows 11 for x64-based Systems (KB5011493)\windows10.0-kb5011493-x64_fdcdaf1dc56a59fce0b78612ada4748a7e30b66a.msu"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_19041_22.023.33295.0.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_19041_22.021.14301.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_19041_22.020.4173.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_19041_22.020.2939.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win11_22000_22.011.9935.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win11_22000_22.011.9779.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win11_22000_22.020.5648.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win11_22000_21.094.40263.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_18362_22.013.15000_0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win11_22000_22.021.14347.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win11_22000_22.012.28496.0.msi"
}
function Get-SurfaceLaptop4IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_intel_Win11_22000_22.011.9895.0.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_amd_Win11_22000_22.030.2733.0.msi"
}

function Get-SurfaceGo3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo3_Win11_22000_21.120.382.0.msi"
}

function Get-SurfaceLaptopStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopStudio_Win11_22000_22.013.34609.0.msi"
}

function Get-SurfacePro8Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro8_Win11_22000_22.011.9739.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
