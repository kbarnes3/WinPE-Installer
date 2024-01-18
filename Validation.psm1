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

    $SourceFiles =
        ("R:\"),
        (Get-ConsumerIsoPath),
        (Get-BusinessIsoPath),
        (Get-ServerIsoPath),
        (Get-CumulativeUpdatePathFe),
        (Get-CumulativeUpdatePathNi),
        (Get-SurfaceBook2Drivers),
        (Get-SurfaceBook3Drivers),
        (Get-SurfaceGo2Drivers),
        (Get-SurfaceGo3Drivers),
        (Get-SurfaceGo4Drivers),
        (Get-SurfaceLaptop2Drivers),
        (Get-SurfaceLaptop3IntelDrivers),
        (Get-SurfaceLaptop3AmdDrivers),
        (Get-SurfaceLaptop4IntelDrivers),
        (Get-SurfaceLaptop4AmdDrivers),
        (Get-SurfaceLaptop5Drivers),
        (Get-SurfaceLaptopGoDrivers),
        (Get-SurfaceLaptopGo2Drivers),
        (Get-SurfaceLaptopGo3Drivers),
        (Get-SurfaceLaptopStudioDrivers),
        (Get-SurfaceLaptopStudio2Drivers),
        (Get-SurfacePro6Drivers),
        (Get-SurfacePro7Drivers),
        (Get-SurfacePro7PlusDrivers),
        (Get-SurfacePro8Drivers),
        (Get-SurfacePro9Drivers),
        (Get-SurfaceStudio2Drivers),
        (Get-SurfaceStudio2PlusDrivers),
        (Get-IntelRapidStorageDrivers)

    if (-Not $IgnoreWinPEDriverDir) {
        $SourceFiles += (Get-WinPEDriverDir)
    }

    $SourceFiles | % {
        if (-Not ($_))
        {
            throw "Path is null"
        }
        if (-Not (Test-Path $_)) {
            throw "Unable to find $_"
        }
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