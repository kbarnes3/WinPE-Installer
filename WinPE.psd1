@{

ModuleVersion = '1.0'
GUID = 'fb0293ff-7c0c-4633-8e3e-e1f0d67d9a84'
Author = 'Kevin Barnes'
Copyright = '(c) 2018 Kevin Barnes. All rights reserved.'
Description = 'WinPE creation utilities'

NestedModules = @(
    ".\BootWim.psm1",
    ".\Drivers.psm1",
    ".\InstallWim.psm1",
    ".\MediaCreation.psm1",
    ".\SourceFiles.psm1",
    ".\Validation.psm1")

FunctionsToExport = @(
    # BootWim.psm1
    "Update-BootWim",

    # Drivers.psm1
    "Add-Drivers",
    "New-WinPEDriverMedia",

    # InstallWim.psm1
    "Update-InstallWim",

    # MediaCreation.psm1
    "New-WinPEInstallMedia",

    # SourceFiles.psm1
    "Get-WinPEDriverDir",
    "Get-ConsumerIsoPath",
    "Get-BusinessIsoPath",
    "Get-ServerIsoPath",
    "Get-RS5ServicingStackUpdatePath",
    "Get-RS5CumulativeUpdatePath",
    "Get-ServicingStackUpdatePathVb",
    "Get-CumulativeUpdatePathVb",
    "Get-SurfaceProDrivers",
    "Get-SurfacePro2Drivers",
    "Get-Surface3Drivers",
    "Get-SurfacePro3Drivers",
    "Get-SurfacePro4Drivers",
    "Get-SurfaceBookDrivers",
    "Get-SurfaceStudioDrivers",
    "Get-SurfacePro2017Drivers",
    "Get-SurfaceLaptopDrivers",
    "Get-SurfaceBook2Drivers",
    "Get-SurfaceGoDrivers",
    "Get-SurfaceLaptop2Drivers",
    "Get-SurfacePro6Drivers",
    "Get-SurfaceStudio2Drivers",
    "Get-SurfacePro7Drivers",
    "Get-SurfaceLaptop3IntelDrivers",
    "Get-SurfaceLaptop3AmdDrivers",
    "Get-SurfaceBook3Drivers",
    "Get-SurfaceGo2Drivers",
    "Get-SurfaceLaptopGoDrivers",
    "Get-SurfacePro7PlusDrivers",
    "Get-SurfaceLaptop4IntelDrivers",
    "Get-SurfaceLaptop4AmdDrivers",
    "Get-IntelRapidStorageDrivers",

    # Validation.psm1
    "Confirm-Environment"
    )

CmdletsToExport = @()

VariablesToExport = '*'

AliasesToExport = @()
}

