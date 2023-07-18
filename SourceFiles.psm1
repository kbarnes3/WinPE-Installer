
function Get-WinPEDriverDir {
    return "D:\WinPE_amd64_drivers"
}

function Get-ConsumerIsoPath {
    return "$env:DISC_PATH\en-us_windows_11_consumer_editions_version_22h2_updated_sep_2022_x64_dvd_f408dad5.iso"
}

function Get-BusinessIsoPath {
    return "$env:DISC_PATH\en-us_windows_11_business_editions_version_22h2_updated_sep_2022_x64_dvd_840da535.iso"
}

function Get-ServerIsoPath {
    return "$env:DISC_PATH\en-us_windows_server_2022_x64_dvd_620d7eac.iso"
}

function Get-CumulativeUpdatePathFe {
    return "$env:DISC_PATH\Cumulative Updates\2023-07 Cumulative Update for Microsoft server operating system, version 22H2 for x64-based Systems (KB5028171)\windows10.0-kb5028171-x64_df2198a9a9ac5cf4b2d60af6b2c14d5902df0594.msu"
}

function Get-CumulativeUpdatePathNi {
    return "$env:DISC_PATH\Cumulative Updates\2023-07 Cumulative Update for Windows 11 Version 22H2 for x64-based Systems (KB5028185)\windows11.0-kb5028185-x64_c78aa5899ba74efdd0e354dfab80940402b3efa4.msu"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win11_22000_23.060.1495.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win11_22000_23.041.6652.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_19042_23.024.31080_0.msi"
}

function Get-SurfaceGo3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo3_Win11_22000_23.060.1210.0.msi"
}

function Get-SurfaceLaptop2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop2_Win10_19041_22.080.1424.0.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_intel_Win11_22000_23.034.44302.0.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop3_amd_Win11_22000_22.020.5648.0.msi"
}

function Get-SurfaceLaptop4IntelDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_intel_Win11_22000_23.042.26034.0.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_amd_Win11_22000_22.101.7108.0.msi"
}

function Get-SurfaceLaptop5Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop5_Win11_22621_22.102.17243.0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win11_22000_23.051.14656.0.msi"
}

function Get-SurfaceLaptopGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo2_Win10_19044_23.040.1114.0.msi"
}

function Get-SurfaceLaptopStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopStudio_Win11_22000_23.042.24585.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win11_22000_23.060.62.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win11_22000_23.013.33004.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win11_22000_23.062.17311.0.msi"
}

function Get-SurfacePro8Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro8_Win11_22000_23.062.19726.0.msi"
}

function Get-SurfacePro9Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro9_Win11_22621_23.044.40352.0.msi"
}

function Get-SurfaceStudio2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2_Win10_19041_22.020.2939.0.msi"
}

function Get-SurfaceStudio2PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceStudio2+_Win11_22621_22.103.32476.0.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
