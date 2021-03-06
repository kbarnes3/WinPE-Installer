function New-WinPEDriverMedia {
    $DriverDir = Get-WinPEDriverDir
    $step = 0

    Start-Process KeepAwake.exe -WindowStyle Minimized

    Set-Progress -CurrentOperation "Validating required source files" -StepNumber $step
    Confirm-Environment -IgnoreWinPEDriverDir -ErrorAction Stop | Out-Null
    $step++

    Set-Progress -CurrentOperation "Removing existing drivers" -StepNumber $step
    if (Test-Path $DriverDir) {
        Remove-Item $DriverDir -Recurse -Force
    }
    $step++
    
    Set-Progress -CurrentOperation "Adding drivers" -StepNumber $step
    Add-Drivers -WinpeWorkingDir $DriverDir
    $step++

    Set-Progress -CurrentOperation "Copying scripts" -StepNumber $step
    & robocopy "/S" "/XX" "$PSScriptRoot\Driver Disk" "$(Join-Path $DriverDir "media")" | Out-Null
    $step++

    Push-Location $DriverDir
    $driverIsoPath = Join-Path $DriverDir "winpe-drivers.iso"

    Set-Progress -CurrentOperation "Creating winpe-drivers.iso" -StepNumber $step
    & oscdimg -u1 -udfver102 ".\media" $driverIsoPath | Out-Null
    $step++

    Set-Progress -CurrentOperation "Copying winpe-drivers.iso to $env:DISC_PATH" -StepNumber $step
    $isoDestination = Join-Path $env:DISC_PATH "winpe-drivers.iso"
    Start-BitsTransfer -Source $driverIsoPath -Destination $isoDestination
    $step++

    Set-Progress -StepNumber $step
    Write-Host "All done!"
    Write-Host "To create or update a bootable USB drive,"
    Write-Host "please see this project's README.md"

    Stop-Process -Name KeepAwake -ErrorAction SilentlyContinue
    Push-Location $PSScriptRoot
}
Export-ModuleMember New-WinPEDriverMedia

function Add-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$WinpeWorkingDir
)
    $driversScripts = Join-Path $WinpeWorkingDir "media\Scripts\Drivers"
    $driversRoot = Join-Path $WinpeWorkingDir "media\Drivers"

    New-Item -Path $driversScripts -ItemType Directory | Out-Null
    New-Item -Path $DriversRoot -ItemType Directory | Out-Null

    Extract-Drivers -DriversScripts $driversScripts -DriversRoot $driversRoot

}
Export-ModuleMember Add-Drivers

