function Confirm-Environment {
    [CmdletBinding()]
    param (
        [Parameter()]
        [Switch]
        $IgnoreWinPEDriverDir
    )
    if (-Not $env:WinPERoot) {
        throw "Setup-WinPE must be run from a Deployment and Imaging Tools Environment"
    }

    $env:Path += ";C:\Program Files\7-Zip\"

    $SourceFileAccessors = [ordered]@{
        'R:\'                                  = { 'R:\' }
        'Get-ConsumerIsoPath'                  = { Get-ConsumerIsoPath }
        'Get-BusinessIsoPath'                  = { Get-BusinessIsoPath }
        'Get-ServerIsoPath'                    = { Get-ServerIsoPath }
        'Get-AmdRZ616WifiDrivers'              = { Get-AmdRZ616WifiDrivers }
        'Get-AmdRZ717WifiDrivers'              = { Get-AmdRZ717WifiDrivers }
        'Get-IntelNicDrivers'                  = { Get-IntelNicDrivers }
        'Get-IntelWifiDrivers'                 = { Get-IntelWifiDrivers }
        'Get-MarvellNicDrivers'                = { Get-MarvellNicDrivers }
        'Get-SurfaceBook2Drivers'              = { Get-SurfaceBook2Drivers }
        'Get-SurfaceBook3Drivers'              = { Get-SurfaceBook3Drivers }
        'Get-SurfaceGo2Drivers'                = { Get-SurfaceGo2Drivers }
        'Get-SurfaceGo3Drivers'                = { Get-SurfaceGo3Drivers }
        'Get-SurfaceGo4Drivers'                = { Get-SurfaceGo4Drivers }
        'Get-SurfaceLaptop2Drivers'            = { Get-SurfaceLaptop2Drivers }
        'Get-SurfaceLaptop3IntelDrivers'       = { Get-SurfaceLaptop3IntelDrivers }
        'Get-SurfaceLaptop3AmdDrivers'         = { Get-SurfaceLaptop3AmdDrivers }
        'Get-SurfaceLaptop4IntelDrivers'       = { Get-SurfaceLaptop4IntelDrivers }
        'Get-SurfaceLaptop4AmdDrivers'         = { Get-SurfaceLaptop4AmdDrivers }
        'Get-SurfaceLaptop5Drivers'            = { Get-SurfaceLaptop5Drivers }
        'Get-SurfaceLaptop6ForBusinessDrivers' = { Get-SurfaceLaptop6ForBusinessDrivers }
        'Get-SurfaceLaptopForBusiness7Drivers' = { Get-SurfaceLaptopForBusiness7Drivers }
        'Get-SurfaceLaptopForBusiness8Drivers' = { Get-SurfaceLaptopForBusiness8Drivers }
        'Get-SurfaceLaptopForBusiness13Inch1Drivers' = { Get-SurfaceLaptopForBusiness13Inch1Drivers }
        'Get-SurfaceLaptopGoDrivers'           = { Get-SurfaceLaptopGoDrivers }
        'Get-SurfaceLaptopGo2Drivers'          = { Get-SurfaceLaptopGo2Drivers }
        'Get-SurfaceLaptopGo3Drivers'          = { Get-SurfaceLaptopGo3Drivers }
        'Get-SurfaceLaptopStudioDrivers'       = { Get-SurfaceLaptopStudioDrivers }
        'Get-SurfaceLaptopStudio2Drivers'      = { Get-SurfaceLaptopStudio2Drivers }
        'Get-SurfacePro6Drivers'               = { Get-SurfacePro6Drivers }
        'Get-SurfacePro7Drivers'               = { Get-SurfacePro7Drivers }
        'Get-SurfacePro7PlusDrivers'           = { Get-SurfacePro7PlusDrivers }
        'Get-SurfacePro8Drivers'               = { Get-SurfacePro8Drivers }
        'Get-SurfacePro9Drivers'               = { Get-SurfacePro9Drivers }
        'Get-SurfacePro10ForBusinessDrivers'   = { Get-SurfacePro10ForBusinessDrivers }
        'Get-SurfaceProForBusiness11Drivers'   = { Get-SurfaceProForBusiness11Drivers }
        'Get-SurfaceProForBusiness12Drivers'   = { Get-SurfaceProForBusiness12Drivers }
        'Get-SurfaceStudio2Drivers'            = { Get-SurfaceStudio2Drivers }
        'Get-SurfaceStudio2PlusDrivers'        = { Get-SurfaceStudio2PlusDrivers }
        'Get-IntelRapidStorageDrivers'         = { Get-IntelRapidStorageDrivers }
    }

    if (-Not $IgnoreWinPEDriverDir) {
        $SourceFileAccessors['Get-WinPEDriverDir'] = { Get-WinPEDriverDir }
    }

    $errors = New-Object System.Collections.Generic.List[string]

    foreach ($name in $SourceFileAccessors.Keys) {
        $accessor = $SourceFileAccessors[$name]
        $path = $null
        try {
            $path = & $accessor
        }
        catch {
            $message = "$name failed: $_"
            $errors.Add($message)
            Write-Warning $message
            continue
        }

        if (-Not ($path)) {
            $message = "$name returned a null or empty path"
            $errors.Add($message)
            Write-Warning $message
            continue
        }

        if (-Not (Test-Path $path)) {
            $message = "Unable to find $path (from $name)"
            $errors.Add($message)
            Write-Warning $message
            continue
        }
    }

    if ($errors.Count -gt 0) {
        throw "Confirm-Environment found $($errors.Count) validation error(s); see preceding error output for details."
    }

    return $true
}
Export-ModuleMember Confirm-Environment

function Confirm-NetbootEnvironment {
    param (
        [string]$InstallBootWim
    )

    if (-Not (Test-Path $InstallBootWim)) {
        throw "Unable to find $InstallBootWim"
    }

    if (-Not ($env:NETBOOTUNC)) { 
        throw 'Missing $env:NETBOOTUNC'
    }

    if (-Not ($env:NETBOOTUSERNAME)) { 
        throw 'Missing $env:NETBOOTUSERNAME'
    }

    if (-Not ($env:NETBOOTPASSWORD)) { 
        throw 'Missing $env:NETBOOTPASSWORD'
    }

    return $true
}
Export-ModuleMember Confirm-NetbootEnvironment
