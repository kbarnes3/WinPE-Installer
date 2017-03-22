@{

ModuleVersion = '1.0'
GUID = 'fb0293ff-7c0c-4633-8e3e-e1f0d67d9a84'
Author = 'Kevin Barnes'
Copyright = '(c) 2017 Kevin Barnes. All rights reserved.'
Description = 'WinPE creation utilities'

NestedModules = @(
    ".\Drivers.psm1",
    ".\MediaCreation.psm1",
    ".\SourceFiles.psm1",
    ".\Validation.psm1")

FunctionsToExport = @(
    # Drivers.psm1
    "Add-Drivers",

    # MediaCreation.psm1
    "New-WinPEInstallMedia",

    # SourceFiles.psm1
    "Get-ClientIsoPath",
    "Get-EnterpriseIsoPath",
    "Get-ServerIsoPath",
    "Get-CumulativeUpdatePath",
    "Get-SurfaceProDrivers",
    "Get-SurfacePro2Drivers",
    "Get-Surface3Drivers",
    "Get-SurfacePro3Drivers",
    "Get-SurfacePro4Drivers",
    "Get-SurfaceBookDrivers",
    "Get-IntelRapidStorageDrivers",

    # Validation.psm1
    "Confirm-Environment"
    )

CmdletsToExport = @()

VariablesToExport = '*'

AliasesToExport = @()
}

