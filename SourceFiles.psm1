
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
    return "$env:DISC_PATH\Cumulative Updates\2022-08 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems (KB5016627)\windows10.0-kb5016627-x64_46b7a22c4135299fd98ca9775211cf86e1ef7108.msu"
}

# function Get-ServicingStackUpdatePathCo {
#     return ""
# }

function Get-CumulativeUpdatePathCo {
    return "$env:DISC_PATH\Cumulative Updates\2022-08 Cumulative Update for Windows 11 for x64-based Systems (KB5016629)\windows10.0-kb5016629-x64_5c835cd538774e6191bb98343231c095c7918a72.msu"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_19041_22.080.2839.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win11_22000_22.072.22541.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_18362_22.013.15000_0.msi"
}

function Get-SurfaceGo3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo3_Win11_22000_21.120.382.0.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_19041_22.080.1424.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win11_22000_22.081.11638.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win11_22000_22.020.5648.0.msi"
}

function Get-SurfaceLaptop4IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_intel_Win11_22000_22.042.17187.0.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_amd_Win11_22000_22.030.2733.0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win11_22000_22.021.14347.0.msi"
}

function Get-SurfaceLaptopGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo2_Win10_19044_22.074.40379.0.msi"
}

function Get-SurfaceLaptopStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopStudio_Win11_22000_22.052.22842.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_19041_22.074.41199.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win11_22000_22.032.19761.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win11_22000_22.032.21313.0.msi"
}

function Get-SurfacePro8Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro8_Win11_22000_22.073.30047.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_19041_22.020.2939.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
