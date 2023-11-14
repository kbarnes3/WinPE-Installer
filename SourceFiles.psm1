
function Get-WinPEDriverDir {
    return "D:\WinPE_amd64_drivers"
}

$CumulativeUpdatesPath = "$env:DISC_PATH\Cumulative Updates"
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
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_11_consumer_editions_version_23h2_x64_*.iso"
}

function Get-BusinessIsoPath {
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_11_business_editions_version_23h2_x64_*.iso"
}

function Get-ServerIsoPath {
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_server_2022_x64_*.iso"
}

function Get-CumulativeUpdatePathFe {
    $directory = Find-SourceFile -Directory $CumulativeUpdatesPath -Pattern '*Cumulative Update for Microsoft server operating system, version 22H2 for x64-based Systems*'
    return Find-SourceFile -Directory $directory -Pattern '*.msu'
}

function Get-CumulativeUpdatePathNi {
    $directory = Find-SourceFile -Directory $CumulativeUpdatesPath -Pattern '*Cumulative Update for Windows 11 Version 23H2 for x64-based Systems*'
    return Find-SourceFile -Directory $directory -Pattern '*.msu'
}

function Get-SurfaceBook2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceBook2_*.msi"
}

function Get-SurfaceBook3Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceBook3_*.msi"
}

function Get-SurfaceGo2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceGo2_*.msi"
}

function Get-SurfaceGo3Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceGo3_*.msi"
}

function Get-SurfaceGo4Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceGo4_*.msi"
}

function Get-SurfaceLaptop2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop2_*.msi"
}

function Get-SurfaceLaptop3IntelDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop3_intel_*.msi"
}

function Get-SurfaceLaptop3AmdDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop3_amd_*.msi"
}

function Get-SurfaceLaptop4IntelDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop4_intel_*.msi"
}

function Get-SurfaceLaptop4AmdDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop4_amd_*.msi"
}

function Get-SurfaceLaptop5Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptop5_*.msi"
}

function Get-SurfaceLaptopGoDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopGo_*.msi"
}

function Get-SurfaceLaptopGo2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopGo2_*.msi"
}

function Get-SurfaceLaptopGo3Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopGo3_*.msi"
}

function Get-SurfaceLaptopStudioDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopStudio_*.msi"
}

function Get-SurfaceLaptopStudio2Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfaceLaptopStudio2_*.msi"
}

function Get-SurfacePro6Drivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "SurfacePro6_*.msi"
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
