function Confirm-Environment {
    if (-Not $env:WinPERoot) {
        throw "Setup-WinPE must be run from a Deployment and Imaging Tools Environment"
    }

    $SourceFiles =
        ("R:\"),
        (Get-ConsumerIsoPath),
        (Get-BusinessIsoPath),
        (Get-ServerIsoPath),
        (Get-RS1ServicingStackUpdatePath),
        (Get-RS1CumulativeUpdatePath),
        (Get-RS4CumulativeUpdatePath),
        (Get-SurfaceProDrivers),
        (Get-SurfacePro2Drivers),
        (Get-Surface3Drivers),
        (Get-SurfacePro3Drivers),
        (Get-SurfacePro4Drivers),
        (Get-SurfaceBookDrivers),
        (Get-SurfaceStudioDrivers),
        (Get-SurfacePro2017Drivers),
        (Get-SurfaceLaptopDrivers),
        (Get-SurfaceBook2Drivers),
        (Get-IntelRapidStorageDrivers)

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
