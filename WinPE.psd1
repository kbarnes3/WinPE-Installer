@{

ModuleVersion = '1.0'
GUID = 'fb0293ff-7c0c-4633-8e3e-e1f0d67d9a84'
Author = 'Kevin Barnes'
Copyright = '(c) 2018 Kevin Barnes. All rights reserved.'
Description = 'WinPE creation utilities'

NestedModules = @(
    ".\BootWim.psm1",
    ".\Drivers.psm1",
    ".\KeepAwake.psm1",
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

    # KeepAwake.psm1
    "Suspend-Suspending",
    "Resume-Suspending",

    # InstallWim.psm1
    "Update-InstallWim",

    # MediaCreation.psm1
    "New-WinPEInstallMedia",

    # SourceFiles.psm1
    "Get-WinPEDriverDir",
    "Get-ConsumerIsoPath",
    "Get-BusinessIsoPath",
    "Get-ServerIsoPath",
    # "Get-ServicingStackUpdatePathFe",
    "Get-CumulativeUpdatePathFe",
    # "Get-ServicingStackUpdatePathCo",
    "Get-CumulativeUpdatePathCo",
    "Get-SurfaceBook2Drivers",
    "Get-SurfaceGo2Drivers",
    "Get-SurfaceGo3Drivers",
    "Get-SurfaceLaptop2Drivers",
    "Get-SurfaceBook3Drivers",
    "Get-SurfaceLaptop3IntelDrivers",
    "Get-SurfaceLaptop3AmdDrivers",
    "Get-SurfaceLaptop4IntelDrivers",
    "Get-SurfaceLaptop4AmdDrivers",
    "Get-SurfaceLaptopGoDrivers",
    "Get-SurfaceLaptopGo2Drivers",
    "Get-SurfaceLaptopStudioDrivers",
    "Get-SurfacePro6Drivers",
    "Get-SurfacePro7Drivers",
    "Get-SurfacePro7PlusDrivers",
    "Get-SurfacePro8Drivers",
    "Get-SurfaceStudio2Drivers",
    "Get-IntelRapidStorageDrivers",

    # Validation.psm1
    "Confirm-Environment"
    )

CmdletsToExport = @()

VariablesToExport = '*'

AliasesToExport = @()
}

