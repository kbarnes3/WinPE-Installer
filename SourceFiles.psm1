
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
    return "$env:DISC_PATH\Cumulative Updates\2022-11 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems (KB5019081)\windows10.0-kb5019081-x64_b86ce8b493635483eb736473032971c0aa985606.msu"
}

function Get-CumulativeUpdatePathNi {
    return "$env:DISC_PATH\Cumulative Updates\2022-11 Cumulative Update for Windows 11 Version 22H2 for x64-based Systems (KB5019980)\windows11.0-kb5019980-x64_8c5c341ffaa52f1e832bbd2a9acc5072c52b89fe.msu"
}

function Get-SurfaceBook2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook2_Win10_19041_22.080.2839.0.msi"
}

function Get-SurfaceBook3Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceBook3_Win11_22000_22.100.5730.0.msi"
}

function Get-SurfaceGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceGo2_Win10_18362_22.083.26850_0.msi"
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
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_intel_Win11_22000_22.093.37381.0.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop4_amd_Win11_22000_22.093.29929.0.msi"
}

function Get-SurfaceLaptop5Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptop5_Win11_22621_22.102.17243.0.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo_Win11_22000_22.021.14347.0.msi"
}

function Get-SurfaceLaptopGo2Drivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopGo2_Win10_19044_22.074.40379.0.msi"
}

function Get-SurfaceLaptopStudioDrivers {
    return "$env:DISC_PATH\Drivers\SurfaceLaptopStudio_Win11_22000_22.092.24034.0.msi"
}

function Get-SurfacePro6Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro6_Win10_19041_22.074.41199.0.msi"
}

function Get-SurfacePro7Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7_Win11_22000_22.094.40075.0.msi"
}

function Get-SurfacePro7PlusDrivers {
    return "$env:DISC_PATH\Drivers\SurfacePro7+_Win11_22000_22.093.33213.0.msi"
}

function Get-SurfacePro8Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro8_Win11_22000_22.073.30047.0.msi"
}

function Get-SurfacePro9Drivers {
    return "$env:DISC_PATH\Drivers\SurfacePro9_Win11_22621_22.101.15506.0.msi"
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
