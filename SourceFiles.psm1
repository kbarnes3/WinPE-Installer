
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
    $Pattern,
    [Switch]
    $Optional
)
    $matchingFiles = Get-ChildItem -Path $Directory -Filter $Pattern
    if ($Optional -and $matchingFiles.Count -eq 0) {
        return $null
    }
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
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_11_consumer_editions_version_25h2_updated_*_x64_dvd_*.iso"
}

function Get-BusinessIsoPath {
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_11_business_editions_version_25h2_updated_*_x64_dvd_*.iso"
}

function Get-ServerIsoPath {
    return Find-SourceFile -Directory $env:DISC_PATH -Pattern "en-us_windows_server_2025_updated_*_x64_dvd_*.iso"
}

function Get-IntelNicDrivers {
    return Find-SourceFile -Directory $DriversPath -Pattern "Wired_driver_*_x64.zip"
}

function Get-MarvellNicDrivers {
    return "$env:DISC_PATH\Drivers\MarvellACQ"
}

function Get-IntelWifiDrivers {
    return "$env:DISC_PATH\Drivers\Framework_W11_24H2_OOBE_Wifi_Driver_Package\Intel_PROSet_WiFi_23.60.1.2"
}

function Get-AmdRZ616WifiDrivers {
    return "$env:DISC_PATH\Drivers\Framework_W11_24H2_OOBE_Wifi_Driver_Package\RZ616_Wifi_3.4.0.1046"
}

function Get-AmdRZ717WifiDrivers {
    return "$env:DISC_PATH\Drivers\Framework_W11_24H2_OOBE_Wifi_Driver_Package\RZ717_WiFI_5.5.0.3366"
}

function Get-IntelRapidStorageDrivers {
    return "$env:DISC_PATH\Drivers\IRST64"
}

Export-ModuleMember *
