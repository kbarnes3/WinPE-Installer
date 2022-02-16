
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
    return "$env:DISC_PATH\Cumulative Updates\2022-02 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems (KB5010354)\windows10.0-kb5010354-x64_5909c5c0780d9ec96adcfb19d6c0bda8ea224379.msu"
}

# function Get-ServicingStackUpdatePathCo {
#     return ""
# }

function Get-CumulativeUpdatePathCo {
    return "$env:DISC_PATH\Cumulative Updates\2022-02 Cumulative Update for Windows 11 for x64-based Systems (KB5010386)\windows10.0-kb5010386-x64_9bc7e4da6b4cbd58dd713c779a9b74356643d9a1.msu"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_18362_21.101.14869.0.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_18362_21.101.11630.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_18362_21.101.14415.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_18362_21.111.6920.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win11_22000_21.092.22602.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win10_18362_21.091.14218.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win10_18362_21.071.8492.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win11_22000_21.094.40263.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_18362_21.091.03540_0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win10_18363_21.112.16896.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win11_22000_21.122.20178.0.msi"
}
function Get-SurfaceLaptop4IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_intel_Win11_22000_21.121.10179.0.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_amd_Win11_22000_21.111.15693.0.msi"
}

function Get-SurfaceGo3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo3_Win11_22000_21.120.382.0.msi"
}

function Get-SurfaceLaptopStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopStudio_Win11_22000_21.093.32860.0.msi"
}

function Get-SurfacePro8Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro8_Win11_22000_22.013.38579.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
