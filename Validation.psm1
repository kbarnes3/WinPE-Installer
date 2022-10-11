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
        (Get-SurfaceLaptop2Drivers),
        (Get-SurfaceLaptop3IntelDrivers),
        (Get-SurfaceLaptop3AmdDrivers),
        (Get-SurfaceLaptop4IntelDrivers),
        (Get-SurfaceLaptop4AmdDrivers),
        (Get-SurfaceLaptopGoDrivers),
        (Get-SurfaceLaptopGo2Drivers),
        (Get-SurfaceLaptopStudioDrivers),
        (Get-SurfacePro6Drivers),
        (Get-SurfacePro7Drivers),
        (Get-SurfacePro7PlusDrivers),
        (Get-SurfacePro8Drivers),
        (Get-SurfaceStudio2Drivers),
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
