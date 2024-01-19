function Update-BootWim {
param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir,
    [Parameter(Mandatory=$true)]
    [string]$DriversRoot,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir
)
    $bootWim = Join-Path $WinpeWorkingDir "media\sources\boot.wim"
    $bootWimTemp = Join-Path $WinpeWorkingDir "media\sources\boot2.wim"
    $step = 0

    Set-Progress -CurrentOperation "Mounting boot.wim" -StepNumber $step
    Mount-WindowsImage -ImagePath $bootWim -Index 1 -Path $MountTempDir -ErrorAction Stop | Out-Null
    $step++

    Set-Progress -CurrentOperation "Copying new files" -StepNumber $step
    & robocopy /S /XX "$PSScriptRoot\In Image" $MountTempDir | Out-Null
    $step++

    Set-Progress -CurrentOperation "Adding packages" -StepNumber $step
    Add-Packages -MountTempDir $MountTempDir
    $step++

    Set-Progress -CurrentOperation "Adding drivers" -StepNumber $step
    Add-Drivers -DriversRoot $DriversRoot -MountTempDir $MountTempDir
    $step++

    Set-Progress -CurrentOperation "Cleaning up boot.wim" -StepNumber $step
    & dism "/Cleanup-Image" "/Image:$MountTempDir" "/StartComponentCleanup" "/ResetBase" | Out-Null
    $step++

    Set-Progress -CurrentOperation "Dismounting boot.wim" -StepNumber $step
    Dismount-WindowsImage -Path $MountTempDir -Save | Out-Null
    $step++

    Set-Progress -CurrentOperation "Exporting boot.wim" -StepNumber $step
    Export-WindowsImage -SourceImagePath $bootWim -SourceIndex 1 -DestinationImagePath $bootWimTemp | Out-Null
    Remove-Item $bootWim
    Move-Item $bootWimTemp $bootWim
    $step++

    Set-Progress -StepNumber $step
}
Export-ModuleMember Update-BootWim

function Update-NetbootBootWim {
    param(
        [Parameter(Mandatory=$true)]
        [string]$WinpeWorkingDir,
        [Parameter(Mandatory=$true)]
        [string]$MountTempDir
    )
    $bootWim = Join-Path $WinpeWorkingDir "media\sources\boot.wim"
    $bootWimTemp = Join-Path $WinpeWorkingDir "media\sources\boot2.wim"
    $step = 0

    Set-NetbootProgress -CurrentOperation "Mounting boot.wim" -StepNumber $step
    Mount-WindowsImage -ImagePath $bootWim -Index 1 -Path $MountTempDir -ErrorAction Stop | Out-Null
    $step++

    Set-NetbootProgress -CurrentOperation "Copying new files" -StepNumber $step
    $startPs1 = Get-Content "$PSScriptRoot\In Netboot Image\Windows\System32\Start-PE.ps1"
    Set-Content "$MountTempDir\Windows\System32\Start-PE.ps1" $startPs1
    $step++

    Set-NetbootProgress -CurrentOperation "Cleaning up boot.wim" -StepNumber $step
    & dism "/Cleanup-Image" "/Image:$MountTempDir" "/StartComponentCleanup" "/ResetBase" | Out-Null
    $step++

    Set-NetbootProgress -CurrentOperation "Dismounting boot.wim" -StepNumber $step
    Dismount-WindowsImage -Path $MountTempDir -Save | Out-Null
    $step++

    Set-NetbootProgress -CurrentOperation "Exporting boot.wim" -StepNumber $step
    Export-WindowsImage -SourceImagePath $bootWim -SourceIndex 1 -DestinationImagePath $bootWimTemp | Out-Null
    Remove-Item $bootWim
    Move-Item $bootWimTemp $bootWim
    $step++

    Set-NetbootProgress -StepNumber $step
}
Export-ModuleMember Update-NetbootBootWim

function Add-Packages {
param(
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir
)
    $packages =
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FMAPI.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureStartup.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-SecureStartup_en-us.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-EnhancedStorage.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-EnhancedStorage_en-us.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFx.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFx_en-us.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-DismCmdlets.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureBootCmdlets.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-StorageWMI.cab",
        "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"

    $step = 0

    $packages | % {
        $packageName = Split-Path $_ -Leaf
        Set-PackageProgress -PackageName $packageName -StepNumber $step -TotalSteps $packages.Length
        Add-WindowsPackage  -PackagePath $_ -Path $MountTempDir | Out-Null
        $step++
    }

    Set-PackageProgress -StepNumber $packages.Length -TotalSteps $packages.Length
}

function Add-Drivers {
param(
    [Parameter(Mandatory=$true)]
    [string]$DriversRoot,
    [Parameter(Mandatory=$true)]
    [string]$MountTempDir
)
    $driverDirs = @(Get-Item $(Get-IntelRapidStorageDrivers))
    $driverDirs += $(Get-ChildItem -Path $DriversRoot -Recurse -Filter *GPIO* -Directory)
    $driverDirs += $(Get-ChildItem -Path $DriversRoot -Recurse -Filter *SPI* -Directory)
    $driverDirs += $(Get-ChildItem -Path $DriversRoot -Recurse -Filter *SurfaceHidMini* -Directory)
    $driverDirs += $(Get-ChildItem -Path $DriversRoot -Recurse -Filter *SurfaceSerialHub* -Directory)
    $driverDirs += $(Get-ChildItem -Path $DriversRoot -Recurse -Filter *UART* -Directory)

    $step = 0

    $driverDirs | % {
        Set-DriverProgress -DriverPath $_.FullName -StepNumber $step -TotalSteps $driverDirs.Length
        Add-WindowsDriver -Driver $_.FullName -Path $MountTempDir -Recurse | Out-Null
        $step++
    }

    Set-DriverProgress -StepNumber $driverDirs.Length -TotalSteps $driverDirs.Length
}


function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 7
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    if ($completed) {
        $CurrentOperation = "Done"
    }

    Write-Progress -Id 1 -ParentId 0 -Activity "Configuring boot.wim" -PercentComplete $percent -Status $CurrentOperation -Completed:$completed
}

function Set-NetbootProgress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 5
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    if ($completed) {
        $CurrentOperation = "Done"
    }

    Write-Progress -Id 1 -ParentId 0 -Activity "Configuring boot.wim" -PercentComplete $percent -Status $CurrentOperation -Completed:$completed
}

function Set-PackageProgress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$PackageName,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber,
    [Parameter(Mandatory=$true)]
    [int]$TotalSteps
)
    $currentOperation = "Adding $PackageName"
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($TotalSteps -eq $StepNumber)

    Write-Progress -Id 2 -ParentId 1 -Activity "Adding packages" -PercentComplete $percent -Status $currentOperation -Completed:$completed
}

function Set-DriverProgress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$DriverPath,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber,
    [Parameter(Mandatory=$true)]
    [int]$TotalSteps
)
    $currentOperation = "Adding $DriverPath"
    $percent = $StepNumber / $TotalSteps * 100
    $completed = ($TotalSteps -eq $StepNumber)

    Write-Progress -Id 3 -ParentId 1 -Activity "Adding drivers"  -PercentComplete $percent -Status $currentOperation -Completed:$completed
}
