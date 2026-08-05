@{

ModuleVersion = '1.0'
GUID = 'fb0293ff-7c0c-4633-8e3e-e1f0d67d9a84'
Author = 'Kevin Barnes'
Copyright = '(c) 2018 Kevin Barnes. All rights reserved.'
Description = 'WinPE creation utilities'

NestedModules = @(
    ".\BootWim.psm1",
    ".\Copype.psm1",
    ".\Drivers.psm1",
    ".\KeepAwake.psm1",
    ".\InstallWim.psm1",
    ".\MediaCreation.psm1",
    ".\NetbootMediaCreation.psm1",
    ".\SourceFiles.psm1",
    ".\Validation.psm1")

FunctionsToExport = @(
    # BootWim.psm1
    "Update-BootWim",
    "Update-NetbootBootWim",

    # Copype.psm1
    "Invoke-Copype",

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

    # NetbootMediaCreation.psm1
    "New-WinPENetbootMedia",

    # SourceFiles.psm1
    "Get-WinPEDriverDir",
    "Get-ConsumerIsoPath",
    "Get-BusinessIsoPath",
    "Get-ServerIsoPath",
    "Get-AmdRZ616WifiDrivers",
    "Get-AmdRZ717WifiDrivers",
    "Get-IntelNicDrivers",
    "Get-IntelWifiDrivers",
    "Get-MarvellNicDrivers",
    "Get-IntelRapidStorageDrivers",

    # Validation.psm1
    "Confirm-Environment",
    "Confirm-NetbootEnvironment"
    )

CmdletsToExport = @()

VariablesToExport = '*'

AliasesToExport = @()
}

