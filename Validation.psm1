function Confirm-Environment {
    if (-Not $env:WinPERoot) {
        throw "Setup-WinPE must be run from a Deployment and Imaging Tools Environment"
    }

    $SourceFiles =
        (Get-ClientIsoPath),
        (Get-EnterpriseIsoPath),
        (Get-ServerIsoPath),
        (Get-CumulativeUpdatePath),
        (Get-SurfaceProDrivers),
        (Get-SurfacePro2Drivers),
        (Get-Surface3Drivers),
        (Get-SurfacePro3Drivers),
        (Get-SurfacePro4Drivers),
        (Get-SurfaceBookDrivers),
        (Get-IntelRapidStorageDrivers)

    $SourceFiles | % {
        if (-Not (Test-Path $_)) {
            throw "Unable to find $_"
        }
    }

    Write-Host "All required files exist!"
    return $true
}
Export-ModuleMember Confirm-Environment
