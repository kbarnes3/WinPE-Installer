
function Get-WinPEDriverDir {
    return "D:\WinPE_amd64_drivers"
}

$DriversPath = "$env:DISC_PATH\Drivers"

function Find-SourceFile {
[CmdletBinding()]
Param (
    [Parameter()]
    [String]
    $Directory,
    [Parameter()]
    [String]
    $Pattern
)
    $matchingFiles = Get-ChildItem -Path $Directory -Filter $Pattern
    if ($matchingFiles.Count -ne 1) {
        Write-Error "Searching $Directory for $Pattern found $($matchingFiles.Count) matches"
        $matchingFiles | ForEach-Object {
            Write-Error $_.FullName
        }
        throw $False
    }

    return $matchingFiles.FullName
}

function Get-ConsumerIsoPath {
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_11_consumer_editions_version_22h2_updated_sep_2022_x64*.iso"
}

function Get-BusinessIsoPath {
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_11_business_editions_version_22h2_updated_sep_2022_x64*.iso"
}

function Get-ServerIsoPath {
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_server_2022_x64*.iso"
}

function Get-CumulativeUpdatePathFe {
    return "$env:DISC_PATH\Cumulative Updates\2023-07 Cumulative Update for Microsoft server operating system, version 22H2 for x64-based Systems (KB5028171)\windows10.0-kb5028171-x64_df2198a9a9ac5cf4b2d60af6b2c14d5902df0594.msu"
}

function Get-CumulativeUpdatePathNi {
    return "$env:DISC_PATH\Cumulative Updates\2023-07 Cumulative Update for Windows 11 Version 22H2 for x64-based Systems (KB5028185)\windows11.0-kb5028185-x64_c78aa5899ba74efdd0e354dfab80940402b3efa4.msu"
}

function Get-SurfaceBook2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceBook2*.msi"
}

function Get-SurfaceBook3Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceBook3*.msi"
}

function Get-SurfaceGo2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceGo2*.msi"
}

function Get-SurfaceGo3Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceGo3*.msi"
}

function Get-SurfaceLaptop2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop2*.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop3_intel*.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop3_amd*.msi"
}

function Get-SurfaceLaptop4IntelDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop4_intel*.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop4_amd*.msi"
}

function Get-SurfaceLaptop5Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop5*.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopGo_*.msi"
}

function Get-SurfaceLaptopGo2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopGo2*.msi"
}

function Get-SurfaceLaptopStudioDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopStudio*.msi"
}

function Get-SurfacePro6Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfacePro6*.msi"
}

function Get-SurfacePro7Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfacePro7_*.msi"
}

function Get-SurfacePro7PlusDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfacePro7+_*.msi"
}

function Get-SurfacePro8Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfacePro8_*.msi"
}

function Get-SurfacePro9Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfacePro9_*.msi"
}

function Get-SurfaceStudio2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceStudio2_*.msi"
}

function Get-SurfaceStudio2PlusDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceStudio2+_*.msi"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