function Extract-Drivers {
Param(
    [Parameter(Mandatory=$true)]
    [string]$DriversScripts,
    [Parameter(Mandatory=$true)]
    [string]$DriversRoot
    )

    $devices =
        @{"friendlyName" = "Surface Pro"; "source" = Get-SurfaceProDrivers},
        @{"friendlyName" = "Surface Pro 2"; "source" = Get-SurfacePro2Drivers},
        @{"friendlyName" = "Surface 3"; "source" = Get-Surface3Drivers},
        @{"friendlyName" = "Surface Pro 3"; "source" = Get-SurfacePro3Drivers},
        @{"friendlyName" = "Surface Pro 4"; "source" = Get-SurfacePro4Drivers},
        @{"friendlyName" = "Surface Book"; "source" = Get-SurfaceBookDrivers},
        @{"friendlyName" = "Surface Studio"; "source" = Get-SurfaceStudioDrivers},
        @{"friendlyName" = "Surface Pro (2017)"; "source" = Get-SurfacePro2017Drivers},
        @{"friendlyName" = "Surface Laptop"; "source" = Get-SurfaceLaptopDrivers},
        @{"friendlyName" = "Surface Book 2"; "source" = Get-SurfaceBook2Drivers},
        @{"friendlyName" = "Surface Go"; "source" = Get-SurfaceGoDrivers},
        @{"friendlyName" = "Surface Laptop 2"; "source" = Get-SurfaceLaptop2Drivers},
        @{"friendlyName" = "Surface Pro 6"; "source" = Get-SurfacePro6Drivers},
        @{"friendlyName" = "Surface Studio 2"; "source" = Get-SurfaceStudio2Drivers},
        @{"friendlyName" = "Surface Pro 7"; "source" = Get-SurfacePro7Drivers},
        @{"friendlyName" = "Surface Laptop 3 (Intel)"; "source" = Get-SurfaceLaptop3IntelDrivers},
        @{"friendlyName" = "Surface Laptop 3 (AMD)"; "source" = Get-SurfaceLaptop3AmdDrivers},
        @{"friendlyName" = "Surface Book 3"; "source" = Get-SurfaceBook3Drivers},
        @{"friendlyName" = "Surface Go 2"; "source" = Get-SurfaceGo2Drivers},
        @{"friendlyName" = "Surface Laptop Go"; "source" = Get-SurfaceLaptopGoDrivers},
        @{"friendlyName" = "Surface Pro 7+"; "source" = Get-SurfacePro7PlusDrivers},
        @{"friendlyName" = "Surface Laptop 4 (Intel)"; "source" = Get-SurfaceLaptop4IntelDrivers},
        @{"friendlyName" = "Surface Laptop 4 (AMD)"; "source" = Get-SurfaceLaptop4AmdDrivers}

    for ($i = 0; $i -lt $devices.Length; $i++) {
        $device = $devices[$i]
        $friendlyName = $device["friendlyName"]
        $source = $device["source"]
        Set-ExtractProgress -FriendlyName $friendlyName -StepNumber $i -TotalSteps $devices.Length
        $shortName = $friendlyName
        $shortName = $shortName.replace(" ","")
        $shortName = $shortName.replace("(","")
        $shortName = $shortName.replace(")","")
        $driversMountPath = "\Drivers\$shortName"

        $destination = Join-Path $driversRoot $shortName
        $extension = [IO.Path]::GetExtension($source)

        if ($extension.ToLower() -eq ".msi") {
            & msiexec "/a" "$source" "targetdir=$($destination)" "/qn" | Out-Null
        }
        else
        {
            & 7z x "$source" "-o$($destination)" | Out-Null
        }

        $script = Join-Path $driversScripts "$shortName.ps1"
        Set-Content $script "Write-Host `"Adding $friendlyName drivers. This may take a few minutes.`""
        Add-Content $script "New-Item -Path W:\DismScratch -Type Directory | Out-Null"
        Add-Content $script "Add-WindowsDriver -Path W: -Driver $driversMountPath -Recurse -ScratchDirectory `"W:\DismScratch`""
        Add-Content $script "Remove-Item -Recurse -Force W:\DismScratch"
        Add-Content $script "Write-Host `"$friendlyName drivers added. `""
        Add-Content $script "Write-Host `"Run '`" -NoNewline"
        Add-Content $script "Write-Host `"wpeutil shutdown`" -ForegroundColor Yellow -NoNewline "
        Add-Content $script "Write-Host `"' or '`" -NoNewline"
        Add-Content $script "Write-Host `"wpeutil reboot`" -ForegroundColor Yellow -NoNewline"
        Add-Content $script "Write-Host `"'.`""
    }
    Set-ExtractProgress -StepNumber $devices.Length -TotalSteps $devices.Length
}

function Set-Progress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$CurrentOperation,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber
)
    $totalSteps = 6
    $percent = $StepNumber / $totalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Step $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 0 -Activity "Generating WinPE Drivers" -CurrentOperation $CurrentOperation -PercentComplete $percent -Status $status -Completed:$completed
}

function Set-ExtractProgress
{
Param(
    [Parameter(Mandatory=$false)]
    [string]$FriendlyName,
    [Parameter(Mandatory=$true)]
    [int]$StepNumber,
    [Parameter(Mandatory=$true)]
    [int]$TotalSteps
)
    $currentOperation = $null
    if ($FriendlyName) {
        $currentOperation = "Adding $FriendlyName drivers"
    }
    $percent = $StepNumber / $TotalSteps * 100
    $completed = ($totalSteps -eq $StepNumber)
    $status = "Device $($StepNumber + 1) of $totalSteps"

    Write-Progress -Id 1 -Activity " " -CurrentOperation $currentOperation -PercentComplete $percent -Status $status -Completed:$completed
}


