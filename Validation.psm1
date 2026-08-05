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
