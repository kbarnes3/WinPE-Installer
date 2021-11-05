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
        # (Get-ServicingStackUpdatePathFe),
        (Get-CumulativeUpdatePathFe),
        # (Get-ServicingStackUpdatePathCo),
        (Get-CumulativeUpdatePathCo),
        (Get-SurfaceBook2Drivers),
        (Get-SurfaceLaptop2Drivers),
        (Get-SurfacePro6Drivers),
        (Get-SurfaceStudio2Drivers),
        (Get-SurfacePro7Drivers),
        (Get-SurfaceLaptop3IntelDrivers),
        (Get-SurfaceLaptop3AmdDrivers),
        (Get-SurfaceBook3Drivers),
        (Get-SurfaceGo2Drivers),
        (Get-SurfaceLaptopGoDrivers),
        (Get-SurfacePro7PlusDrivers),
        (Get-SurfaceLaptop4IntelDrivers),
        (Get-SurfaceLaptop4AmdDrivers),
        (Get-SurfaceGo3Drivers),
        (Get-SurfaceLaptopStudioDrivers),
        (Get-SurfacePro8Drivers),
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
